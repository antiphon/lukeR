# logo as xml:
library(XML)

fi <- "bubble.svg"
a <- XML::xmlTreeParse(fi, useInternalNodes = TRUE)
s <- xmlElementsByTagName(a, "svg")[[1]]
# Change color:
ctag <- "fill"
ncol <- xmlElementsByTagName(s, ctag)
xmlAttrs(d)

fo <- gsub(".svg", "2.svg", fi)

saveXML(b, fo, prefix = "")



