Hello Sarah and David,

I am one of your liberal listeners -
I mostly disagree with you all, but I appreciate that your positions
seem to come from having a prfoundly different world view
rather than a disregard for facts and logic.
And I'm not a lawyer, so most of the time,
I don't feel like I have the expertise to disagree,
but when you start talking data,
that's my jam!

Recently, you discussed Sarah's political piece
using SVD to analyze supreme court decisions -
I read it and replicated the analysis,
and I'm afraid it actually undermines Sarah's argument
(or at least the argument I think she's making)
rather than bolstering it.

First, let me state the argument that I hear Sarah making -
it seems to be something like

> The decisions of the supreme course are less ideological than people assume.
  It's not 6-3 court, it's a 3-3-3 court, where institutional commitments
  dictate decisions at least as much as ideological ones.

I'm not totally sure about "at least as much" -
I can't exactly what weight Sarah would put on
her "ideological" vs "institutional" axes,
but I believe that she thinks they are at least pretty close in effect.

The SVD analysis in the article certainly seems to bolster this position -
when plotted, the justice clusters seem to form an equilateral triangle,
with the distances along the first and second axes
roughly corresponding to Sarah's priors about ideology and institutionalism.
To illustrate why this plot is misleading,
here's a plot of the latitude and longitude of
Houston (red), Nashville (purple), and Beijing (blue).

```julia
using DataFrames
using CairoMakie

latlong = DataFrame(
    city = ["houston", "nashville", "beijing"],
    latitude = [29.76328, 36.174465, 39.90419990],
    longitude = [-95.36327, -86.76796, 116.40739630]
)

scatter(latlong.longitude, latlong.latitude; color = [:red,:purple,:blue],
    axis = (; xlabel = "latitude", ylabel="longitude"))
save("/home/kevin/Downloads/latlong.png", current_figure())
```

Here, it looks like Beijing is about twice the distance
from Nashville as Nashville is from Houston.
In fact, it's about 10 times as far.
This is because the axes have completely different scales -
this is what it looks like if they're plotted on the same scale[^scale]:

```julia
scatter(latlong.longitude, latlong.latitude; color = [:red,:purple,:blue],
    axis = (; xlabel = "latitude", ylabel="longitude", aspect=DataAspect()))
save("/home/kevin/Downloads/latlong2.png", current_figure())
```

The SVD plot in your article has a similar problem[^problem] -
the X axis and y axis have different scales.
I will illustrate with a slightly different kind of analysis
called Principal Component Analysis (PCA),
but PCA and SVD are highly related and they ultimately
amount to the same thing in this context[^pcavsvd].

Here's the way you plotted it:

```julia
using MultivariateStats
using CairoMakie

justices = ["sotomayor", "kagan", "jackson", "roberts", "kavanaugh", "barrett", "gorsuch", "thomas", "alito"]
data = [63 66 71 77 79 77 95 95 100
        61 64 70 79 80 82 89 100 95
        64 64 70 75 80 79 100 89 95
        79 75 77 89 95 100 79 82 77
        80 73 82 91 100 95 80 80 79
        79 82 80 100 91 89 75 79 77
        88 77 100 80 82 77 70 70 71
        86 100 77 82 73 75 64 64 66
        100 86 88 79 80 79 64 61 63]

dm = 100 .- data
pca = fit(PCA, data)

scatter(loadings(pca)[:,1], loadings(pca)[:,2]; color = repeat([:blue, :purple, :red]; inner=3),
    axis = (; xlabel="PC1", ylabel="PC2"))
annotations!(justices, Point2f.(zip(loadings(pca)[:,1], loadings(pca)[:,2])))
save("/home/kevin/Downloads/justices.png", current_figure())

```

The trouble is - the numbers on these axes don't mean the same thing!
This kind of analysis attempts to find the axes that explain as much of the variance as possible.
Axis 1 (the x axis) explains the most - here it's 72%!
Axis 2, by contrast, only explains 17% of the variance -
in other words, a length on the x axis is more than 4 times more meaningful
(represents 4 times more variance) than the same length on the y.

Here again is the same plot, but scaled correctly:

```julia
scatter(loadings(pca)[:,1], loadings(pca)[:,2]; color = repeat([:blue, :purple, :red]; inner=3),
    axis = (; xlabel="PC1", ylabel="PC2", aspect=DataAspect()))
annotations!(justices, Point2f.(zip(loadings(pca)[:,1], loadings(pca)[:,2])))
save("/home/kevin/Downloads/justices2.png", current_figure())
```

We can still see the effect of that second axis,
but the one that appears to be partisanship is much more pronounced.

Another way to look at this question is with something called a PERMANOVA,
which can tell us what proportion of the variance is explainable by
some variable, say partisanship.

```julia
using CategoricalArrays
using PERMANOVA
using Distances

df = DataFrame(
    "justices" => justices,
    "party" => categorical([fill("democrat", 3); fill("republican", 6)]),
)

permanova(df, dm, Euclidean, @formula(1 ~ party)) 
```

Here, this says that ~60% of the variance is explained by partisanship.
Which seems like a lot to me, though I don't know in absolute terms
what should be expected.
We can perhaps get close to a "norm" by looking historically.
I used [a database](http://scdb.wustl.edu/documentation.php?var=firstAgreement) from
Washington University to get info about decisions from 1946-2022
and did a PERMANOVA on every year
where there were at least 2 justices nominated by presidents
from each party.

```julia
using Statistics
using Combinatorics

# I used wikipedia to look up when each justice was nominated
parties = Dict(j=>p for (j,p) in zip(
                unique(cases.justiceName), ["D", "D", "D", "D", "D",
                                           "D", "D", "D", "D", "D",
                                           "D", "R", "R", "R", "R",
                                           "R", "D", "D", "D", "D",
                                           "R", "R", "R", "R", "R",
                                           "R", "R", "R", "R", "R",
                                           "D", "D", "R", "R", "D",
                                           "D", "R", "R", "R", "R"]
                )
)

cases = CSV.read("../SCDB_2023_01_justiceCentered_Citation.csv", DataFrame)

# there are a bunch of vote types, I just want in majority or in minority cases
votebool = Dict(
    1 => true, #	voted with majority or plurality
    2 => false, #	dissent
    3 => true, #	regular concurrence
    4 => true, #	special concurrence
    5 => true, #	judgment of the Court
    6 => missing, #	dissent from a denial or dismissal of certiorari , or dissent from summary affirmation of an appeal
    7 => missing, #	jurisdictional dissent
    8 => missing, #	justice participated in an equally divided vote
)
cases.voteBool = [get(votebool, vote, missing) for vote in cases.vote]

terms = groupby(cases, "term")
map(keys(terms)) do key
    @info key.term
    term = terms[key]

    wide = unstack(select(term, "justiceName", "caseId", "voteBool"), "justiceName", "voteBool")
    select!(wide, [n for n in names(wide) if !all(ismissing, wide[!, n])])

    uj = names(wide, Not("caseId"))
    pj = map(j-> parties[j], uj)

    if !(0.2 <= mean(==("D"), pj) <= 0.8)
        @error "Term $(key.term) didn't have enough party diversity"
        return (; term=key.term, r2 = NaN, p = NaN)
    end
    
    mat = zeros(length(uj), length(uj))
    for (i, j1) in enumerate(uj), (k, j2) in enumerate(uj)
        i < k || continue
        j1v = wide[!, j1]
        j2v = wide[!, j2]
        m = mean(mean(skipmissing(j1v .& j2v)))
        mat[i,k] = 1 - m
        mat[k,i] = 1 - m
    end
    testdf = DataFrame(
        "justices" => uj,
        "party" => pj
    )
    try
        perm = permanova(testdf, dm, Euclidean, @formula(1 ~ party))
        return (; term=key.term, r2 = perm.results[1, "R2"], p = perm.results[1,"P"])
    catch
        @error "Term $(key.term) had an error in the PERMANVOVA"
        return (; term=key.term, r2 = NaN, p = NaN)
    end
end
```

The only (statistically significant) years that even approached
the same level of variance explained by nominating party were ~40%.

Finally, math aside,
I feel this whole analysis suffers from a huge dose of survivorship bias -
that is, all of the things that affect what cases even make it to a decision
(litigant strategy, the shadow docket, what gets cert)
can have a huge impact on downstream decisions,
but won't be reflected here.

That is, imagine the court heard 50 cases,
35 of which were obvious matters of constitional law
that got unanimous decisions, and 15 where the outcome
is moderately conservative, going 6-3.
This would look identical to, or even slightly less partisan
that a term where there were 35 unanimous decisions
and 15 extremely far-right decisions that were 6-3 and 5-4.

[^scale]: Actually, this isn't perfect, since the actual distance in miles between a degree of latitude
  is constant and the distance between degrees of longitude is different depending on the latitude,
  but it's close enough.
[^problem]: It's not _inherantly_ wrong. There can be good reasons to have differently scaled axes.
  In this example, it could be that we're looking at climate variation, where differences in latitute
  are much more consequential than differences in longitude.
  But in general, you should start with the idea of absolute scaling, and be able to justify a difference.
[^pcavsvd]: For a mathy explanation of their relationship, see here: https://math.stackexchange.com/questions/3869/what-is-the-intuitive-relationship-between-svd-and-pca
  I wasn't able to find a good lay person explanation, but hopefulle you can see from
  the initial plot that they're basically identical.
