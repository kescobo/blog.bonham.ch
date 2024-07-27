+++
using Dates
date = Date(2024, 7, 26)
title = "Mastodon comments in Xranklin - how to do it"
comments_id = "112842335724314238"
tags = ["web", "mastodon", "julia"]
+++

In the [last post](/posts/mastodon-comments.md),
I was showing that I could use replies to a post on [mastodon]
as comments on this blog.
Here, I'll show how I did it
by modifying the effort of a bunch of other folks,
principally [Jan Wildeboer][jan].
The main struggle I had,
given that I don't know much about web development,
javascript, nor other static site generators,
this took a bit of effort to translate to the static site generator that I'm using.

I'll link to things directly as I'm going,
but if you want to follow along,
the code for this site is [on github].
and the state of the repo while working on this post [is here][current-commit].

[mastodon]: https://joinmastodon.org
[jan]: https://jan.wildeboer.net/2023/02/Jekyll-Mastodon-Comments/
[on github]: https://github.com/kescobo/blog.bonham.ch/
[current-commit]: https://github.com/kescobo/blog.bonham.ch/commit/6c35988c9f34f8c25e937d2047538e0f0ff19ab8

## Background on Xranklin.jl / Franklin.jl

[`Xranklin.jl`][xranklin] is a julia-based [static site generator][ssg] (SSG),
which is a re-write of the more widely used (amongst julians) [`Franklin.jl`][franklin].
I think the intention is that this is eventually going to replace Franklin,
but it's not quite ready.
Most of this should be relevant to the current release of Franklin as well,
and I will try to talk about it in generic enough terms that it should be applicable
to other SSGs with just syntax tweaks.

Like many other SSGs, (X|F)ranklin sites are built around [markdown],
which is used to author posts and other site content,
which is combined by the SSG with html, css, and javascript templates
to produce the final site.
For this site, I'm using [a template][coder-jl-template] that's based on the [coder template][coder-templete]
for the Hugo SSG, which [Thibaut Lienart][tlienart] (the author of Franklin) adapted.

Crucially, within the html templates, you can include places where code gets executed,
variables (either site-wide or local to a page) get inserted,
other html is injected, or all three.
For Franklin, the main building blocks of every page are in the `_layout` directory,
and for every page that's rendered from markdown gets built from

1. `_layout/head.html`
2. The rendered contents from the markdown
3. `_layout/foot.html`

I will skip through the Franklin-specific technical details
of the order that things get processed, because they're not relevant here
(and to be frank, I'm not totally clear on them anyway).

The last piece that's important to understand is where
variables and functions get defined,
which in the case of Xranklin is one of the following places:

1. `config.jl` - julia code at the top level of the site.
   Variables defined here are considered "global".
2. `utils.jl` - this code has some special properties,
   but in the current iteration, I'm not using anything here, so I'll skip describing it.[^future]
3. The "front matter" of a given page.
   In Xranklin, this is julia code placed within 3 `+` blocks at the beginning.
   Variables defined here are considered "local"

In the following code, you'll see `{{masto_host}}` and `{{masto_user}}`,
which are defined in `config.jl`, and `{{masto_id}}`,
which is meant to be defined in a post's front matter.

[xranklin]: https://tlienart.github.io/Xranklin.jl/
[franklin]: https://tlienart.github.io/Franklin.jl/
[ssg]: https://indieweb.org/static_site_generator
[markdown]: https://en.wikipedia.org/wiki/Markdown
[coder-jl-template]: https://github.com/tlienart/coder-xranklin-demo
[tlienart]: https://tlienart.github.io

[^future]: Ultimately, I'd like to use code in `utils.jl` to generate this,
since I'll have more control there, but I got stuck with the scope of variables
and decided I could put it off for a bit.

## Code to fetch and display posts from Mastodon

Ok, so now the setup -
we're going to grab the identifier for a specific mastodon post,
find all of the replies to that post,
then style them and insert them into the content of a particular page.

### Getting the replies from mastodon

If you're not familiar with [ mastodon ],
it's a bit like twitter, but for the [fediverse].
If you're not familiar with the fediverse, well...
I don't really have the space to describe it here.
There are lots of explainers online.

But for our purposes here, the important things to know are:

1. Each user is part of a mastodon "instance", one of a number of federated hosts.
   The best analogy is to email - you can have someone with gmail and someone with fastmail,
   someone on their school email and someone with a custom domain email all communicate
   with one another.
2. There is a protocol where one can ask an instance for the data associated with a particular post,
   and the relevant data comes back as JSON.

For example - [here's a mastodon post][testtoot] where I was testing this stuff out.
Examining the URL, there's my instance (`https://scicomm.xyz`),
my username on the instance (`@kbonham`), and then a string of numbers
that constitute a unique id (`112842335724314238`).
Using this information, one can use the common API to pull information
with the following URL:

`https://scicomm.xyz/api/v1/statuses/112842335724314238/context`

If you follow that URL,
you get a JSON string that contains the conent
of the post, info about the account that posted it,
and any replies.
You can look yourself, but I'll just reproduce a bit of it here
(i removed a bunch of the fields):

```JSON
{
  "ancestors": [],
  "descendants": [
    {
      "id": "112842391956250759",
      "created_at": "2024-07-24T16:24:16.166Z",
      "in_reply_to_id": "112842335724314238",
      "in_reply_to_account_id": "109265890028699496",
      "visibility": "public",
      "url": "https://scicomm.xyz/@Kbonham/112842391956250759",
      "replies_count": 1,
      "reblogs_count": 0,
      "favourites_count": 0,
      "content": "\\u003cp\\u003eTest reply 🎉\\u003c/p\\u003e",
      "account": {
        "id": "109265890028699496",
        "username": "Kbonham",
        "acct": "Kbonham",
        "display_name": "Kevin Bonham 🚽🦠👨🏼‍🔬",
        "url": "https://scicomm.xyz/@Kbonham",
        "avatar": "https://media.scicomm.xyz/accounts/avatars/109/265/890/028/699/496/original/df0b165cd6ae797c.png",
        "avatar_static": "https://media.scicomm.xyz/accounts/avatars/109/265/890/028/699/496/original/df0b165cd6ae797c.png",
    },
    {
      "id": "112842728627510584",
      "created_at": "2024-07-24T17:49:53.362Z",
      "in_reply_to_id": "112842391956250759",
      "in_reply_to_account_id": "109265890028699496",
      "visibility": "public",
      "uri": "https://scicomm.xyz/users/Kbonham/statuses/112842728627510584",
      "url": "https://scicomm.xyz/@Kbonham/112842728627510584",
      "replies_count": 0,
      "reblogs_count": 0,
      "favourites_count": 0,
      "content": "\\u003cp\\u003eOne more...\\u003c/p\\u003e",
      "account": {
        "id": "109265890028699496",
        "username": "Kbonham",
        "acct": "Kbonham",
        "display_name": "Kevin Bonham 🚽🦠👨🏼‍🔬",
        "url": "https://scicomm.xyz/@Kbonham",
        "avatar": "https://media.scicomm.xyz/accounts/avatars/109/265/890/028/699/496/original/df0b165cd6ae797c.png",
        "avatar_static": "https://media.scicomm.xyz/accounts/avatars/109/265/890/028/699/496/original/df0b165cd6ae797c.png",
    },
  ]
}
```

So, within the response is a vector called "descendants" (the replies),
and each item contains another posts
(the content of which is in the field "content"),
with info about who posted it.
Here, I'm showing 2 such posts (both from me).

To display those nicely in a comments section,
I want to put the relevant content into HTML,
and add some CSS styles so that it fits with the site.
I also want to have some logic that ignores any replies
that aren't listed as "public",
and if there are no replies,
leave a different message.

### Setting up the structure

The first thing to do is set up the structure
for representing the comments on the page.
With heavy inspiration from (read: blatant copying of)
[Jan Wildeboer's post][jan].

```html
<section class="comments">
  <h2 class="comments-title">Comments</h2>
  <p>You can use your <a href="https://joinmastodon.org">Mastodon</a> or other ActivityPub account to comment on this article by replying to the associated <a class="link" href="https://{{ comments_host }}/@{{ comments_username }}/{{ comments_id }}">post</a>.</p>
  <div id="mastodon-comments">
    <button id="load-comment">Load Comments</button>
    <div id="mastodon-comments-list"></div>
  </div>

  <script src="/libs/mastodon.comments.js"></script>
  <script type="text/javascript">
    document.getElementById("load-comment").addEventListener("click", function() {
      loadMastodonComments("{{ comments_host }}", "{{ comments_id }}");
    });
  </script>
</section>
```

Taking it line by line,
first we make a section,
then give it a level 2 header, "Comments",
then we have a line that explains what's going on,
and that people can leave comments by replying to the post.
In that line, notice the `comments_host`, `comments_username`, and `comments_id`
wrapped in double curly braces -
those get replaced by variables of the same name,
the former two being defined in the site config,
and the latter in the post's front matter.

The next 4 lines (wrapped in `<div>`), we make a button with the id `load-comment`,
which allows us to register a response to clicking.
then the javascript comes in.
The post I was cribbing from put all the javascript in-line,
but I like to have things a bit more self-contained,
so I used the LLM claude to help me figure out how
to put the most important stuff in a separate file,
which we can pull into this html using `<script src="/libs/mastodon.comments.js"></script>`.

In that file, which I'll get to in a sec,
I define a function `loadMastodonComments` that takes 2 arguments,
the mastodon host (here, `scicomm.xyz`) and the post ID,
then builds the comments section from that.
The inner `<script>` section notices when the button defined above is clicked,
and then runs the code in that function.

### Fetching and formatting the comments

You can see the whole structure of the function in the [repo][on github]
in `_libs/mastodon.comments.js` [^underscores],
but I'll just go through it in pieces.
First, let's look at the very bottom of the file,
which is:

```javascript
window.loadMastodonComments = function(commentsHost, commentsId) {
  document.getElementById("load-comment").innerHTML = "Loading";
  fetch(`https://${commentsHost}/api/v1/statuses/${commentsId}/context`)
    .then(function(response) {
      return response.json();
    })
    .then(displayMastodonComments);
}
```

This is the function that's actually called from the html -
it takes in the `commentsHost` and `commentsId` arguments,
fetches the content of the url that returns the JSON I mentioned above,
parses the json data, returning a dictionary (or whatever they call it in javascript),
and then calls `displayMastodonComments`, which is defined higher up in the file.

[^underscores]: Note that in franklin (as with a lot of other SSGs),
the special folders starting with underscores,
eg `_libs`, are replaced by folders without the underscores
once the site's actually built, which is why we point to `/libs/` in the html.

[fediverse]: https://joinfediverse.wiki/Main_Page
[testtoot]: https://scicomm.xyz/@kbonham/112842335724314238
