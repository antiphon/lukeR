#' GG Discrete Scale
#' 
#' @param ... passed on to luke_pal
#' @param aesthetic defaults to "colour"
#' @export
scale_color_luke_d <- function (..., aesthetics = "colour") {
  discrete_scale(aesthetics, 
                 "luke", 
                 luke_pal(...))
}

#' GG default scale
#' Same as discrete scale.
#'
#' @export
scale_color_luke <- function(...) scale_color_luke_d(...)



#' GG Fill Scale
#' 
#' @export
scale_fill_luke_d <- function(...) {
  scale_color_luke_d(..., aesthetics = "fill")
}

#' GG default fill Scale
#' 
#' @export
scale_fill_luke <- function(...) {
  scale_fill_luke_d(...)
}


#' GG Fill Scale
#' 
#' @export
scale_fill_luke_c <- function(...) {
  scale_color_luke_c(..., aesthetics = "fill")
}

#' GG Continuous Scale
#' 
#' @param ... passed on to luke_pal
#' 
#' @details luke_pal is used for creating 6 colors for interpolation.
#' @export
scale_color_luke_c <- function(..., 
                               values = NULL, space = "Lab", 
                               na.value = "grey50", 
                               guide = "colourbar", 
                               aesthetics = "colour", ncolours = 8) {
  continuous_scale(aesthetics, 
                   "luke_c", 
                   scales::gradient_n_pal( luke_pal(...)(ncolours), values, space), 
                   na.value = na.value, 
                   guide = guide
                   )
}


#' GG Theme
#' 
#' @export
theme_luke <- function (family = "sans") { 
  theme_bw(base_size=12, base_family=family) %+replace% 
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="white", colour=NA), 
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}


