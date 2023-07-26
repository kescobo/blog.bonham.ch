+++
title = "Saturday Review: The Inflammasome!"
pubdate = Date("2010-11-20")
tags = ["pattern-recognition"]
category = "webeasties"
+++

_This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

This week, I'm going to take a[ break](http://scienceblogs.com/webeasties/2010/11/saturday_review_oral_[vaccines](http://scienceblogs.com/webeasties/2010/11/vaccine_delivery_from_an_immun.php).php) from vaccines and do some innate immunity. Today's topic: the provocatively named "Inflammasome." [This Nature Review](http://goo.gl/efEoL) from last month focused on inflammasomes and anti-viral immunity, but I think the inflammasome itself needs its own post.

A breakthrough in our understanding of the mechanisms that control the activation of inflammatory caspases came from the identification and characterization of the inflammasome, a large (~700 kDa) multiprotein complex that recruits inflammatory caspases and triggers their activation. Inflammasomes are often defined by their constituent PRR family member, which functions as a scaffold protein to bring caspase-1 molecules together and mediate proximity-induced auto-activation of caspase-1. 
I'm going to spend this entire post trying to explain that one paragraph. Let's start at the beginning.

Note: the TL;DR version below

When immune cells like macrophages encounter bacteria and viruses they have a few typical responses, and one of the most important responses is the production of pro-inflammatory cytokines. [Cytokines](http://en.wikipedia.org/wiki/Cytokine) are signaling proteins of the immune system; they are secreted by cells to communicate information to other cells. Pro-inflammatory cytokines then, are cytokines that induce inflammation. There are a lot of pro-inflammatory cytokines produced by macrophages, with names like tumor necrosis factor ([TNF](http://en.wikipedia.org/wiki/Tumor_necrosis_factor-alpha)), interleukin 1 and interleukin 6 (IL-1 and IL-6). If a macrophage sees a bacterium, it will make TNF, IL-1 and IL-6 (along with many others). If it sees viruses, it will make all the same cytokines (and some others). But in order to study how this works, scientists started to use purified ligands to make things easier. If I want to study how a particular receptor (like [TLR4](http://scienceblogs.com/webeasties/2010/11/immune_response_from_start_to_1.php)) works, I don't want to use whole bacteria - they have a ton of different molecules that might activate tons of different receptors, and I wouldn't be able to tell what TLR4 itself was doing.

So instead I use purified lipo-poly saccharide (LPS), which is a molecule that uniquely activates TLR4 (also called a (ligand"). But when scientists first started using these ligands, they noticed something weird. If they measured what the cells secreted, they found TNF and IL-6, but no IL-1. When they looked inside the cells, on the other hand, there was plenty of IL-1. So there was no problem with the production of IL-1, it just wasn't getting out of the cell.

This is where I need to talk about caspases. [Caspases](http://en.wikipedia.org/wiki/Caspase) are a large family of proteases - which means they cut other proteins. Some proteases are fairly non-specific, they'll chew up lots of different proteins at lots of different places. Caspases are much more specific; they are very particular about what proteins they cut, and where those cuts are made. It turns out that when IL-1 is made, it's made in a immature form called pro-IL-1 that can't be secreted until it's cleaved in half by caspase-1. Once this happens, IL-1 can make its way out of the cell and do its thing. But there's always some caspase-1 in the cell, so why isn't pro-IL-1 cleaved immediately?

In general, caspases do very dangerous things. Inflammation triggered by IL-1 can be very destructive, so it needs to be kept in check (more on that later), and other caspases are involved in the signaling cascade that causes cell suicide (apoptosis). This means that caspases need to be tightly regulated, so caspases are first made in an inactive form: pro-caspase. Just like IL-1, in order to be fully active, a caspase must be cut by another protease (usually another caspase). 
This is where the inflammasome comes in. It's just a fancy name given to a large complex of proteins whose function is to activate caspase-1 and allow inflammation. Inflammasome assembly is initiated by a pattern recognition receptor (PRR) binding to its ligand. This allows the PRR to recruit a protein called ASC, which then recruits a bunch of pro-caspase-1 molecules, forming a wheel-like structure (where caspase-1 forms the spokes). When a lot of caspase-1 is forced into close proximity by the inflammasome, they are able to cleave each other, activating the whole complex (as soon as one gets cleaved and activated, it will immediately cleave and activate all of its neighbors). Once the complex is activated, it can go on to cleave any pro-IL-1 in the cell, and allow it to be secreted. 

[Adapted from [doi:10.1038/nri2296](http://www.nature.com.ezp-prod1.hul.harvard.edu/nri/journal/v8/n5/fig_tab/nri2296_F2.html)]

TL;DR version: PRR assembles inflammasome --> inflammasome activates caspase-1 --> caspase-1 activates IL-1 --> IL-1 gets secreted.

You may be wondering, "why is any of this necessary?" It's hard to definitively answer "why" questions in biology, but one idea is the danger hypothesis. Our bodies are swarming with bacteria, fungi and viruses, but most of them won't end up doing any harm. The pattern-recognition receptors of the innate immune system can't distinguish between the good guys and the bad guys. The inflammasome is triggered by signals of danger (DNA in the cytoplasm and membrane damage for instance), so if a cell sees a bacteria, and there's some signal that something is wrong, you want to induce inflammation, but if there's only bacteria, but no danger, or there's danger but no pathogen, inflammation can be destructive.

The inflammasome was only discovered in 2002, so there's a lot we don't know, but it's a fascinating and complex field. Take a look at that first paragraph and see if it makes sense now. If it still doesn't, please let me know, I'm still working on how to explain complex topics like this. Too much detail? Too little?

Kanneganti, T. (2010). Central roles of NLRs and inflammasomes in viral infection Nature Reviews Immunology, 10 (10), 688-698 DOI: [10.1038/nri2851](review)

      
  

 ## Post Images

- ![Image at http://scienceblogs.com/webeasties/Screen%20shot%202010-11-20%20at%205.39.49%20PM.png](/_assets/img/webeasties/Screen%20shot%202010-11-20%20at%205.39.49%20PM.png)

