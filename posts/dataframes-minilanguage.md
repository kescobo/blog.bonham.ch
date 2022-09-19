+++
using Dates

title = "The DataFrames.jl mini-language just clicked"
date = Date("2022-09-10")
draft = false
category = "research"
tags = ["julia", "code", "dataframes"]

rss_descr = "The mini-language is complicated, but powerful"
rss_title = title
+++


I use [DataFrames.jl](https://dataframes.juliadata.org/stable/) *all* the time.
It's incredibly well engineered, well-tested, and fast!
But there's one aspect that's eluded me for a while,
and that's the "mini-language" that's used for `transform`ations
and `combine`ing grouped DataFrames.
I could use it for basic stuff, but for anything even moderately complicated,
I'd have to puzzle over the documentation and then go through endless
rounds of trial and error.

[This blog post](https://www.juliabloggers.com/dataframes-jl-minilanguage-explained/) by the primary architect of `DataFrames.jl`
covers everything I'm about to say comprehensively -
I've read it several times, and it is very clear.

But something just clicked for me in a way it never has before - not sure entirely how,
but I did something complicated in one go!
So I thought I'd share the way it makes sense to me
in case there are others with similar brains to mine :wink:.
Before I get to that, I should say a few things about `DataFrame`s,
`GroupedDataFrame`s, and the basic `select()`, `transform()`, and `combine()`
invocations.

## The easy stuff

One of the more powerful features of `DataFrames.jl` is the ability to
make a `GroupedDataFrame` using one or more columns as "keys".
Each subgroup is then just a view into the original `DataFrame`,
but acts like a `DataFrame` in its own right.

So to set this up, let's make a `df` that's similar
to what I've been working with recently -
a table of metadata about individual patient visits
Each `subject` may come in multiple times,
and get a few different things measured.
In my case, I'm most interested in visits where the subjects
collected a stool sample that I have microbiome data for.

```julia-repl
julia> df = DataFrame(
           subject = repeat(1:3; inner = 4),
           timepoint = repeat(1:4; outer = 3),
           thing1 = rand(12),
           thing2 = rand(60:100, 12),
           sample = [missing, missing, "s1", "s2", "s10", missing, "s13", "s20", missing, missing, missing, missing]
       )
12×5 DataFrame
 Row │ subject  timepoint  thing1    thing2  sample
     │ Int64    Int64      Float64   Int64   String?
─────┼───────────────────────────────────────────────
   1 │       1          1  0.514054      90  missing
   2 │       1          2  0.778417      60  missing
   3 │       1          3  0.157212      91  s1
   4 │       1          4  0.27137       69  s2
   5 │       2          1  0.867191      67  s10
   6 │       2          2  0.254406      78  missing
   7 │       2          3  0.925755      77  s13
   8 │       2          4  0.060332      87  s20
   9 │       3          1  0.9863        81  missing
  10 │       3          2  0.183848      98  missing
  11 │       3          3  0.190012      77  missing
  12 │       3          4  0.300867      71  missing
```

Often we want to get summaries on a per-subject basis,
or do other things within just the samples.
Using `groupby` and `combine`, this is quite easy.

```julia-repl
julia> gdf = groupby(df, :subject);

julia> combine(gdf,
           "thing1" => mean,
           "thing2" => median,
           "sample" => (col -> any(!ismissing, col)) => "has_sample"
       )
3×4 DataFrame
 Row │ subject  thing1_mean  thing2_median  has_sample
     │ Int64    Float64      Float64        Bool
─────┼─────────────────────────────────────────────────
   1 │       1     0.430263           79.5        true
   2 │       2     0.526921           77.5        true
   3 │       3     0.415257           79.0       false
```

The "mini-language" is the bits with `=>`.
Each operation works on columns,
so `"thing1" => mean` returns `mean(subdf.thing1)`
for each of the `SubDataFrame`s
(I could also have done `"thing1" => mean => "other name"`
to change the name of the resulting column).

My operation on `"sample"` doesn't have a built-in function to apply,
but using "anonymous" functions is pretty straightforward in this context -
just remember that you're function argument is the *column* (as a vector).
That is, writing `(col -> any(!ismissing, col))` as above is equivalent
to writing a named function that takes one column as an argument, eg:

```julia-repl
julia> function has_sample(col)
           # any elements of the column are not missing
           return any(!ismissing, col)
       end
has_sample (generic function with 1 method)

julia> combine(gdf, "sample" => has_sample => "has_sample")
3×2 DataFrame
 Row │ subject  has_sample
     │ Int64    Bool
─────┼─────────────────────
   1 │       1        true
   2 │       2        true
   3 │       3       false
```

Another thing I do frequently is some per-column transformations.
To be consistent, `transform` operations also work on whole-columns.
Most of the time, I want to do things with `transform()` on individual rows,
but happily there's a conventient `ByRow()` constructor that makes this easy,
and having access to the whole column can sometimes be useful.
For example, if I want to get the "relative abundance" (or total sum scaled result):

```julia-repl
julia> transform(gdf,
           "thing1" => ByRow(x-> x*100) => "thing1_perc",
           "thing2" => (col-> map(el-> el / sum(col), col)) => "thing2_tss" # total sum scale
       )
12×7 DataFrame
 Row │ subject  timepoint  thing1    thing2  sample   thing1_perc  thing2_tss
     │ Int64    Int64      Float64   Int64   String?  Float64      Float64
─────┼────────────────────────────────────────────────────────────────────────
   1 │       1          1  0.514054      90  missing      51.4054    0.290323
   2 │       1          2  0.778417      60  missing      77.8417    0.193548
   3 │       1          3  0.157212      91  s1           15.7212    0.293548
   4 │       1          4  0.27137       69  s2           27.137     0.222581
   5 │       2          1  0.867191      67  s10          86.7191    0.216828
   6 │       2          2  0.254406      78  missing      25.4406    0.252427
   7 │       2          3  0.925755      77  s13          92.5755    0.249191
   8 │       2          4  0.060332      87  s20           6.0332    0.281553
   9 │       3          1  0.9863        81  missing      98.63      0.247706
  10 │       3          2  0.183848      98  missing      18.3848    0.299694
  11 │       3          3  0.190012      77  missing      19.0012    0.235474
  12 │       3          4  0.300867      71  missing      30.0867    0.217125
```

## Getting complicated

OK, so I think that stuff is pretty straightforward,
but what if we want to do something more complicated,
maybe involving more than one column and their interactions?
For example, one thing I wanted to do recently was to check a
*future* value for a given stool sample. For example, I want

1. If a timepoint doesn't have a stool sample, ignore
2. Otherwise, find the *next* timepoint that has `thing1`
   and use that value (even if *that* timepoint *doesn't* have a stool sample), BUT
3. my timepoints aren't guaranteed to be in order, AND
4. I'm not guaranteed to have a measurement in the future, or it may not be the next timepoint.

So let's show off some of those complications a bit:

```julia-repl
julia> df.thing1 = [rand() < 0.4 ? missing : x for x in df.thing1];

julia> df = df[randperm(12), :];

julia> gdf = groupby(df, :subject)
GroupedDataFrame with 3 groups based on key: subject
First Group (4 rows): subject = 1
 Row │ subject  timepoint  thing1          thing2  sample
     │ Int64    Int64      Float64?        Int64   String?
─────┼─────────────────────────────────────────────────────
   1 │       1          4  missing             69  s2
   2 │       1          1  missing             90  missing
   3 │       1          3        0.157212      91  s1
   4 │       1          2  missing             60  missing
⋮
Last Group (4 rows): subject = 3
 Row │ subject  timepoint  thing1          thing2  sample
     │ Int64    Int64      Float64?        Int64   String?
─────┼─────────────────────────────────────────────────────
   1 │       3          2  missing             98  missing
   2 │       3          1        0.9863        81  missing
   3 │       3          3        0.190012      77  missing
   4 │       3          4        0.300867      71  missing
```

To make this work, we need to know about the `AsTable()` modifier for `transform`,
which gives us a `NamedTuple` to work with for each group,
where each key contains a column.
That is `AsTable("timepoint", "thing1", "sample")` will effectively give us

```
julia> (; timepoint = gdf[1].timepoint, thing1 = gdf[1].thing1, sample = gdf[1].sample)
(timepoint = [4, 1, 3, 2], thing1 = Union{Missing, Float64}[missing, missing, 0.15721238855765696, missing], sample = Union{Missing, String}["s2", missing, "s1", missing])
```

Two more things to be aware of: first, for complicated anonymous functions, we can use `begin .. end` syntax
to make things more manageable, even within another function. That is:

```
args -> begin
    # function body
end
```

and second, our result needs to be a vector or another `Table`-compatible object
(like a Namedtuple with columns) that has the same length as the original.

We these things in mind, check this out... I didn't get it on the first try, but it was close..


```julia-repl
julia> transform!(gdf, AsTable(["timepoint", "thing1", "sample"]) => nt -> begin
           futures = map(eachindex(nt.timepoint)) do i # loop through row indexes
               timepoint = nt.timepoint
               srt = sortperm(timepoint) # so we can get the right order
               sample = nt.sample
               thing1 = nt.thing1

               ismissing(sample[i]) && return missing # (1) if there's no sample, ignore
               fidx = findfirst(j -> timepoint[srt][j] > timepoint[i] && # Checks the sorted timepoint index to make sure it's bigger
                                     !ismissing(thing1[srt][j]), # checks that `thing1` (sorted by timepoint) has a value
                                eachindex(timepoint) # using indexes in case samples are something like [1,3,4,6]
                )
               isnothing(fidx) && return missing
               return thing1[srt][fidx]
           end
           return futures
       end => "future_thing1");

julia> sort(df, ["subject", "timepoint"]) # just to check
12×6 DataFrame
 Row │ subject  timepoint  thing1          thing2  sample   timepoint_thing1_sample_function
     │ Int64    Int64      Float64?        Int64   String?  Float64?
─────┼───────────────────────────────────────────────────────────────────────────────────────
   1 │       1          1  missing             90  missing                    missing
   2 │       1          2  missing             60  missing                    missing
   3 │       1          3        0.157212      91  s1                         missing
   4 │       1          4  missing             69  s2                         missing
   5 │       2          1  missing             67  s10                              0.925755
   6 │       2          2  missing             78  missing                    missing
   7 │       2          3        0.925755      77  s13                              0.060332
   8 │       2          4        0.060332      87  s20                        missing
   9 │       3          1        0.9863        81  missing                    missing
  10 │       3          2  missing             98  missing                    missing
  11 │       3          3        0.190012      77  missing                    missing
  12 │       3          4        0.300867      71  missing                    missing
```

We ca see that row 5 `(; subject = 2, timepoint = 1)`
correctly gets its future score from timepoint 3 (row 7)
since timepoint 2 didn't have a score,
Subjects 1 and 3 don't have any stool samples with a valid future `thing1`.

This feels complicated, but honestly, it's way easier than a number of other things I tried,
more robust, and faster too!
It takes a bit of thinking functionally, and one needs to remember the business with `NamedTuple`s,
but after that, it's actually straightforward... famous last words!