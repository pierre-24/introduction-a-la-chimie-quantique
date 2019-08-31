set table "p2.pgf-plot.table"; set format "%.5f"
set samples 25; plot [x=-2:2] (2-abs(x))*cos(4*x)**2
