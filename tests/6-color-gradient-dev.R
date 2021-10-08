# Develop the color gradient using dichromat package


library(dichromat)

devtools::load_all(".")

n <- 4

library(ggplot2)
theme_set(theme_bw())
library(dplyr)


# Simple stripe gradient
d0 <- data.frame(x = 1:n, y = 1, val = factor(1:n))
testplot <- d0 %>%
  ggplot(aes(x,y)) + geom_tile(aes(fill = factor(val) )) 

# Do a misc boxplots, 2-4 groups
# m <- 3
# g <- 4
# n <- g
# d0 <- data.frame(x = 1:m, g = rep(1:g, each=m), y = rnorm(m*g * m*g))
# testplot <- d0 %>%
#   ggplot(aes(factor(x), y, fill=factor(g) )) + geom_boxplot() 



# mains
col <- luke_pal()(n)
mains <- list(luke = luke_pal()(n), 
              viridis=viridisLite::viridis(n))
              #default = scale_fill_discrete()$palette(n),
              #Rdefault = palette("default")[1:n])



## check filters
filts <- c("", "deutan", "protan", "tritan", "desat")
p <- list()
  for(filt in filts){
for(coln in names(mains)){
  col <- mains[[coln]]
    z <- if(filt == "") col 
    else if(filt == "desat") {h <- rgb2hsv(col2rgb(col)); hsv(h[1,], 0, h[3,])}
      else dichromat(col, filt)
    p[[paste0(coln, filt)]] <- testplot + scale_fill_manual(values = z)  + 
      #theme_void() +
      labs(x=NULL, y=NULL) + 
      theme(legend.position="none", plot.title = element_text(hjust=.5)) + 
      ggtitle(paste0(coln, " ", filt))
  }
}

library(gridExtra)
gridExtra::grid.arrange(grobs=p, ncol = length(mains))


if(0){
  s <- seq(0, 1, l = 60)
  g <- expand.grid(hue=s, value=s)
  v <- hsv(g[,1], 1, g[,2] )
  plot(g, pch=15, col = v, asp = 1, cex=2.7)
  # 
  lc <- luke_colours("hsv")
  text(lc[1,], lc[3,])#, col = luke_colours(), pch=1)
}



if(0){
library(ggplot2)
ggplot(data.frame(x = rnorm(10000), y = rnorm(10000)), aes(x = x, y = y)) +
  geom_hex() + coord_fixed() + labs(x=NULL, y=NULL) + 
  scale_fill_luke_c() + theme_bw()
}

#
if(0){
  image(volcano, col = luke_pal(direction = -1)(12))
}