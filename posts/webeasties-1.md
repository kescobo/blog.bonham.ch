+++
using Dates

title = "We, Beasties recovery - Part 1"
rss = "We, Beasties recovery - Part 1"
date = Date("2020-01-06")
rss_date = Date("2020-01-06")
category = "code"
showall = true
tags = ["microbiology","web", "julia"]
img = "/assets/img/sciblogs-logo.jpeg"
math = false
+++

Every new year, I tell myself that this is the year I'm going to start blogging again.
Sometimes, I even [write posts](/posts/2017/back-on-the-horse.md)
saying "this year will be different,"
and then that ends up being my only post of the year.

I used to love blogging - I had a relatively popular blog on [ScienceBlogs.com](https://scienceblogs.com/webeasties)
called "We, Beasties" - a not-so-subtle homage to [Isaac Asimov](https://en.wikipedia.org/wiki/I,_Robot)
and [Paul de Kruif](https://www.indiebound.org/book/9780156027779) -
which ended in 2013 when I got recruited to start
an [ill-fated blog](https://blogs.scientificamerican.com/food-matters/)
at Scientific American.

What I do now is very different than what I was doing in 2013,
but I'm always thinking I should get back into it.
What better way to do that than to use my new skills to collect my old content?

## "Scraping" old posts

Initially, I was expecting to have to do some complicated html parsing,
crawling through each post and finding back links,
but it turns out the old scienceblogs.com website is actually
pretty well laid out.

First, I went to [my author page](https://scienceblogs.com/author/kbonham),
which lists all of my posts in pagenated form.
In the browser, I right-clicked in the page, and selected "view source"
to see the underlying html (which is how the page will be downloaded).

A few things jump out right away:

1. The blocks that contain links to previous posts look like
   
   ```html
   <h5 class="field-content"><a href="/webeasties/2013/09/03/we-beasties-sproulates" hreflang="und">We, Beasties Sporulates</a></h5>
   ```

2. The individual pages of posts all have the same url as the author page,
   ending in `?page=N`, where `N` is a number `0:7`.

So really, all I need to do is download each of those pages,
search for all of the `webeasties` urls,
and then download all of _those_ pages.

Pretty simple. The code in this post is all run
with julia Version 1.6.0-DEV.1722 (2020-12-09) (but should work on any julia v1).
project files [can be found here](content/juliaprojects/webscrape/).
In code blocks below, I have a mix of script-like and REPL commans,
the latter are just to easily show outputs.
I do most of my julia coding and running using the [VS Code julia extension](https://www.julia-vscode.org/).


\literate{_assets/literate/webeasties/part1.jl; project=.} 
