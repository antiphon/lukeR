#' Luke Logo in Colors
#' 
#' Luke's logo consists of background, the text bubble, "Luke", and full name depending on language. Save it as an image in freely chosen colors.
#' 
#' @param bg color for background
#' @param bubble color for bubble
#' @param luke color for "LUKE"
#' @param text color for the text under "LUKE"
#' @param bg_opacity opacity of bg, 0-1.
#' @param lang language for the text, "fi", "en" eller "se".
#' @param file optional file. Default is "luke_logo.png" in the working directory. See details.
#' @param ... passed on to rsvg_*, mainly 'width' and 'height' arguments for png's.
#' @details give all colors in web-format, eg. "#ffffff" for white. See luke_colors().
#' 
#' 'file' should end in desired format, e.g. "my_luke_logo.png" to have a png-image as output. 
#' Supported formats are 'pdf', 'svg' and 'png'.  
#' @import XML rsvg
#' @export


luke_logo <- function(bg = "#ffffff",
                      bubble = "#00b5e2",
                      luke = "#ff8200",
                      text = "#3d3b3c",
                      bg_opacity = 1,
                      lang = "fi",
                      file = "luke_logo.png", 
                      ...) {
  # Parse desired output
  outbits <- strsplit(file, "[.]")[[1]]
  if(!outbits[[length(outbits)]] %in% c("svg", "pdf", "png")) stop("'file' should end in .svg, .pdf or .png.")
  #
  # helper
  getf <- function(v) system.file( paste0("/extdata/", v, ".svg"), package= "lukeR")
  # start building
  new <- xmlTreeParse(getf("backplate"), useInternalNodes = TRUE)
  canvas <- xmlChildren(new)$svg
  # change canvas color
  p <- getNodeSet(new, "//svg:rect")[[1]]
  att <- xmlAttrs(p)
  newstyle <- att[['style']] 
  newstyle <- gsub("fill:#.{6};" , paste0("fill:", bg, ";"), newstyle)
  newstyle <- gsub("opacity:[0-9.]*;", paste0("opacity:", bg_opacity, ";"), newstyle)
  xmlAttrs(p) <- c(style = newstyle)
  #browser()
  # parts
  fset <- list(bubble="bubble", luke = "luke", text=paste0("text_", lang))
  cols <- list(bubble = bubble,
               luke = luke,
               text = text)
  
  # change color of parts and add to canvas
  for(s in names(fset)){
    if(!is.null(cols[[s]])){
      bit <- xmlTreeParse(getf(fset[[s]]), useInternalNodes = TRUE)
      # Change color of each found path:
      pl <- getNodeSet(bit, "//svg:path")
      for(p in pl){
        att <- xmlAttrs(p)
        if('style' %in% names(att)) {
          newstyle <- gsub("fill:#.{6};", paste0("fill:", cols[[s]], ";"), att[['style']] )
          xmlAttrs(p) <- c(style = newstyle)
        }
      }
      # Add
      l <- getNodeSet(bit, "//svg:g")
      ok <- sapply(l, function(i) 'style' %in% names( xmlAttrs(i)) )
      addChildren(canvas, l[ok])
    }
  }
  
  # output
  format <- outbits[[length(outbits)]]
  if(format == "svg") saveXML(new, file, prefix = "")
  else # png or pdf
  {
    tf <- tempfile()
    tf <- saveXML(new, tf, prefix = "")
    fff <- get(paste0("rsvg_", format))
    fff(tf, file = file, ...)
  }
  file
}
