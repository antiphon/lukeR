#' Templates for Presentations
#' 
#' Create a presentation template in a desired location.
#' 
#' @param path path to location where to create template. Default is current working directory.
#' @param type Powerpoint ('pp') (DEPRECATED) or LaTeX Beamer ('beamer')
#' @param lang 'fi', 'en' or 'se'
#' @param ask Prompt if new directory is to be created. If FALSE just create it.
#' @details 
#' Copies the bare minimum files for a presentation in Luke colours into 'path'. The Beamer 
#' presentation is an imitation of the official Powerpoint template.
#' 
#' Powerpoint templates are no longer provided as they are loaded on Valtti-machines by default.
#' 
#' @export
luke_presentation <- function(path =".", type = "beamer", lang = "en", ask = TRUE) {
  if(!lang %in% c("fi", "en", "se")) stop("'lang' should be one of 'en', 'fi', 'se'.")
  if(! dir.exists(path) ) {
    a <- if(ask) readline("Path does not exist, create it? [y/n]") else "y"
    if(tolower(a) == "y") dir.create(path)
      else {message("Canceled.");return()}
  }
  
  
  
  type <- c("pp","beamer")[pmatch(type, c("pp", "beamer"))]
  #
  if(type == "pp") {
    stop("Powerpoint no longer supported.")
    files_in <- paste0("Luke_PP_", toupper(lang), "_basic_4_3.potx")
    files_out <- files_in
  }
  else{
    files_in <- c(paste0("luke-beamer-template-", tolower(lang), ".tex"), "beamerthemeluke.sty", 
                  "bubble_white.png")
    files_out <- c("luke-beamer-template.tex", "beamerthemeluke.sty", "bubble_white.png")
  }
  # copy files
  #browser()
  fin <- system.file( paste0("/extdata/templates/", files_in), package= "lukeR")
  fout <- paste0(path, "/", files_out)
  file.copy(fin, fout)
  
  # create logos
  if(type != "pp") {
    luke_logo(bg_opacity = 0, file = paste0(path, "/logo.png"), width = 600, lang=lang)
    luke_logo(bg_opacity = 0, file = paste0(path, "/logo.png"), width = 600, lang=lang)
    w <- "#ffffff"
    luke_logo(bg = luke_colours()[1], bubble=w, text=w, luke=w, file = paste0(path,"/logo_orange.png"), width = 600, lang=lang)
  }
  message(paste0("Presentation template created in ", path))
}