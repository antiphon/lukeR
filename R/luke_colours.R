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
  cc <- t( luke_colours(format = "rgb") )
  cc <- rbind( cc[c(4, 2, 1), ], 
               c(255,220,130)) /255
  vec <- rgb(cc[,1],cc[,2],cc[,3])
  v <- col2rgb( colorRampPalette( vec )(256) )
  e <- data.frame(t(v))/255
  names(e) <- c("R","G","B")
  e
}


#' Luke Color Palette Function
#' 
#' @export
luke_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, option = "D") {
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
    map <- luke.color.map
    map_cols <- grDevices::rgb(map$R, map$G, map$B)
    fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", 
                                    interpolate = "spline")
    cols <- fn_cols( seq(begin, end, length.out = n) )/255
    grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
  }
}
#' GG Discrete Scale
#' 
#' @export
scale_color_luke_d <- function (..., alpha = 1, begin = .3, end = .7, direction = 1, 
                              option = "D", aesthetics = "colour") {
  discrete_scale(aesthetics, "luke", luke_pal(alpha, begin, end, direction, option), ...)
}
#' GG Fill Scale
#' 
#' @export
scale_fill_luke <- function(...) scale_color_luke_d(..., aesthetics = "fill")


#' GG Continuous Scale
#' 
#' @export
scale_color_luke_c <- function(..., alpha = 1, begin = 0, end = 1, direction = 1, 
                               option = "D", values = NULL, space = "Lab", na.value = "grey50", 
                               guide = "colourbar", aesthetics = "colour") {
  continuous_scale(aesthetics, "luke_c", 
                   scales::gradient_n_pal(luke_pal(alpha, begin, end, direction)(6), values, space), na.value = na.value, 
                   guide = guide, ...)
}


#' GG Theme
#' 
#' @export
theme_luke <- function () { 
  theme_bw(base_size=12, base_family="Arial") %+replace% 
    theme(
      panel.background  = element_blank(),
      #plot.background = element_rect(fill="white", colour=NA), 
      #legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}

luke_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1) {
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
    map <- luke.color.map
    map_cols <- grDevices::rgb(map$R, map$G, map$B)
    fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", 
                                    interpolate = "spline")
    cols <- fn_cols(seq(begin, end, length.out = n))/255
    grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
  }
}


scale_color_luke_d <- function (..., alpha = 1, begin = 0.25, end = .78, direction = 1, 
                                aesthetics = "colour") { 
  discrete_scale(aesthetics, "luke_d", luke_pal(alpha, begin, end, direction), ...)
}

