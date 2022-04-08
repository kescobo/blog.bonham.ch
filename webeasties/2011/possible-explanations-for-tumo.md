+++
title = "Possible explanations for Tumor Vaccine study"
using Dates
date = Date("2011-06-21")
tags = ["immune-system", "other-uses-immune-system"]
category = "webeasties"
+++

_This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

Abbie over at ERV has a [really great summary](http://scienceblogs.com/erv/2011/06/viruses_and_prostate_cancer.php) of a new [Nature Medicine paper](http://www.nature.com/nm/journal/vaop/ncurrent/abs/nm.2390.html), in which the authors managed to turn a mouse's immune system against prostate tumors by infecting them with viruses engineered to express prostate proteins. Some of the results struck her as a bit counterintuitive, but I thought of some possible explanations. I was going to leave this as a comment on her blog, but the more I read the paper, the more stuff bubbled up, and I though it deserved a full post. Go read Abbie's post first though, or this probably won't make much sense.

Admittedly speculative explanations to follow:

This vaccine is not causing autoimmunity when it is injected intravenously. But it does induce autoimmunity if you inject the vaccine directly into the prostate.

I dont know how that works.

I think there are two explanations here (not mutually exclusive). The first is that the dose of virus used for the direct injection into the prostate is effectively MUCH higher. They use the same number of viruses (1 x 10^7 PFU) for both treatments, but in the intravenous injections, those viruses are going everywhere in the body. That means there will be lots of small infections, many of which will be effectively dealt with by the innate immune system. And the T-cells that do get activated will have to clear that local infection before wandering into the prostate and realizing there's something interesting there too. This will make space for other regulatory systems to kick in, and since most of the infections will be far from the prostate, you won't run as much risk of [epitope spreading](http://en.wikipedia.org/wiki/Molecular_mimicry#Epitope_spreading)

But I think the better explanation is that what they're seeing isn't actually "autoimmunity." Rather, it's probably due to the destruction virus-infected non-tumor cells. Putting 10 million infectious virions in one small tissue area means that A LOT of non-tumor cells are going to be infected and potentially targeted by T-cells. They try to control for that with a virus that encodes GFP (a protein from jellyfish), but that's a single protein with a limited number of potential T-cell epitopes. A better control would have been using a viral library from a different tissue (they already have one for B-cells! why didn't they use it?).

One possible detraction from this point is that say that immune cells from the locally injected mice respond to normal prostate tissue in vitro. But they don't show the data. They also don't mention what happens after 60 days out with the locally injected mice, but DO say that the intravenously injected mice were fine after 60 days (they don't show that data either). Once the mice clear the VSV infection, what happens? If it's really autoimmunity, the prostate should continue to be attacked. Plus, they should be able to transfer autoimmunity by transferring immune cells into healthy (uninfected) mice, but they didn't do that experiment.
But how the heck is a vaccine with a normal prostate clearing prostate tumors and not killing the normal prostate tissue??

Normally, T-cells that are reactive against your normal proteins are deleted before they can get out and do damage. Even though cancer cells are technically "self," they usually have tons of mutations, and the hope with cancer vaccines has been to direct the immune system against these so-called "altered self" proteins. So Abbie's question is legit, but I think she answers it herself later on.

> ...they used human prostate cDNA in mice, which worked better than mouse prostate cDNA in mice

The human prostate proteins are not "self" to the mouse. Our proteins are very similar to mouse proteins, but there are definitely differences. And those differences might look like the differences in the cancer cells - differences T-cells can exploit.

And theyre doing this via a prostate-specific Th17 response (whiiiiich is usually indicative of autoimmunity) and CD4 T-cell response (think antibodies) instead of CD8 (cytotoxic T-cells) or Natural Killer cells, the cells who normally clear tumors.

CD4 cells have a lot of jobs. There are a bunch of different types, and we don't need to go into everything here, but basically, they tell other cells what to do and help them do it better (for instance, As Abbie mentioned, they can activate B-cells to make the right type of antibodies). Th17 cells are a type of CD4 cell that is usually seen in infections with extracellular pathogens, and in some types of autoimmune diseases. These cells are very inflammatory and have a bunch of effects on non-immune cells, and they can recruit really destructive immune cells called neutrophils. But all of these effects are non-specific. 
It's the CD8 T-cells that are able to zero in on specific cells and destroy them without touching their neighbors, but in the text of the paper, they say that CD8 cells are not involved:

therapy was dependent upon CD4+ T cells but not CD8+ T cells or natural killer (NK) cells (Fig. 3h).

However, the data they present seems to directly contradict this statement. To do the experiment, they repeated the viral treatment, but depleted different cell types, and plotted how many mice stayed alive. 

The top (ASEL) line shows just the viral treatment - after 50 days, 100% of the mice survived - sweet. If they depleted NK cells (orange), a couple of the mice died around day 30, but it didn't seem to have a huge effect. When they got rid of CD4 cells, all of the mice were dead by 20 days - clearly indicating that CD4 cells are important. But they get the exact same survival curve (black) when they deplete CD8 cells. I've read this section like 10 times trying to figure out what I'm missing, but at least based on the data, it looks pretty CD8 dependent to me.

In fact, since the survival curves overlap so perfectly, I wonder if the Th17 cells are important at all. They claim that there's a Th17 response and not a Th1 response (again - "data not shown"), but they don't actually show that the Th17 response is required. But CD4+ T helper cells ARE required to "license" (activate) CD8+ killer cells. 
It's a cool paper, but the more I read it, the more dodgy the immunological explanations seem. The weird thing is, none of their kooky immunology is required to make this a cool paper - even if everything I wrote above is right, the results are still awesome. But honestly, after re-reading this a number of times, I'm kinda surprised some of these glaring errors made it past reviewers.


 ## Post Images

