#' GG Discrete Scale
#' 
#' @export
scale_color_luke_d <- function (..., alpha = 1, begin = .3, end = .7, direction = 1, 
                                option = "A", aesthetics = "colour", iwh = FALSE) {
  discrete_scale(aesthetics, "luke", luke_pal(alpha, begin, end, direction, option, iwh), ...)
}

# 
# 
# scale_color_luke_d <- function (..., alpha = 1, begin = 0.25, end = .78, direction = 1, 
#                                 aesthetics = "colour") { 
#   discrete_scale(aesthetics, "luke_d", luke_pal(alpha, begin, end, direction), ...)
# }


#' GG Fill Scale
#' 
#' @export
scale_fill_luke_d <- function(...) {
  scale_color_luke_d(..., aesthetics = "fill")
}

#' GG Fill Scale
#' 
#' @export
scale_fill_luke_c <- function(...) {
  scale_color_luke_c(..., aesthetics = "fill")
}




#' GG Continuous Scale
#' 
#' @export
scale_color_luke_c <- function(..., alpha = 1, begin = 0, end = 1, direction = 1, 
                               option = "A", values = NULL, space = "Lab", na.value = "grey50", 
                               guide = "colourbar", aesthetics = "colour", iwh = FALSE) {
  continuous_scale(aesthetics, "luke_c", 
                   scales::gradient_n_pal(luke_pal(alpha, begin, end, direction, iwh)(6), values, space), na.value = na.value, 
                   guide = guide, ...)
}


#' GG Theme
#' 
#' @export
theme_luke <- function () { 
  theme_bw(base_size=12, base_family="Arial") %+replace% 
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="white", colour=NA), 
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}


