+++
title = "The knock-out punch: Zinc Finger Nucleases"
pubdate = Date("2011-01-02")
tags = ["science-process", "technology"]
category = "webeasties"
+++

_This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

Like so many things, the problem is best explained with an analogy. Imagine a car parked in a dark garage (if you're a mechanic by hobby or trade, make it a computer). Someone hands you keys to the car, a flashlight and a piece of metal that she says belongs to a car similar to the one in the garage. Now, your task is to figure out what that the piece of metal is, and what it's for. Replace car with organism, piece of metal with gene and make the flashlight a whole lot smaller, and you have an idea of what biological research is like. For decades, those wanting to study human genes were like someone trying to figure out what a Ford part did, but only had access to Toyotas and Hondas. We have amazing biological tools to interrogate the workings of worms and mice (and many other model organisms), but we are limited (both technically and ethically) from using many of these tools to understand the workings of human genes.

But a new set of tools is being added to the kit that could drastically improve our understanding called zinc-finger nucleases.

But first, back to our darkened garage - how would you approach this problem? A strategy that many biologists use is the gene knock-out, which is the functional equivalent of finding that metal component on your toyota and ripping it out - it involves literally removing the DNA for the gene from the genome - and seeing what goes wrong. If the car doesn't start, and you can't get anything to work, this strategy may not be the best approach. Some genes are like this - without them, the cell just can't survive - but breaking many things isn't as catastrophic. Sometimes the engine starts, but the radio and dashboard don't turn on. Sometimes you can't put the car in gear, or it can only get to 1st gear. Sometimes the problem is so minor, you won't even notice that anything's wrong. All of these issues are incredibly useful starting points, putting you on the path to sorting out what the function of your component is. 
And so it is with gene knock-outs. Removing the DNA code for a gene in a bacterium is relatively simple, only slightly harder in worms and flies, and can be a bit laborious for organisms like mice, but this strategy is now common place in biological labs around the world. I won't get into the details here of how its done, except to mention that for mice, it requires growing fertilized embryos, injecting them with DNA as they're dividing and then breeding to select for offspring in which the gene is knocked out - things that no university ethics board would ever condone being done to humans. Besides, this particular technology doesn't work well in humans, or even in rats for that matter. There are other strategies we can use on human cell lines to reduce gene expression, or to block the function of particular proteins, but the only way to get true knock-outs is to wait for a patient that has a naturally occurring mutation in the gene you care about. As you might imagine, you could be waiting for a very long time.

But a relatively new technology could change that, and there are two papers in the most recent edition of Nature Methods that could dramatically increase the ease and effectiveness of [this technology](http://goo.gl/FCb5g).

Zinc-finger nucleases (ZFNs) can be used to create targeted double-stranded breaks in the genome and have thus generated much excitement. These enzymes consist of a DNA-binding portion, which can in principle be designed to target a particular location in the genome, and a Fok1 nuclease domain, which introduces the break.

First - the nuclease bit. A nuclease is just a protein that cuts nucleic acid (that's the "NA" part of DNA and RNA), and the Fok1 nuclease cuts DNA. But you can't just throw a nuclease into a cell and hope it cuts the gene that you care about, or only the gene you care about. You have to make it specific, and that's where the zinc-fingers come in.

A zinc-finger is a particular protein shape that likes to bind DNA. Lots of proteins have them, and they come in a lot of different forms. Some ZF's just bind any DNA willy-nilly, but many are specific for particular stretches of DNA. By linking up several of these specific zinc fingers, you can generate a protein construct that will bind to one location and one location only in the genome. If you then link this construct to your nuclease, you have generated a protein machine that will fly around the cell, bind specifically and uniquely to the site you want it to, and then clip it out. Magic!

It sounds complicated, but all of the molecular tools are readily accessible. Snapping together bits of different proteins has been done regularly for over half a century, and it's only getting easier. Still, a construct as complex as these ZFNs is a ton of work, and because of the fickle nature of biology, they won't always work. You can get a biotech company to do it for you for \$25k, but that's money that few research labs are willing or able to spend on a single tool. My boss was seriously considering hiring someone to work full time on making these constructs for our lab. But the methods outlined in these papers could streamline the process considerably. 
The [first paper](http://goo.gl/4xRNg) addresses one of the major hurdles: the DNA-binding bit. I mentioned that you can put together many zinc-fingers to generate specificity, but this modular approach doesn't always work. Take a look at this image from the [News and Views](http://goo.gl/GZEmM): 

In theory, if you know that the light blue zinc finger binds one region of DNA, and the green one binds an adjacent region, putting them together should mean that you can bind DNA where the green and blue are next to each other. In practice though, some zinc-fingers just don't work that well together, and you often need to combine 3 or 4 zinc fingers to get the required specificity, making the problem worse. By choosing each finger in isolation, a lot of your constructs simply won't work. This paper uses "context-dependent assembly," or CoDA. They took a database of known pairs of zinc-fingers that worked well together and did some data crunching - if you know that yellow+white works, and that white+blue works, then yellow-white-blue should also work. Indeed, by using this approach, this group targeted a number of different genes, with a pretty astonishing 50% success rate.

Using CoDA they then prepared ZFNs to 38 endogenous genes in zebrafish, and two species of plants. They were able to target 50% of the genes. To put these numbers in perspective, a recent comprehensive review listed about 50 endogenous genes that had been targeted by ZFNs over the past 10 years. Using CoDA, Sander et al. expanded this list by nearly 40% in a single study. 
The [second paper](http://goo.gl/yPt5w) deals with the nuclease part. I didn't tell you the whole story before - the Fok1 nuclease requires 2 parts. You could potentially stick both parts onto the same set of zinc-fingers, but then you run the risk of the nuclease cutting whatever DNA it runs into. Instead, the typical  ZFN strategy involves making 2 constructs, so that cuts will only happen when both pieces come together. The Fok1 protein found in nature has 2 parts, let's call them A and B, but it can function as AA, BB, or AB. This means that if you don't rigidly control where your zinc-fingers bind, you might cut DNA in off-target regions. To understand why, take the colored example in the image above. Using the naturally occurring Fok1 domains, you could also potentially cut anywhere the DNA is

or

It's possible to choose your DNA binding regions such that those DNA orientations don't exist anywhere in the genome, but this limits your options considerably. Many groups have instead mutated the naturally occurring enzyme to prevent AA or BB combinations from working, but these mutations have also dramatically decreased the activity of the desired AB pair. In this paper, the authors use a technique to screen new mutations that retain the requirement for AB, but brings the activity back up to nearly normal levels.

This technique is incredibly exciting, and will be munumentally useful. Any advances that can make it easier and put it into the hands of more labs is welcome. 
Sander, J., Dahlborg, E., Goodwin, M., Cade, L., Zhang, F., Cifuentes, D., Curtin, S., Blackburn, J., Thibodeau-Beganny, S., Qi, Y., Pierick, C., Hoffman, E., Maeder, M., Khayter, C., Reyon, D., Dobbs, D., Langenau, D., Stupar, R., Giraldez, A., Voytas, D., Peterson, R., Yeh, J., & Joung, J. (2010). Selection-free zinc-finger-nuclease engineering by context-dependent assembly (CoDA) Nature Methods, 8 (1), 67-69 DOI: [10.1038/nmeth.1542](review)

Doyon, Y., Vo, T., Mendel, M., Greenberg, S., Wang, J., Xia, D., Miller, J., Urnov, F., Gregory, P., & Holmes, M. (2010). Enhancing zinc-finger-nuclease activity with improved obligate heterodimeric architectures Nature Methods, 8 (1), 74-79 DOI: [10.1038/nmeth.1539](review)

      
  

 ## Post Images

- ![Image at http://scienceblogs.com/webeasties/upload/2010/12/the_knock-out_punch_zinc_finge/Screen shot 2010-12-30 at 5.38.09 PM.png](/_assets/img/webeasties/Screen shot 2010-12-30 at 5.38.09 PM.png)
- ![Image at http://scienceblogs.com/webeasties/upload/2010/12/the_knock-out_punch_zinc_finge/Screen shot 2010-12-30 at 7.42.10 PM.png](/_assets/img/webeasties/Screen shot 2010-12-30 at 7.42.10 PM.png)
- ![Image at http://scienceblogs.com/webeasties/upload/2010/12/the_knock-out_punch_zinc_finge/Screen shot 2010-12-30 at 7.45.55 PM.png](/_assets/img/webeasties/Screen shot 2010-12-30 at 7.45.55 PM.png)

