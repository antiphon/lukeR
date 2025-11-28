# Font

devtools::load_all()

plot(NA, xlim = c(0,1), ylim=0:1, asp = 1)

extrafont::loadfonts("win")

text(0.5, 0, "LUONNONVARAKESKUS", family = luke_fonts())
