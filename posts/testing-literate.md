+++
using Dates

title = "New literate functionality"
rss = "New literate functionality"
date = Date("2023-06-23")
rss_date = Date("2023-06-23")
category = "code"
showall = true
tags = ["web", "julia"]
math = false
+++

Thanks to [this PR](https://github.com/tlienart/Xranklin.jl/pull/197),
it should be possible to have post-specific environments,
which should make Literate.jl-based posts easier...

Let's see if it works:

\literate{_assets/literate/testing-literate/post.jl; project=.} 
