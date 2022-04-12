+++
using Dates

title = "Getting Back on the Horse - Part 2: Deploying a new Site"
date = Date("2017-10-26")
draft = false
category = "web"
tags = ["meta", "website", "code"]

rss_descr = "Part 2 of my effort to recover blog posts from my previous life"
rss_title = title
+++

Yeah, so my [last post][1] was clearly a bit too optomistic. I've only just now
set up this new website using the [Hugo][2] static site generator and [Academic][3]
theme which is pretty nifty. I started doing this back in August, but ran into
some snag and haven't returned to it until now.

But I thought I'd briefly go through what I did in order to set this up, mostly
as a reference for myself.

## Motivation

There are just a few things I really want for my website:

1. Ability to edit pages and add content using markdown
2. Good syntax highlighting
3. Ability to use git for version control

There are a lot of things that sort of work for this. [Jekyll][4] seems to be
the most common, and I've tried it before, but it seemed a bit too sparse. And I
didn't love the way it looked, or the structure of the folder structure to make
it work. Then I tried [Grav][5] and one of its git-enabled [themes][6], but it
seemed too complicated for my needs.

My [main website][7] is currently through Squarespace, and it looks pretty, but
I can't easily manage posts in text files with version control. In principle,
I could write posts in markdown and upload those files, but that's clunky, and
anyway and it's syntax highlighting isn't quite up to snuff (or wasn't last
I checked).

So, enter Hugo.

## Set-up

Honestly, this is dead simple. I followed the [Getting Started][8] page in the
Hugo docs, and [the same][9] for the Academic theme. Only a couple of
modifications:

First, when installing the theme, I used a git submodule rather than just
straight cloning. In other words, after installing hugo with homebrew:

```sh
$ mkdir hugo-nequalsme
$ cd hugo-nequalsme
$ git init
Initialized empty Git repository in /Users/kev/computation/websites/hugo-nequalsme/.git/
$ git submodule add https://github.com/gcushen/hugo-academic.git themes/academic
Cloning into '/Users/kev/computation/websites/hugo-nequalsme/themes/academic'...
remote: Counting objects: 2334, done.
remote: Compressing objects: 100% (57/57), done.
remote: Total 2334 (delta 28), reused 34 (delta 11), pack-reused 2263
Receiving objects: 100% (2334/2334), 3.43 MiB | 3.48 MiB/s, done.
Resolving deltas: 100% (1340/1340), done.
$ cp -a themes/academic/exampleSite/* .
```

Dealing with submodules is a [bit tricky][10], but for the most part I won't be
needing to actively worry about it.

Then I created a [new repo][11] on github, added all of the demo content, and
pushed it.

```sh
$ git remote add origin git@github.com:kescobo/nequals.me.git
$ git push -u origin master
```

## Customizing

Again, I basically just followed the [theme docs][12] to modify my `config.toml`
and all of the content pages. I had some posts left over from previous static
site attempts and moved them over to the `content/post/` folder.

This is mostly straightforward, and I tried to do atomized commits to the repo
so it should be clear from the history. Part of the customization was commenting
out or disabling all of the stuff I don't want for now. Happily - the content is
still there if I ever want it later.

## Deploying

Unfortunately, I can't go through this in detail, because I got a big chunk
of it set up a while ago. The good news is, the folks at [Reclaim Hosting][13]
are awesome. I've filed a bunch of help tickets when I was trying to get
Grav working, and they were prompt and super helpful.

So the background here is that I already have a domain registered through [hover][14],
and I've got them pointing at my hosting at Reclaim. Honestly, this part gave me
some trouble when I initially did it, because I had tweaked all kinds of stuff
before, but if you're starting from scratch the docs are pretty good.

What I did today was to effectively clear out the `public_html/` folder on the
server that had all of the crap from the previous Grav blog, and then I just
needed to build my Hugo site locally and transfer it up to the server. Building
the site is easy -  you just:

```sh
$ hugo
Started building sites ...

Built site for language en:
0 draft content
0 future content
0 expired content
26 regular pages created
29 other pages created
0 non-page files copied
20 paginator pages created
18 tags created
0 categories created
1 publication_types created
total in 64 ms
```

This generates the entire html structure in a new folder `public/`. To transfer
it, I'm using `rsync`.

```sh
$ rsync -avzP --delete public/ <username>@nequals.me:/home/<username>/public_html/
```

The flags for `rsync` are:

- `-a`: archive mode (does a bunch of worthwhile stuff [see here][15])
- `-v`: verbose
- `-z`: compresses stuff before transferring and decompresses on the other side (reduces bandwidth needed)
- `-P`: shows progress meters for large files
- `--delete`: removes stuff that's not in the source directory anymore

That last piece is useful if you're playing around with the folder structure,
because files that aren't modified remain there, so you might end up with a lot
of crap floating around your webpage otherwise.

I also set up an alias in my `.bashrc` file to make this easier:

```sh
alias hugopush="rm -rf public/; hugo; rsync -avzP --delete public/ <username>@nequals.me:/home/<username>/public_html/"
```

And that's it! At some point I'll want to look into how I can do webhooks or
something so that I can just push to github and have the site building happen
right on the server, but as it stands, this is pretty seemless. I write the
markdown file, commit changes, and run `hugopush` and I'm done!


[1]: http://nequals.me/blog/2017/08/getting-back-on-the-horse/
[2]: https://gohugo.io/
[3]: https://github.com/gcushen/hugo-academic/
[4]: https://jekyllrb.com/
[5]: https://getgrav.org/
[6]: https://github.com/hibbitts-design/grav-skeleton-eportfolio-blog
[7]: http://kevinbonham.com
[8]: https://gohugo.io/getting-started/quick-start/
[9]: https://sourcethemes.com/academic/post/getting-started/
[10]: https://www.atlassian.com/blog/git/git-submodules-workflows-tips
[11]: https://github.com/kescobo/nequals.me
[12]: https://sourcethemes.com/academic/post/widgets/
[13]: https://reclaimhosting.com/
[14]: http://hover.com
[15]: https://serverfault.com/questions/141773/what-is-archive-mode-in-rsync
