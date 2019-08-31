set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 500 dashed
set output "Step.png"

set style line 1 pt 7 ps .75 lw 2
set style line 2 pt 7 ps .75 lw 2 dashtype 2

set key at screen 0.2,.9 left top

set xlabel "{/Symbol e} = E/V_{0}"
set ylabel "T"
set xrange [0:3]

V0=1

k1(m,x) = sqrt(2*m*x/V0)
k2(m,x) = sqrt(2*m*(x-1)/V0)

Tp(m,x)=(4*k1(m,x)*k2(m,x))/ (k1(m,x)+k2(m,x))**2

set key at screen 0.7,.9 left top

plot Tp(1,x) t 'T' ls 1 lc rgb "red",\
     [0:1] 0 ls 1 lc rgb "red" notitle,\
     1-Tp(1,x) t 'R' ls 1 lc rgb "blue",\
     [0:1] 1 ls 1 lc rgb "blue" notitle
