# Create the luke colour map for sliding colours
#ramp:
cc <- t( luke_colours(format = "rgb") )
cc <- rbind( cc[c(4, 2, 1), ], 
             c(255,220,130)) /255
vec <- rgb(cc[,1],cc[,2],cc[,3])
v <- col2rgb( colorRampPalette( vec )(256) )
luke.color.map <- data.frame(t(v))/255
names(luke.color.map) <- c("R","G","B")

#luke.co

# check mapping
begin <- 0; end<-1;n<-256; alpha <- 1
mapig <- function(map){
map_cols <- grDevices::rgb(map$R, map$G, map$B)
fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", 
                                interpolate = "spline")
cols <- fn_cols(seq(begin, end, length.out = n))/255
grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}
z <- mapig(luke.color.map)
z_vir <- mapig(viridisLite::viridis.map[viridisLite::viridis.map$opt =="D",])




plot(seq_along(z), pch=19, col = z)

points(seq_along(z)-2, seq_along(z)+7, pch = 19, col = z_vir)