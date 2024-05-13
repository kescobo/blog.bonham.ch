+++
using Dates

title = "Job applications with Typst and git for fun and profit"
date = Date("2023-11-23")
category = "academia"
tags = ["latex", "typst", "code", "job-applications", "typesetting", "git"]

rss_descr = "Using plain text and git for easy job app customization"
rss_title = title
+++

Last year at this time,
I was applying for academic jobs
and discovered that I [could use $\LaTeX$ and git](/posts/latex-job-apps/)
to make the experience less painful.

Well, I didn't get a job in that round,
so I'm at it again!
For realsy reals, this is the last year I'm doing this.
But I've discovered a new hotness for my applications - [typst](https://typst.app/docs/).

## Typst vs $\LaTeX$

Like $\LaTeX$, typst is a typesetting language -
the idea is that you write your document in plain text,
and describe the way it should be formatted,
the layout, the page properites, etc,
all in plain text.
Then you run the compiler,
and out comes your document
the same way every time (with caveats).

Typst is pretty new, which means a few things
relative to $\LaTeX$.
For one, it doesn't have the decades of baggage,
janky code,
things that work because one guy figured it out in 1992
and everyone else has been copying it since etc.
It also means that it's not as feature-rich as $\LaTeX$,
and some things are just impossible to do so far
(eg, [putting figures](https://github.com/typst/typst/issues/553) in arbitrary places on the page).

But the other thing I love is that there's a markup language -
it's not quite markdown, but it's similarly easy.
For example, 

```txt
= This is a level one header

And some *bold* text.

== A level two header

And some _italic_ text.
```

Compare to the same thing in $\LaTeX$:

```latex
\section{This is a level one header}

And some \textbf{bold} text.

\subsection{A level two header}

And some \textit{italic} text.
```

I also find the actual programming of the layout engine
more comprehensible -
the whole thing is rust underneath,
which is not a lanugage I know,
but it's still easy enough to look at some examples 
and figure out what to tweak.
I completely [re-made my CV in typst](https://kescobo.gitlab.io/cv-typst/cv.pdf)
from scratch in a few hours - 
with $\LaTeX$, I had to use a template I didn't understand,
and couldn't really alter it much
(I'll try to do a post on that soon).

The documentation is great too,
and there's a [collaborative editor](https://typst.app) that
you can use with colleagues and get real-time rendering.

## Quick recap of `git` tips

In [that other post](/posts/latex-job-apps/#motivation),
I talked about my motivation, and what I wanted:

> 1. has a single master version of each document
> 2. is easy to propagate changes from any version and regenerate outputs
> 3. doesn't have dozens of versions floating around in different folders

To accomplish this, you want to

- [Make generic files](/posts/latex-job-apps/#generic_files_with_placeholders) with placeholders
- Those files should [use semantic line breaks](/posts/latex-job-apps/#semantic_line_breaks)...
- ... and [separate lines for the placeholders](/posts/latex-job-apps/#separate_lines_for_placeholders)
- Use [separate branches](/posts/latex-job-apps/#use_separate_branches_for_specific_applications)
  for each application

Read that other post for more details on how to do that stuff.

## Using typst for job applications

### Setup

I'm not going to go through installation -
the [instructions here](https://github.com/typst/typst#installation)
are better than I would do,
but note that this workflow does require that you install typst
locally rather than using their web app.
For editing, I'm using VS Code with the [Typst LSP](https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp) extension,
but you can use any plain text editor
(and use `typst watch $FILE` to get live preview that updates automatically).

Once you have Typst has pretty nice defaults in terms of style.
For example,

```txt
== Introduction
 
I'm awesome, and my science is *awesome*.
Hire me!
```

![](/assets/img/typst_format1.png)

I made a few tweaks to the default styles,
which is accomplished with `#set` rules.
In particular, I wanted a sans serif font,
and set the font size to 10pt:

```txt
#set text(10pt, font: "Liberation Sans")
```

![](/assets/img/typst_format2.png)


And then I wanted to add a header and page numbers.
I think that US letter is default,
but I set it to be excplicit:

```txt
#set page(
  paper: "us-letter",
  header: align(right)[
    *Bonham - Research Statement*
  ],
  numbering: "1"
)
```

### Adding highlights for placeholders

Finally (and this is one of my favorite things about typst),
I set some `#show` rules to automatically highlight specific text
in my placeholder files.
The basic idea is that, using `#show`,
you set certain text to be formatted a certain way.
For example,

```txt
#show "awesome": text => box(
    fill: blue,
    inset: 2pt,
    [✨ #text ✨]
)

== Introduction
 
I'm awesome, and my science is *awesome*.
Hire me!
```

![](/assets/img/typst_format3.png)

But rather than set this on every document,
and separately for each thing I want highlighted,
I can create a function in a separate file,
then set the `#show` rule to use that function:

`highlights.typ`:

```txt
#let hl(content) = box(
    fill: yellow,
    inset: 0pt,
    content
)
```

`research_statement.typ`:

```txt
#import "includes/highlights.typ": hl
#show "INSTITUTION": hl
#show "CITE": hl

Here's an application for
INSTITUTION
with a couple of citations
CITE.
```

![](/assets/img/typst_format4.png)

And that's it!
Well, other than the writing part...
If I get an academic job this year,
I might write up my advice for that.
If I don't, you probably don't want my advice anyway.
