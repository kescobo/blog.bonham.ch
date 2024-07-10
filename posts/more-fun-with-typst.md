+++
using Dates
title = "More Fun with Typst - Building a CV"
date = Date(2024, 6, 10)
+++

I'm so predictable. 

Last November, I [wrote a post](/posts/typst-job-apps) about `typst`,
a new type-setting software written in rust that's meant to replace $\latex$.
In that post, I said,

> Well, I didn't get a job in that round,
  so I'm at it again!
  For realsy reals, this is the last year I'm doing this.

Well, I didn't get a job in this round either.
I got close with one - full two-day interview.
They said they loved my science,
they said that they liked me,
they said I did a great job explaining computational concepts
to the wetlab folks (which should have meant a lot,
since the job was about bringing "novel computational techniques"
to the department)...

But they weren't sure I was the right "fit".
I'm not sure, but this sounds like code for
"we can't think of a good reason, but we went with someone else".

Anyway, I'm now waffling on whether I want to try again after all.
But in the mean time, I'm working on my CV and resume in typst,
and continuing to love it.
As I mentioned in that last post,
I was able to build my entire CV from scratch,
replicating the layout that I'd needed a template for in $\latex$.
This means I actually understand all of the components,
so I can tweak them to my liking.
Plus, I recently figured out how to build and post
the pdfs using CI machinery on gitlab. Fun!

## The Basics

As I mentioned in the last post, typst is in part a markup language,
so you can get a lot of basic formatting using symbols,
eg

```typst
= This is a header

*This will be bold*, while _this will be italic_,

- and bulleted
- lists are easy

So are numbered lists:

+ thing 1
+ thing 2

== This is a level 2 header!

More text
with semantic line breaks.
```

You'll want to run through the [tutorial][typst-tutorial]
to go through all the basics - it's quite well done -
but I'll just highlight a couple of things
that will be relevant to this post and took me a while to fully grok.

### The differences between `set` and `show`

There are two ways to change the way that things are displayed,
and it took me a while to build the intuition about which one should be used when.

#### Using `set`

The `set` function I think of as changing the defaults of some other function.
So for example, you might use `box` to put highlights around some text.

```typst
This text: #box(fill: yellow)[is highlighted!]
```

This results in:

![](/assets/img/typst-highlight.avif)

In this code, we call the function `box()`
with the keyword argument `fill` set to `yellow`.
In "content" mode
(which is all of the document unless otherwise specified),
we call functions or place variables with `#`.

If I plan to be doing this a lot,
I can use `set` to make the `fill` argument default `yellow`.
In other words,

```typst
#set box(fill: yellow)

Some more #box([highlighted]) text #box([here!]).

But I can still #box(fill: blue)[use other] colors
or #box(fill: none)[no color] if #box()[I want to].
```

![](/assets/img/typst-highlight2.avif)

Notice that this does not hold me to yellow - it just changes the default.
In this case, the default `fill` was `none`,
and I can always get that back by making it explicit.

#### Using #show

The `show` function is used to replace the way something is rendered.
I pointed to this in my last post,
but you can do things like

```typst
#show "awesome": box(fill: red, outset: 2pt)[💃 Awesome! 💃]

Look at this awesome text.

Every time I type awesome
```

![](/assets/img/typst-show.avif)

So this seems fairly straightforward - use `set` to change functions
and `show` to change the way things look, right?

Well...

#### What's confusing (at least for me)

One thing that I found confusing is that often you use `set`
to change the way things look.
One example - you use `#set text(font: "Liberation Sans")` to change the font.

Another example from the [tutorial][typst-tutorial] shows the following:

```typst
#set heading(numbering: "1.")

= Introduction
#lorem(10)

== Background
#lorem(12)

== Methods
#lorem(15)
```

to get

![](/assets/img/typst_set1.png)

or

```typst
#set heading(numbering: "1.a")

= Introduction
#lorem(10)

== Background
#lorem(12)

== Methods
#lorem(15)
```

to get

![](/assets/img/typst_set2.png)

So... `set` here is changing the way stuff is shown - what gives?

The key here is that, even things that are written using the markup language
are actually calling functions.
In other words, the text above is like

```typst
#heading(level: 1)[Introduction]

#text()[#lorem(10)]

#heading(level: 2)[Background]

#text()[#lorem(12)]
```

etc... So we're using `set` to change the default of the *functions* that are called by the markup.
But I don't have a strong handle on what is implicitly calling functions,
so it's still a bit hard to reason about (eg here, there's also calls to `#page`, `#par` etc).

So mostly I just look for examples, either in my previous code,
in the tutorial, or in this [really excellent resource][typst-book].

## Writing the CV
The first thing to do is to set some parameters
to make things look nice, and write up the front matter saying who I am.

```typst
// set some variables that I can use later
#let name = "Kevin Bonham, PhD",
#let title = "Senior Research Scientist",
#let email = "blog@bonham.ch",
#let addr = "Waltham, MA",
#let phone = "555.555.5555",
#let orcid = "0000-0002-1825-0097",
#let github = "kescobo",
#let url = "https://blog.bonham.ch",

// shrink the margin, and set paper (I think this is default, but...)
#set page(margin: 0.8in, paper="us-letter")
#set text(font: "Liberation Sans", align: center)

#text(20pt, weight: "bold", name)
#linebreak()
#text(12pt, title)

#set text(8pt)

#grid(
    columns: (2fr, 2fr, 1fr),
    gutter: 10pt,
    [#fa-phone() #phone],
    [#fa-envelope() #email],
    [#fa-house() #addr],
    [#fa-orcid() #orcid], 
    [#fa-github() #github],
    [#fa-globe() #url]
)

#set text(10pt)


```

[typst-tutorial]: https://typst.app/docs/tutorial/
[typst-book]: https://sitandr.github.io/typst-examples-book/book/
