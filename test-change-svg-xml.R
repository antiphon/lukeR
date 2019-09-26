# logo as xml:
library(XML)

# New color
newcol <- "#f00000"

# This:
part <- "text_en"

# File
fi <- paste0("inst/extdata/", part, ".svg")
#fi <- "inst/extdata/bubble.svg"
a <- xmlTreeParse(fi, useInternalNodes = TRUE)
pl <- getNodeSet(a, "//svg:path")

for(p in pl){
  att <- xmlAttrs(p)
  if('style' %in% names(att)) {
    newstyle <- gsub("fill:#.{6};", paste0("fill:", bgcol, ";"), att[['style']] )
    xmlAttrs(p) <- c(style = newstyle)
  }
}
fo <- paste0(part, "_red.svg")
saveXML(a, fo, prefix = "")

### Background:
bgcol <- "#00f000"
fi <- paste0("inst/extdata/backplate.svg")
a <- xmlTreeParse(fi, useInternalNodes = TRUE)
p <- getNodeSet(a, "//svg:rect")[[1]]
newstyle <- gsub("fill:#.{6};", paste0("fill:", bgcol, ";"), att[['style']] )
xmlAttrs(p) <- c(style = newstyle)
fo <- "backplate_red.svg"
saveXML(a, fo, prefix = "")


# Compile
set <- c("bubble", "LUKE", "text_en")
new <- xmlTreeParse("backplate_red.svg", useInternalNodes = TRUE)
canvas <- xmlChildren(new)$svg
# add these
for(s in set){
  bit <- xmlTreeParse(paste0(s, "_red.svg"), useInternalNodes = TRUE)
  l <- getNodeSet(bit, "//svg:g")
  ok <- sapply(l, function(i) 'style' %in% names( xmlAttrs(i)) )
  addChildren(canvas, l[ok])
}
saveXML(new, "test.svg", prefix = "")
