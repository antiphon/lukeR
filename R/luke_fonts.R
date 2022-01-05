#' Luke Fonts
#'
#' Return font typeface name for text.
#'
#' @param approx Return a free approximation instead of the official commercial font?
#' @param ... ignored
#' 
#' @details The official font family is "Accura", which is a commercial font published by MyFonts.com. A close approximation is Arial. 
#' On websites, Titllium Web Semibold is used for titles and Ek Mukta Regular for other. From Google Fonts.
#' 
#' @return The string "Accura" or "Arial". 
#' @export

luke_fonts <- function(approx = TRUE, ...) {
  out <- if(approx) "Arial" else "Accura"
  # done
  out
}
