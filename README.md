# lukeR

R package for Luke-related database-wrappers, color-themes and templates.

To install, first install the `remotes` package, and then run inside R one of

```r
remotes::install_github("antiphon/lukeR")
# or with some examples
remotes::install_github("antiphon/lukeR", build_vignettes = TRUE)
```



## Planned features

### Themes

* [ ] ggplot (partly done)
    * [ ] scale_*_gradient
    * [ ] scale_*_continous
    * [ ] scale_*_discrete
    * [ ] facet_grid wrap
* [ ] R-markdown document css

Maybe

* [ ] Shiny app css
* [ ] flexdashboard css
* [ ] raster, rasterViz, spplot, tmap, leaflet, etc?


### Graphical elements

* [ ] accessibility
* Color palettes: 
   * [x] main
   * [ ] fades
   * [ ] sets for plots 
* [x] typeface names
* [x] Luke logo with adjustable colors
    * background
    * title
    * bubble
    * subtitle
    * output svg or bitmap

### Templates

* [ ] LaTeX Beamer presentation
* [ ] LaTeX report-template

Office-suite templates are already on Valtti-machines. 

### Guides

* [ ] Official graphical guide
* [ ] Rmd example of plots

