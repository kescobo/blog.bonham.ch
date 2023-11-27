+++
using Dates
title = "Fuel from Seaweed"
date = Date("2012-01-26")
tags = ["energy", "microbial-metabolism", "technology", "awesome", "research"]
category = "webeasties"
+++

_This post initially appeared on [Science Blogs](http://scienceblogs.com/webeasties)_

I grew up on the coast of California, and I loved to surf. At my favorite break, [Pleasure Point](http://en.wikipedia.org/wiki/Pleasure_Point,_Santa_Cruz,_California), the best waves were often at low tide, but low tide also meant seaweed. Lots of seaweed. 

[Source]

The [giant kelp of Monteray Bay](http://www.montereybayaquarium.org/animals/AnimalDetails.aspx?enc=VsGX+Lst7QYHpwOfiv1R9w==) is an astonishing organism. It's not actually a plant, it's a brown algae, and it can grow 12 inches per day. This rapid growth makes it an ideal resource, and a bane of surfers that get their fins caught in thick mats.

You can't tell, but it was definitely kelp that made me fall, not the fact that I was too far forward and unable to turn. No, really...

Brown algae like kelp can be harvested as a source of [algin](http://en.wikipedia.org/wiki/Alginic_acid), and other types of seaweed are also used as sources for products like [agar](http://en.wikipedia.org/wiki/Agar_agar) that we use in labs to make bacterial culture plates. 
But there's also been a lot of interest in using different sorts of algae as feedstocks for the production of biofuels. Their rapid growth makes them eminently renewable, they require almost no effort to cultivate, no fertilizer, no fresh water, they would not use up arable land that can be used for food crops. The main draw back is that one of the most abundant sugars present in algae, called alginate, is not digestible by the microorganims currently used for biofuel production at an industrial scale. Until now.

[An Engineered Microbial Platform for Direct Biofuel Production from Brown Macroalgae
](www.ncbi.nlm.nih.gov/pubmed?term=22267807)
It turns out there are a number of microbes that have been shown to digest alginate. Other groups have engineered those organisms to be able to produce ethanol, but those bugs aren't super robust when grown under lab conditions, and it's harder to genetically manipulate bacteria that you don't have a lot of experience with. Adam J. Wargacki and his colleagues took the opposite approach - instead of getting the genes for making ethanol into a relatively unknown microbe that can digest alginate, why not grab the genes for digesting alginate and stick them in E. coli? Scientists have been picking this bug's locks for decades, and it's already been engineered to make not just ethanol, but many other useful products as well. 
And that's exactly what they did. Only it's a bit more complicated than I've let on here. It's not a single enzyme that's necessary to break down alginate into something that can be turned into ethanol by E. coli. Alginate is naturally found in long chains of repeating sugars - a polymer - which means you can't really get it inside bacterial cells, so the first step is to get the bacterium to make an enzyme that cuts up the polymer into smaller pieces. However, just making this enzyme isn't enough, you need the bug to pump that enzyme out into the extracellular space. 
So Wargacki et. al. selected an alginate lyase (an enzyme that can bust up those long polymers) that had been previously described, and modified it to be recognized and secreted by a simple E. coli transporter. When they expressed both this modified enzyme and the transporter, they detected rapid production and secretion of the enzyme, and it was incredibly active. But they weren't done yet.

The long polymer of alginate could now be broken up, but the small pieces would still need to get into the bacterial cell, and then converted into a type of sugar than E. coli can use to make ethanol. So Wargacki and friends turned to another organism known to be able to import and digest alginate - Vibrio splendidus (splendid!) - and managed to pull out of its genome a series of enzymes used for exactly those purposes and clone these genes into an expression vector usable in E. coli. Writing it up like this makes it seem easy, but in what I described in this paragraph is an unbelievable amount of work. 
The last figure shows the end result. They cultured their newly engineered E. coli, complete with enzymes, exporters and importers, with brown algae, and checked on the concentration of various products at different time points. Alginate is in green, and ethanol is in blue.

They ended up getting 4.7% alcohol by volume, which pretty close to the benchmark for biofuel production from cellulosic feedstocks like corn. It's also similar to the a.b.v. of many beers, though I'm not sure I'm ready for a seaweed brew just yet. Maybe after a long day of surfing...

Wargacki, A., Leonard, E., Win, M., Regitsky, D., Santos, C., Kim, P., Cooper, S., Raisner, R., Herman, A., Sivitz, A., Lakshmanaswamy, A., Kashiyama, Y., Baker, D., & Yoshikuni, Y. (2012). An Engineered Microbial Platform for Direct Biofuel Production from Brown Macroalgae Science, 335 (6066), 308-313 DOI: [10.1126/science.1214547](review)

      
  

 ## Post Images

- ![Image at http://scienceblogs.com/webeasties/wp-content/blogs.dir/368/files/2012/04/i-ad407fba9462728edaebc725630c2ee4-kelp-catalina-island_255_600x450.jpg](/_assets/img/webeasties/i-ad407fba9462728edaebc725630c2ee4-kelp-catalina-island_255_600x450.jpg)
- Missing image: [Source] | http://ocean.nationalgeographic.com/ocean/photos/kelp-gardens/#/kelp-catalina-island_255_600x450.jpg

