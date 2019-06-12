#' Luke Colours
#' 
#' Return the official colour palette
#' 
#' @param format Return the colors in format: web, rgb, or hsv
#' @param naming Naming of the colours: informal (unofficial) or PMS (for printing)
#' @param ... ignored
#' 
#' @export

luke_colours <- function(format = "web", naming = "informal", ...) {
  web <- c(orange     = "#ff8200",
           blue       = "#00b5e2",
           darkgray   = "#54585a",
           darkblue   = "#0033a0",
           fuchsia    = "#e13c98",
           green      = "#78be20",
           violet     = "#7f3f98")
  # PMS names for printing
  if(naming == "PMS") {
    pmsnames <- c("PMS 151", "PMS 306", "PMS 425", "PMS 286",
                  "PMS Rhodamine Red", "PMS 368", "PMS 7668")
    names(web) <- pmsnames
  }
  # default: web
  out <- if(format != "web") col2rgb(web) else web
  if(format == "hsv") out <- rgb2hsv(out)
  # done
  out
}


