#' Luke Fonts
#'
#' Return font info on the luke's fonts.
#'
#' @param approx Return a free approximation instead of the official commercial font?
#' @param ... ignored
#'
#' @details The official font family is "Accura", which is a commercial font published by MyFonts.com. A close approximation
#'
#' @export

luke_fonts <- function(approx = TRUE, ...) {
  out <- if(approx) "Arial" else "Accura"

  # done
  out
}


