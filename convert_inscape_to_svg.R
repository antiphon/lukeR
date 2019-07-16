# This is crappy, uses a pixel image

library(rsvg)
library(grImport2)
fl <- c("backplate", "bubble", "LUKE", "text_se")
names(fl) <- fl

pics <- lapply(fl, function(f){ 
  rsvg_svg(paste0("inst/extdata/", f, ".svg"), of <- paste0(tempdir(), "/", f)  )
  grImport2::readPicture(of)
})

# Replace backplate with a square
b <- pics$backplate@defs@content$image412
gpar(x=b@x, y=b@y, bbox = b@bbox)
# Replace colors:
newcols <- list(backplate = list(fill = "#ffffff",
                                 col = "#ffffff"))
for(i in names(newcols)) pics[[i]]@content[[1]]@content[[1]]


lapply(pics, grid.picture)


