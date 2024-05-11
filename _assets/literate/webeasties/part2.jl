# ## Converting html to markdown
#
# I already figured out how to get all of the elements out of the HTML,
# now it's just a matter of making them into markdown.
#
# Let's review

using EzXML

function gettags(body)
    tags = String[]
    tagnodes = findall(".//div[@class=\"field--item\"]", body)
    for tagnode in tagnodes
        a = findfirst("./a[@href]", tagnode)
        link = first(attributes(a)).content
        m = match(r"^/tag/([\w\-]+)$", link)
        isnothing(m) && continue
        push!(tags, m.captures[1])
    end
    return tags
end

function getcontent(path)

    post = readhtml(path)
    doc = root(post)
    title = findall("//title", doc) # could have done `findfirst` instead, but then couldn't check if it's unique
    length(title) != 1 && error("Expected only 1 title block, got $(length(title)) from $p")
    title = first(title) |> nodecontent # get it out of the array

    body = findall("//div[@class=\"content\"]", doc)
    length(body) != 1 && error("Expected only 1 content block, got $(length(body)) from $path")
    body = first(body)
    
    tags = gettags(body)
    content = body.content
    links = findall(".//a[@href]", body)
    imgs = findall(".//img", body)

    return (; path, content, title, post, links, tags, imgs)
end

#-

htmlout = normpath("./_assets/literate/webeasties/html_out")
paths = readdir(htmlout, join=true)

stuff = getcontent(last(paths))
print(first(stuff.content, 1000), "...")

#-

first(stuff.links, 4)

#-

stuff.tags

# This the [last post](https://scienceblogs.com/webeasties/2013/09/03/we-beasties-sproulates)
# I made on the blog in 2013.
# It's got some pictures and a bunch of links, but not much other formatting,
# so should be pretty straightforward.
#
# The first thing I decided to tackle was how to deal with the links...
# 
# ### Link nodes
#
# Looking inside the contents of each element of `links`,
# it looks like all of the useful info I need is there:

link = stuff.links[2]
nodecontent(link)
#-
nodecontent(first(attributes(link)))

md"""
So all I need to do to start building the markdown is to find the text
inside `stuff.content`, and replace it with a markdown link.
Eg, `Paul de Kruif's` will become `[Paul de Kruif's](http://www.amazon...)`.

This is easily done with julia's `replace()` function.
"""

function make_md_links(content, links)
    for lnk in links
        repstring = nodecontent(lnk)
        link = nodecontent(first(attributes(lnk)))
        isempty(repstring) && continue # first link doesn't have anything in it
        any(ext -> endswith(link, ext), [".png", ".jpeg", ".jpg"]) && continue # skip images
        content = replace(content, repstring=> 
                                   string("[", repstring, "](", link, ")"),
                                   count=1)
    end
    return content
end

linkified = make_md_links(stuff.content, stuff.links)
print(first(linkified, 500), "...")

md"""
Easy!

Much harder is dealing with images.
When I was blogging back then, I didn't understand the importance
(for accessibility) of including link text,
so most image links are going to have empty content.

But I don't really need to reproduce these posts exactly,
so I settled on just downloading the images (if they exist)
and putting them all at the end.
"""


function append_image_links(content, links, imgs)
    ## don't proceed if there are no image links
    if isempty(imgs) && !any(lnk-> any(ext -> endswith(nodecontent(first(attributes(lnk))), ext), [".png", ".jpeg", ".jpg"]), links)
        return content
    end

    content *= string("\n\n ## Post Images\n\n")
    for lnk in links
        alttext = nodecontent(lnk)
        link = nodecontent(first(attributes(lnk)))
        isempty(alttext) && (alttext = string("Image at $link"))
        if any(ext -> endswith(link, ext), [".png", ".jpeg", ".jpg"])

            targetpath = joinpath("_assets", "img", "webeasties", basename(link))
            if !isfile(targetpath) # skip if already downloaded
                try
                    download(link, targetpath)
                catch
                    @error "Couldn't download $link, skipping"
                end
            end
            if !isfile(targetpath)
                content *= string("- ", "![", alttext, "](/", targetpath, ")\n")
            else
                content *= string("- Missing image: ", alttext, " | ", link, "\n")
            end
        end
    end

    for img in imgs
        link = findall(".//@src", img) |> first |> nodecontent
        alttext = findall(".//@alt", img)
        alttext = isempty(alttext) ? "image at $link" : alttext |> first |> nodecontent
        if startswith(link, "/files/")
            targetpath = joinpath("_assets", "img", "webeasties", basename(link))

            if !isfile(targetpath) # skip if already downloaded
                download(string("https://scienceblogs.com", link), targetpath)
            end
            content *= string("- ", "![", alttext, "](/", targetpath[2:end], ")\n")
        end
    
    end
    return content
end

#-

with_images = append_image_links(linkified, stuff.links, stuff.imgs)

print(last(with_images, 300))

md"""
## Saving the markdown

Now I've got the content, it's time to save it.
For the purposed of this post,
I'll stick it in a temporary directory,
but eventually, I want it to go into `webeasties/`
in the repository for this website
so that I can build them with Franklin.
"""

mdoutput = mktempdir()

mdoutput = "webeasties"
isdir(mdoutput) || mkdir(mdoutput)

for p in paths
    @info p
    post = getcontent(p)
    post_text = replace(post.content, r"(\S)\n(\S)"=> s"\1\n\n\2") # replace stand-alone new lines with doubles
    post_text = replace(post_text, r"\n+\s{4}Tags\n.+$"s=>"") # replace garbage at the end of each post
    post_text = replace(post_text, '$'=> raw"\$") # franklin doesn't like these
    post_text = replace(post_text, r"^\s{4,}"=> "") # remove leading spaces
    post_text = replace(post_text, r"\n{3,}"s=> "\n\n") # remove anything more than 3 newlines
    post_text = make_md_links(post_text, post.links)
    post_text = append_image_links(post_text, post.links, post.imgs)


    (y, m, d, postfile) = match(r"^(\d{4})(\d{2})(\d{2})_(.+)", basename(post.path)).captures

    t = replace(post.title, r" \| ScienceBlogs$"=>"")
    t = replace(t, '"'=> "'")
    outdir = joinpath(mdoutput, y)
    isdir(outdir) || mkdir(outdir)

    open(joinpath(mdoutput, y, replace(postfile, r"html?$"=>"md")), "w") do io
        print(io, """
        +++
        title = "$t"
        date = Date("$y-$m-$d")
        tags = $(post.tags)
        category = "webeasties"
        +++

        _This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

        $post_text
        """)
    end
end

md"""
And that's it!
You can now see the [archive here](/webeasties)
"""
