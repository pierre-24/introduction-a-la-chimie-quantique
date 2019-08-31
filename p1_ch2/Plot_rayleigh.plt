set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 500 dashed
set output "Rayleigh.png"

set xrange [0:5000]
set yrange [0:1]
maxY=2e5

set ylabel "{/Symbol r}({/Symbol l},T) (unités arbitraires) "
set xlabel "Longueur d'onde ({/Symbol l}, nm)"

set style line 1 lt 1 lw 2 pt 1 ps 1.0
set style line 2 lt 7 lw 2 pt 1 ps 1.0 dashtype 2
set style line 3 lt 1 lw .5 pt 1 ps 1.0 lc rgb "grey"

kB=1.038e-23
h=6.626e-34
c=2.99e8

R(x,T)=8*pi*kB*T/(x**4)
P(x,T)=8*pi*h*c/(x**5)*1/(exp(h*c/(kB*T*x))-1)

# plot :



set object 2 rect from 400,0 to 800,1 lw 1 fc rgb '#ffffaa'

plot R(x*1e-9,5000)/maxY w l ls 2 lc rgb "red" title "Rayleigh-Jeans",\
     P(x*1e-9,5000)/maxY w l ls 1 lc rgb "blue" title "Planck"

    




