# ggtheme
devtools::load_all()

library(ggplot2)
library(dplyr)
# 
if(0) {
  # basic point plots
  n <- 100; p <- 4
  d <- data.frame( x = 1:n, y = rnorm(n*p), z = rep(as.character(1:p), each=n) )
  p1 <- d %>% ggplot(aes(x,y, colour = z)) + geom_point()  + ggtitle("Pisteitä joo") + scale_color_luke()
  gridExtra::grid.arrange(p1, p1+theme_luke())
}
if(0) {
  # boxplots
  n <- 100; p <- 4
  d <- data.frame( x = 1:n, y = rnorm(n*p), z = rep(as.character(1:p), each=n) )
  p1 <- d %>% ggplot(aes(y=y, fill = z)) + geom_boxplot()  + ggtitle("boxii") + scale_fill_luke(begin=0, end=1)
  gridExtra::grid.arrange(p1, p1+theme_luke())
}
# sliding
if(0) {
  n <- 100; p <- 10
  d <- data.frame( x = 1:n, y = rnorm(n*p), z = rep(1:p, each=n) )
  p1 <- d %>% 
    ggplot(aes(x, y=y, color = z)) + geom_point()  + ggtitle("boxii") + 
    scale_color_luke_c(option="A", ncolours = 6)
  gridExtra::grid.arrange(p1, p1+theme_luke())
}

# more gradients
if(1) {
  
  d <- data.frame( expand.grid(x=1:50, y=1:50)  ) |> mutate(z = ((x-25)^2+(y-25)^2) |> sqrt())
  p1 <- d |> 
    ggplot(aes(x, y=y, fill = z)) + geom_raster()  + ggtitle("raster") + 
    scale_fill_luke_c(option="A", direction=-1, alpha = .75)+ coord_fixed()
  p1 + theme_luke()
}