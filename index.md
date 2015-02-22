---
title       : Games Are Fun
subtitle    : (And So Is Math)
author      : Jason Schadewald
job         : Remember, this title counts as a slide. :)
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---


## The Challenge to Overcome

1. You play [The Kingdom of Loathing](www.kingdomofloathing.com)
2. You want a new in-game pet, the [Misshapen Animal Skeleton](http://kol.coldfront.net/thekolwiki/index.php/Misshapen_Animal_Skeleton), to help combat your enemies
3. You have some [dusty piles of animal bones](http://kol.coldfront.net/thekolwiki/index.php/Dusty_pile_of_animal_bones) and some [dusty animal bones](http://kol.coldfront.net/thekolwiki/index.php/Dusty_animal_bones)
4. "Using" one pile gets you:
   * 75% chance of producing nothing
   * 23.75% chance of generating one random dusty animal bone
   * 1.25% chance of generating two random dusty animal bones
5. You are "not really a math person"
6. Oh, and there are a total of 100 distinct bones required for the skeleton
7. Most importantly, you want to know how many of these things you need to collect in order to claim your prize.


--- 

## The Solution

I did the math for you! http://jschadewald.shinyapps.io/KoLStats

See how it's not normally distributed for small values? The shiny app takes that into account by using a fully accurate discrete calculation when the number of "piles" entered by the user is < 100.  For values >= 100, the normal approximation is used instead.


```r
source("pitch.R") #View pitch.R at https://github.com/jschadewald/CourseraPitchProject
plotPiles(5)
```

![plot of chunk modelPiles](assets/fig/modelPiles-1.png) 


--- 

## More of the Solution

Also, it's not Poisson because the mean and variance are not equal.

mean = ```0*.75 + 1*.2375 + 2*.0125``` = 0.2625

var = ```0^2*.75 + 1^2*.2375 + 2^2*.0125 -.2625^2``` = 0.2185937


And here's the crazy equation for the probability of getting $ u $ unique values in a string of length $ \ell $ where the alphabet has $ n $ letters and where the possible values of $ u $ are taken from a set of size $ k $ , which itself is a subset of $ n $.

$$ \frac{1}{n^{\ell}} \binom{k}{u} \sum_{i=0}^{\ell - u} \left( (n-k)^i \binom{\ell}{\ell-i} \sum_{j=0}^{u-1} (-1)^j (u-j)^{\ell-i} \binom{u}{j} \right) $$

That was not easy to figure out! I might create a separate pdf for RPubs just to go into descriptive detail about that formula.

--- 

## Future Work

1. Make it run faster
2. Combine into a compound probability distribution
3. Add more fun, witty comments
4. Add a new plot for the "crazy formula" that predicts the number of dusty animal bones you'll get (i.e. if you have 90, it'll tell you how many of the remaining 10 you're likely to get)
5. Look into a Gamma or Beta prime distribution model for the crazy formula since the discrete calculation has intermediate terms that are too big for the computer to handle
6. Use [these examples](http://www.r-bloggers.com/slidify-did-that-and-that-and/) to better understand the value of slidify

Thanks for your time and consideration!
