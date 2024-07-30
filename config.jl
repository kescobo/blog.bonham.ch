# Site information.

author = "Kevin Bonham"
author_blurb = "Senior Research Scientist"
author_short = "kbonham"

website_url = "http://blog.bonham.ch/"
website_title = "Blog dot Bonham dot C H"
website_descr = "Personal website of Kevin Bonham, PhD"

meta_descr = "Kevin Bonham's website"
meta_kw = "microbiome,data science,teaching"

# RSS settings

generate_rss = true
rss_website_url = website_url
rss_website_title = website_title
rss_website_descr = website_descr

tw_card = "summary"
tw_title = author_short
tw_descr = meta_descr

# Layout

footer_notice = """
  © 2024 $author · Powered by
    <a href="https://franklin.jl">Franklin.jl</a> &
    <a href="https://github.com/luizdepra/hugo-coder/">Coder</a>."""

nav_items = [
  "About" => "/about/",
  "Blog"  => "/posts/",
  "We, Beasties"  => "https://github.com/kescobo/blog.bonham.ch/tree/main/webeasties",
  "Contact me" => "/contact/"
]

# Franklin specifics

content_tag = ""
heading_link = false
heading_post = """
  <a class="heading-link" href="#HEADING_ID">
    <i class="fa fa-link" aria-hidden="true"></i>
  </a>
  """
fn_title = ""

# Social URLs for the home page

social_github   = "https://github.com/kescobo/"
social_gitlab   = "https://gitlab.com/kescobo/"
social_twitter  = "https://twitter.com/kevbonham/"
social_orcid    = "https://orcid.org/0000-0003-3200-7533"
social_mastodon = "https://www.scicomm.xyz/@kbonham"
social_linkedin = "https://www.linkedin.com/in/kevin-bonham-6a10b566/"
social_bluesky  = "https://bsky.app/profile/kevbonham.bsky.social"
rss_link        = "https://blog.bonham.ch/feed"

# Comments from Mastodon info

comments_host = "scicomm.xyz"
comments_username = "kbonham"

# other

ignore=["_drafts/", "webeasties/"]
