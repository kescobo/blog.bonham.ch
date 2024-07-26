+++
using Dates
date = Date(2024, 7, 24)
title = "Mastodon comments on Xranklin"
comments_id = "112842335724314238"
comments_username = "kbonham"
comments_host = "scicomm.xyz"
+++

Comments are tricky - they're nice for engagement
(as if anyone's reading this stuff),
but moderation can be a hassle,
and for a static site like this,
many of the options require you to pay for hosting,
or require you to send (your reader's) information to 3rd parties etc.

But I recently saw a few examples of people using [Mastodon][join-mastodon] -
the twitter-like social platform that's part of the "[fediverse][join-fediverse]"
or "decentralized social web" -
to serve comments on their site.

1. The main source of inspiration [from Jan Wildeboer](https://jan.wildeboer.net/2023/02/Jekyll-Mastodon-Comments/)
2. Some other helpful code and links [from Cassidy Blaede](https://cassidyjames.com/blog/fediverse-blog-comments-mastodon/)

But a lot of what I was seeing was using the jekyll static site generator,
and given I know basically nothing about javascript (which is required here),
I ended up needing some help from an LLM (claude) to get it working
with [Franklin.jl][xranklin], which I'm using for this blog.

But I did!
I should do a more complete write-up at some point,
because I learned some things that may be helpful to other folks in a similar situation,
but this post was really just an excuse to test the functionality.


[join-mastodon]: https://joinmastodon.org
[join-fediverse]: https://joinfediverse.wiki/Main_Page
[xranklin]: https://github.com/tlienart/Xranklin.jl
