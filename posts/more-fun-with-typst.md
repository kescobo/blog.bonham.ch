+++
using Dates
draft = true
title = "More Fun with Typst - Building a CV"
date = Date(2024, 5, 13)
+++

I'm so predictable. 

Last November, I [wrote a post](/posts/typst-job-apps) about `typst`,
a new type-setting software written in rust that's meant to replace $\latex$.
In that post, I said,

> Well, I didn't get a job in that round,
  so I'm at it again!
  For realsy reals, this is the last year I'm doing this.

Well, I didn't get a job in this round either.
I got close with one - full two-day interview.
They said they loved my science,
they said that they liked me,
they said I did a great job explaining computational concepts
to the wetlab folks (which should have meant a lot,
since the job was about bringing "novel computational techniques"
to the department)...

But they weren't sure I was the right "fit".
I'm not sure, but this sounds like code for
"we can't think of a good reason, but we went with someone else".

Anyway, I'm now waffling on whether I want to try again after all.
But in the mean time, I'm working on my CV and resume in typst,
and continuing to love it.
As I mentioned in that last post,
I was able to build my entire CV from scratch,
replicating the layout that I'd needed a template for in $\latex$.
This means I actually understand all of the components,
so I can tweak them to my liking.
Plus, I recently figured out how to build and post
the pdfs using CI machinery on gitlab. Fun!

## The Basics

Typst is a markup language, which means you can get some stlying
from 
