+++

prepath = "categorical-ambiguity"
generate_rss = true
rss_website_url = "https://kescobo.github.io/categorical-ambiguity/"
rss_website_title = "Kevin Bonham dot com"
rss_website_descr = "Personal website of Kevin Bonham, PhD"

# Layout information.

author = "Kevin Bonham"
author_blurb = "Senior Research Scientist"
author_short = "kbonham"

meta_descr = "Kevin Bonham's website"
meta_kw = "microbiome,data science,teaching"

tw_card = "summary"
tw_title = author_short
tw_descr = meta_descr

website_url = rss_website_url

footer_notice = """
  © 2022 $author · Powered by
    <a href="https://franklin.jl">Franklin.jl</a> &
    <a href="https://github.com/luizdepra/hugo-coder/">Coder</a>."""

nav_items = [
  "About" => "/about/",
  "Blog"  => "/posts/",
  "Projects" => "/projects/",
  "Contact me" => "/contact/"
]

# Social URLs for the home page

social_github   = "https://github.com/kescobo/"
social_gitlab   = "https://gitlab.com/kescobo/"
social_twitter  = "https://twitter.com/kevbonham/"
social_polywork = "https://www.polywork.com/ksbonham"
social_linkedin = "https://www.linkedin.com/in/kevin-bonham-6a10b566/"
rss_link        = "https://kevinbonham.com/index.xml"

# Layout / Franklin specifics

content_tag = ""
heading_link = false
heading_post = """
  <a class="heading-link" href="#HEADING_ID">
    <i class="fa fa-link" aria-hidden="true"></i>
  </a>
  """
fn_title = ""

ignore=["_drafts/"]
+++

\newcommand{\html}[1]{~~~#1~~~}
