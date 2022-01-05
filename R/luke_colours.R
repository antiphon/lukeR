#' Luke Colours
#' 
#' Return the official colour palette
#' 
#' @param format Return the colors in format: web, rgb, or hsv
#' @param naming Naming of the colours: informal (unofficial) or PMS (for printing)
#' @param program Specific program, initials in Finnish. Returns only the bubble-color, which is light blue for general use.
#' @param ... ignored
#' 
#' @export

luke_colours <- function(format = "web", naming = "informal", program = NULL, ...) {
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
  if(!is.null(program)) {
    out <- web
    z <- list("SB" = out[4], "IR" = out[5], "PVB" = out[6], "KLY"=out[7])
    web <- z[[ pmatch(tolower(program), tolower(names(z))) ]]
  }
  
  # default: web
  out <- if(format != "web") col2rgb(web) else web
  if(format == "hsv") out <- rgb2hsv(out)
  
  # done
  
  out
}



# Below are palette functions # 

# RGB map that follows Luke's graphical guide
luke.color.map <- {
  cc <- t( luke_colours(format = "rgb") )[c(4, 2, 1), ]
  cc <- cc/255
  vec <- rgb(cc[,1], cc[,2], cc[,3])
  v <- col2rgb( colorRampPalette( vec , space = "Lab")(256) )
  e <- data.frame(t(v))/255
  names(e) <- c("R","G","B")
  e
}

luke.color.map.all <- {
  cc <- t( luke_colours(format = "rgb") )
  cc <- cc/255
  vec <- rgb(cc[,1], cc[,2], cc[,3])
  v <- col2rgb( colorRampPalette( vec , space = "Lab")(256) )
  e <- data.frame(t(v))/255
  names(e) <- c("R","G","B")
  e
}


#' Luke Color Palette Function
#' 
#' Gives a required amount of colors near the official Luke-palette
#' 
#' @param alpha alpha
#' @param begin start level. 
#' @param end end. 
#' @param direction 1 or -1
#' @param option A=darkblue blue orange B=all
#' @param iwh I want Hue! Make the neighbouring colors more distinct
#' 
#' @importFrom grDevices rgb colorRamp
#' @export
luke_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, 
                     option = "A", 
                     iwh = FALSE) {
  function(n) {
    if (begin < 0 | begin > 1 | end < 0 | end > 1) {
      stop("begin and end must be in [0,1]")
    }
    if (abs(direction) != 1) {
      stop("direction must be 1 or -1")
    }
    if (direction == -1) {
      tmp <- begin
      begin <- end
      end <- tmp
    }
    #browser()
    map <- if(option=="A") luke.color.map else luke.color.map.all
    map_cols <- grDevices::rgb(map$R, map$G, map$B)
    fn_cols  <- grDevices::colorRamp(map_cols, 
                                     space = "Lab", 
                                     interpolate = "spline")
    cols <- fn_cols( seq(begin, end, length.out = n) )/255
    #
    # reorder to maximize contrast?
    if(iwh & n > 1) {
      lab <- convertColor(cols, from = "sRGB", to = "Lab", to.ref.white = "D65")
      #return(cols)
      deltaE <- as.matrix( dist(lab) )
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
      cols <- cols[o1,, drop=FALSE]
    }
    #
    #
    out <- grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
    out
  }
}
