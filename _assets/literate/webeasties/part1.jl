md"""
### Looping through author pages

Since each author page has the same url save one number,
I just cycled through them in a loop of the numbers.
In each case, I downloaded the page into a temporary file,
scan it for `webeasties` urls, and store them in a set.

Note: you should really never use Regex to parse an HTML file,
but I'm not _really_ parsing them, I actually am looking for a simple pattern.
"""

projectdir = joinpath(pwd(), "_assets", "literate", "webeasties")

using Pkg #hide
Pkg.activate(projectdir) #hide
Pkg.instantiate() #hide

#-

using Downloads: download

posturls = Set(String[])
baseurl = "https://scienceblogs.com/author/kbonham?page="

## for p in 0:7
for p in 0:0
    tmp = download(baseurl*string(p))
    for line in eachline(tmp)
        for m in eachmatch(r"href=\"(/webeasties[\w/\-]+)\"", line)
           push!(posturls, m[1])
        end
    end
end

first(posturls, 5)

#-

length(posturls) # for the full set, this is 191

md"""
Explanation of regex:

- `href=\"/webeasties`: hoepfully self-explanatory, the `href` looks specifically
  for links, and the `"` needs to be escaped.
- `[\w/\-]+`: match any number of word (`a-z`, `A-Z`, `0-9`, and `_`) characters,
  forward slashes or dashes
- `\"` closing out the string.

### Downloading html pages

The next bit is using the same idea,
except I suspected (correctly) that getting the parsing right would take me a few tries.
So rather than fetch each page dynamically and parse it,
I decided to save the html pages to a more permanent location.

In addition, I wanted to include the date and title in the file names,
but not separate by directory, so I did a bit of parsing of the parent url
to generate the new string with the date included.

Finally, I also put in a short `sleep()` to pause the loop so the site doesn't
think it's being DDOS'ed.
Not that ~200 requests is all that heavy a load, but it's an old site,
and I didn't really notice the difference,
since I could write what I did while I was waiting.
"""

htmlout = joinpath(projectdir, "html_out")
isdir(htmlout) || mkdir(htmlout)

## this post wasn't available anymore, so I removed it
setdiff!(posturls, Set(["/webeasties/2010/12/26/weekend-review-all-about-the-g"]))
posturls

for url in posturls
    m = match(r"^/webeasties/(\d{4}/\d{2}/\d{2})/([\w/\-]+)$", url)
    isnothing(m) && error("url $url doesn't match")
    dt, title = m.captures
    dt = replace(dt, '/'=>"") # remove /, so eg 2013/01/25 becomes 20130125
    file = "$(dt)_$title.html"

    ## skips files that already exist since I ran into some errors, I didn't want to re-do them
    isfile(joinpath(htmlout, file)) || download("https://scienceblogs.com" * url, joinpath(htmlout, file))
    sleep(0.1)
end

md"""
Alright, I have a bunch of `html` files, what now?
"""
md"""
## Parsing posts

h/t: For this section, I got a bunch of inspiration [from here](https://hyphaebeast.club/writing/julia-web-scraping/#html-as-xml).

There's a bunch of [schmutz](https://jel.jewish-languages.org/words/503) in these html documents
used for ads, SEO, and linking around the site,
none of which I want.
So my task in this section is to pull out just the main post content,
any other relavent info (like title etc),
and put them into a markdown file.

Here, I'm using the [`EzXML.jl`](https://juliaio.github.io/EzXML.jl/stable/manual/#XPath-1) package
and its [XPath](https://www.w3schools.com/xml/xpath_intro.asp) query ability
to parse and search my `.html` files
(the HTML spec is just a flavor of XML).

### A note on writing loops

When I'm going to do something in a loop like this,
knowing it's going to take me a while to figure out exactly what to do,
I'll often pull some examples first.

For example, knowing I have an array of html file paths,
and that I'm going to loop through them with `for p in paths`,
the first thing I do is pull out just one example to work on.
"""

using EzXML

paths = readdir(htmlout, join=true)
p = first(paths) # for p in paths

post = readhtml(p)
doc = root(post)
## ...

## end

md"""
This way, once I get it working on one instance,
I can just delete the first line, uncomment the `for` loop bits,
and then run it on the whole thing.
I put in validation checks that throw errors if something violates my assumptions
(like the fact there should only be one `content` and one `title` node)
so that the loop will break and tell me where to look to fix my assumptions.
"""
md"""
### Getting stuff with XPath

My process here was not particularly fancy -
I went to the first post on the web,
copied the title and first couple of words of content,
then went to the html file and searched for them.
Happily, they appear in blocks that have unique selectors.
Actually, the title is in two places:

```html
<title>Why every &quot;OMG we&#039;ve cured cancer!!&quot; article is about melanoma | ScienceBlogs</title>

<h1 class="page-header"><span>Why every &quot;OMG we&#039;ve cured cancer!!&quot; article is about melanoma</span>
```

The `<title>` one is easier to grab, so I just went with that.
XPath lets you look for any node named "title", wherever it is.
Just to be sure there really is only one node,
I also made sure to check the length of the returned value.
"""
title = findall("//title", doc) # could have done `findfirst` instead, but then couldn't check if it's unique
length(title) != 1 && error("Expected only 1 title block, got $(length(title)) from $p")
title = first(title) # get it out of the array

title.content

md"""
The post itself is wrapped in `<div class="content">`,
which we can also easily find with XPath:
"""
body = findall("//div[@class=\"content\"]", doc)
length(body) != 1 && error("Expected only 1 content block, got $(length(body)) from $p")
body = first(body)

body.content

md"""
One issue with using the content here is that, in html,
links are nested elements inside other elements.
In the `body.content`, those links are stripped out.
For example, up above, `I went to a seminar at TSRI that...` in the `content` string
is actually `I went to a seminar at <a href="http://www.scripps.edu/e_index.html">TSRI </a>that...`
in the original html.

But, not to worry, those `<a>` links are just additional nodes
in the original `<div class="content">` node, so we can just find them with XPath.
The `body` node can still search the whole tree, so we use `.//`
to search inside this node
"""

links = findall(".//a[@href]", body)

length(links)

md"""
But there are only 10 links in the post.
It turns out there are some tags inside the `body` node that have their own links.
So instead, I grab the first nested `div`, and then search inside that.
"""

post = findfirst("./div", body)
links = findall(".//a[@href]", post)

length(links)

#-

post.content # this ends up being a little nicer too

md"""
What about those tags? They're inside the `body` node in a `<div class="field--item">` node.
To get the tag, and do a bit of validation in case the organization is different,
I decided to parse the link inside that `div` node.
That is, take something like

```html
<div class="field--item"><a href="/tag/other-uses-immune-system" hreflang="en">Other uses of the immune system</a></div>
```

And get the link `"/tag/other-uses-immune-system"`, so that I could make sure
it starts with `/tag/`.
"""

function gettags(body)
    tags = String[]
    tagnodes = findall(".//div[@class=\"field--item\"]", body)
    for tagnode in tagnodes
        a = findfirst("./a[@href]", tagnode)
        link = first(attributes(a)).content
        m = match(r"^/tag/([\w\-]+)$", link)
        isnothing(m) && error("Expected tag, got $link")
        push!(tags, m.captures[1])
    end
    return tags
end

gettags(body)

md"""
## Conclusion

So now we have all the pieces,
I'll save converting the posts to markdown for the [next post](/posts/2021/webeasties-2).
"""