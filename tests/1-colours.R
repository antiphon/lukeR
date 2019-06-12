# Basic colours

devtools::load_all()

cl <- luke_colours()

print(cl)


n <- length(cl)

plot(1:n, rep(1, n), pch=20, cex=2, col=cl)
