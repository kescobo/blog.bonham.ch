using Literate
using TimeZones

@reexport using Dates
import Hyperscript as HS

node = HS.m

# March 5, 2019
date_format(d) = Dates.format(d, "U d, yyyy")

function hfun_dfmt(p::Vector{String})
    d = getlvar(Symbol(p[1]))
    return date_format(d)
end

function modtime()
    path = get_rpath()
    mt = read(pipeline(`git log -1 --pretty="format:%ci" $path`), String)
    isempty(mt) && return today()
    return ZonedDateTime(mt, "y-m-d H:M:S z")
end


function hfun_date_modified()
    mt = modtime()
    return date_format(mt)
end

function ismodified()
    d = getlvar(:date)
    mt = modtime()
    Date(mt) > d
end

## Reading time function - see: https://www.roboleary.net/programming/2020/04/24/pimp-blog-reading-time.html#how-will-we-calculate-it

# ===============================================
# Logic to show the list of tags for a page
# ===============================================

function hfun_page_tags()
    tags = get_page_tags()
    base = globvar(:tags_prefix)
    return join(
        (
            node("span", class="tag",
                node("a", href="/$base/$id/", name)
            )
            for (id, name) in tags
        ),
        node("span", class="separator", "•")
    )
end


# ===============================================
# Logic to retrieve posts in posts/ and display
# them as a list sorted by anti-chronological
# order.
#
# Assumes that 'date' and 'title' are defined for
# all posts.
# ===============================================

function hfun_list_posts(t::String)
    return string(
        node("ul",
                (
                    node("li",
                        node("span", class="date", Dates.format(p.date, "U d, yyyy")),
                        node("a", class="title", href=p.href, p.title)
                    )
                    for p in get_posts(t)
                )...
            )
        )
end
hfun_list_posts() = hfun_list_posts("")


function get_posts(t::String, basepath::String="posts")
    # find all valid "posts/xxx.md" files, exclude the index which is where
    # the post-list gets placed
    paths = String[]
    for (root, dirs, files) in walkdir(basepath)
        filter!(p -> endswith(p, ".md") && p != "index.md", files)
        append!(paths, joinpath.(root, files))
    end
    # for each of those posts, retrieve date and title, both are expected
    # to be there
    posts = [
        (
            date  = getvarfrom(:date, rp),
            title = getvarfrom(:title, rp),
            href  = "/$(splitext(rp)[1])",
            draft = getvarfrom(:draft, rp),
            tags  = get_page_tags(rp)
        )
        for rp in paths
    ]
    sort!(posts, by = x -> x.date, rev=true)
    if !isempty(t)
        filter!(
            p -> t in values(p.tags) && !isnothing(p.draft) && !p.draft,
            posts
        )
    end
    return posts
end

function hfun_webeasties_posts(t::String)
    return string(
        node("ul",
                (
                    node("li",
                        node("span", class="date", Dates.format(p.date, "U d, yyyy")),
                        node("a", class="title", href=p.href, " " * p.title)
                    )
                    for p in get_posts(t, "webeasties/")
                )...
            )
        )
end
hfun_webeasties_posts() = hfun_webeasties_posts("")
