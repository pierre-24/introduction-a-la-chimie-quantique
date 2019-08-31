set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 800 dashed
set output "Boite.png"

set multiplot layout 1,2

L=1

set xrange [0:L]
set yrange [0:28]

set xlabel "x/L"
set ylabel "E_{n} + {/Symbol Y}_{n}(x)"

unset ytics

set style line 1 lt 1 lw 2 pt 1 ps 1.0
set style line 2 lt 7 lw 2 pt 1 ps 1.0 dashtype 2
set style line 3 lt 1 lw .5 pt 1 ps 1.0 lc rgb "grey"

rgb(r,g,b) = (255*r*256**2 + 255*g*256 + 255*b)
P(x,n)=sqrt(2./L)*sin(n*pi*x/L)
E(n)=n**2/(L**2)

# plot :

do for [i=1:5] {
    set label "n=".i at 1.02,E(i)
    set arrow from 0,E(i) to 1,E(i) nohead
}

set rmargin 5

set samples 1000
plot for [i=1:5] E(i)+P(x,i) w l ls 1 lc rgb 'red' notitle


set ylabel "E_{n} + |{/Symbol Y}_{n}(x)|²"
plot for [i=1:5] E(i)+(P(x,i))**2 w l ls 1 lc rgb 'blue' notitle





