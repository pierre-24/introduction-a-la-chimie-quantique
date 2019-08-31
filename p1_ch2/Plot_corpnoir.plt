set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 500 dashed
set output "Corp_noir.png"

set xrange [0:2000]
set yrange [0:1.2]
maxY=2e5

set ylabel "{/Symbol r}({/Symbol l},T) (unités arbitraires) "
set xlabel "Longueur d'onde ({/Symbol l}, nm)"

set style line 1 lt 1 lw 2 pt 1 ps 1.0
set style line 2 lt 7 lw 2 pt 1 ps 1.0 dashtype 2
set style line 3 lt 1 lw .5 pt 1 ps 1.0 lc rgb "grey"

kB=1.038e-23
h=6.626e-34
c=2.99e8

rgb(r,g,b) = (255*r*256**2 + 255*g*256 + 255*b) 

P(x,T)=8*pi*h*c/(x**5)*1/(exp(h*c/(kB*T*x))-1)

# plot :

set object 2 rect from 400,0 to 800,1.2 lw 1 fc rgb '#ffffaa'

plot for [i=1:5] P(x*1e-9,3000+i*500)/maxY w l ls 1 lc rgb rgb((5.-i)/5.,0,i/5.) title 'T='.(3000+i*500).' K'





