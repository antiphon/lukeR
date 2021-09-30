# Create example figures for latex-templates 

library(lukeR)


theme_luke <- function (...) { 
  theme_bw(base_size=12, base_family="Selawk") %+replace% 
    theme(
      panel.background  = element_blank(),
      #plot.background = element_rect(fill="white", colour=NA), 
      #legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA),
      ...
    )
}


library(ggplot2)

x <- data.frame( x = rep(1:12, each = 3), y = sin( (1:12 + 1:3) / 10 ) + rnorm(3*12, 0, .1), 
                 Series =  paste("Series", 1:3) )



p <- x |> ggplot(aes(x, y, col = Series)) + 
  geom_point( size = 2) +
  theme_bw() + theme(legend.pos = "bottom") +
  scale_color_luke_d(end = 1) +
  labs(col = "") +
  geom_line()

pdf(file = "fig_ex1.pdf", width = 7, height=3)
print(p)
dev.off()
