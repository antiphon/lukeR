# Basic colours

devtools::load_all()



if(0){
cl <- luke_colours()

print(cl)
n <- length(cl)

plot(1:n, rep(1, n), pch=20, cex=2, col=cl)
luke_colours(program = "SB")
}


# IWH!

if(0){ # broken with proper return
par(mfrow = c(2,2))

for( iwh in 0:1) {
plot(NA, xlim = c(0, 11), ylim = c(0, 10), asp = 1)
for(n in 1:10) {
  cl <- luke_pal(iwh = iwh, option = OPT <- "A")(n)
  if(iwh & n > 1){
    # Use deltaEab
    # rgb -> CIELAB
    lab <- convertColor(cl, from = "sRGB", to = "Lab", to.ref.white = "D65")
    # distances, simple CIE76
    deltaE <- dist(lab) |> as.matrix()
    # vector of indices to get relevant pairwise distances 
    ij <- cbind(1:(n-1), 2:n)
    # target function for given order
    lf <- function(o) {
      mean(deltaE[o,o,drop=FALSE][ij]^2)
    }
    # so then we optimise
    o0 <- 1:n; l0 <- lf(o0)
    lh <- rep(l0, 1000)
    acc <- 0
    for(i in 1:1000) { 
      o1 <- sample(n) 
      l1 <- lf(o1)
      a <-  exp(-(l1-l0)/1000)
      if( runif(1) < a) {
        o0 <- o1
        l0 <- l1
        acc <- acc+1
      }
      lh[i] <- l0 
    }
    print(acc)
    # done
    o <- cl[o1,, drop=FALSE]
    cl <- rgb(o[,1], o[,2], o[,3])
  }
  points(1:n, rep(n, n), col = cl, cex = 3, pch = 15)
}
}
  
  # towards non stochastic
  plot(NA, xlim = c(0, 11), ylim = c(0, 10), asp = 1)
  for(n in 1:10) {
    cl <- luke_pal(iwh = 1, option = OPT)(n)
    if(iwh & n > 1){
      # Use deltaEab
      # rgb -> CIELAB
      lab <- convertColor(cl, from = "sRGB", to = "Lab", to.ref.white = "D65")
      # distances, simple CIE76
      deltaE <- dist(lab) |> as.matrix()
      # go stepwise maximum difference
      o1 <- 1
      last <- 1
      left <- 2:n
      while(length(left)){
        doj <- deltaE[last, left]
        j <- left[ji <- which.max(doj)]
        o1 <- c(o1, j)
        left <- left[-ji]
        last <- j
      }
      o <- cl[o1,, drop=FALSE]
      cl <- rgb(o[,1], o[,2], o[,3])
    }
    points(1:n, rep(n, n), col = cl, cex = 3, pch = 15)
  }
  
  
}# iwh

## try iwh on ggplot
if(0) {
  k <- 6
  df <- data.frame(x = 1:k   |> factor(), y = runif(k * 10), m = rep(1:k, each=10) |>factor())
  
  library(ggplot2)
  library(dplyr)
  df <- df |> group_by(x) |> mutate(y = y/sum(y))
  df |> ggplot() + geom_col(aes(x, y, fill = m))  +
    scale_fill_luke_d(iwh=TRUE, option="B")
}
