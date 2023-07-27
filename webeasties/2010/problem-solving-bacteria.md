+++
title = "Problem Solving Bacteria"
pubdate = Date("2010-11-17")
tags = ["microbiology", "technology", "bioengineering", "e-coli-0", "igem", "sudoku", "microbiology"]
category = "webeasties"
+++

_This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

This is just [awesome](http://goo.gl/x1Nhu):

A strain of Escherichia coli bacteria can now solve [sudoku] puzzles

[...]

"Because sudoku has simple rules, we felt that maybe bacteria could solve it for us, as long as we designed a circuit for them to follow," says team leader Ryo Taniuchi.

The mechanism is ingenious and yet straightforward at the same time.

Basically, they have 16 different strains of bacteria, with each initial strain representing a spatial coordinate on a 4x4 grid. Each bacterium has a "4C3 leak" system, which is a chunk of DNA that the team designed that has 4 possible outputs. Depending on incoming signals, different chunks of that DNA will be excised, leaving only 1 output remaining.

Once there is only 1 element left, that bacterium is "differentiated," and starts making viruses that can transmit information about its location and identity. Bacteria strains in the same row, column or section can receive information from that bacterium, but others express special anti-sense RNA sequences that will silence incoming viruses from other locations (this probably doesn't make sense if you've never played sudoku before - you can check out the team's [abstract](http://goo.gl/EgxC3) to learn more).

All 16 strains are thrown into a flask to grow together, with a few of the strains pre-differentiated to start the puzzle off - once these have communicated to all of their neighbors, each strain "location" will differentiate and transmit that new information to its neighbors, and the puzzle will solve itself. The information in this culture flask must then be visualized by taking the viruses floating around in the flask and adding them to another set of engineered bacteria which are plated out in a 4x4 grid, and express particularly colored fluorescent proteins.

I think that the viruses and bacteria used in this system can barely even be called viruses and bacteria. We don't call a hammer "shaped steel with a rubber grip," even though that's what it's made from. These "organisms" are so heavily engineered, so sculpted to our ends that they are barely a shadow of their former selves. They are membrane-enclosed tools. And we're only getting better at these sorts of manipulations.

Like I said - awesome.

      
  
