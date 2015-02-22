library(ggplot2)

# Probability of getting `rb` random bones from `np` piles.
# Don't pass negative/nonsensical values, please.
prbFromPiles <- function(np, rb) {
    #Manage funny business.
    np<-as.integer(np)[1]
    rb<-as.integer(rb)[1]
    if (rb > 2*np) return(0)
    
    # Below, we partition rb into sums of 1's and 2's.
    # `m` is the number of 2's and `n` is the number of 1's.
    d<-data.frame(m=0:((rb - rb%%2)/2))
    d$n<-rb-2*d$m
    d<-d[d$n+d$m<=np,] # Drop rows that require more than np piles.
    
    # Probability of getting np-n-m 0's, n 1's, and m 2's.
    d$p<-.75^(np-d$n-d$m)*.2375^d$n*.0125^d$m*choose(np, d$n)*choose(np-d$n,d$m)
    sum(d$p)
}

# Probability Mass Function of random animal bones from dusty piles
pmfFromPiles <- function(piles) {
    sapply(0:(piles*2), function(i) prbFromPiles(np=piles, rb=i))
}

# Compares the brute force calculation to the normal approximation
# for the given value
plotPiles <- function(piles) {
    mu<-.2625*piles
    sigma<-sqrt(.2185937*piles)
    x<-seq(-4,4,.1)*sigma + mu
    
    discrete<-data.frame(numBones=0:(piles*2), p=pmfFromPiles(piles))
    cont<-data.frame(numBones=x, p=dnorm(x, mean=mu, sd=sigma))
    
    ggplot(discrete, aes(x=numBones, y=p)) + 
        geom_point(aes(color="Discrete Calculation")) +
        geom_line(data=cont, aes(color="Normal Distribution")) + 
        scale_color_manual(name="",
                           values=c("Discrete Calculation"="red",
                                    "Normal Distribution"="black")) +
        guides(colour = guide_legend(override.aes = list(linetype=c(0,1),
                                                         shape=c(16, NA)))) +
        coord_cartesian(xlim=c(max(x[1],0),x[length(x)])) +
        labs(title=paste("Number of Bones from", piles, "Piles"),
              x="Random Bones Obtained", y="Probability")
    
}