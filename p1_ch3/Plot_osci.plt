set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 800 dashed
set output "Osci.png"

set multiplot layout 1,2

L=5

set xrange [-L:L]
set yrange [0:8]

set xlabel "{/Symbol z}"
set ylabel "E_{n} + {/Symbol y}_{n}(x)"

unset ytics

set style line 1 lt 1 lw 2 pt 1 ps 1.0
set style line 2 lt 7 lw 2 pt 1 ps 1.0 dashtype 2
set style line 3 lt 1 lw .5 pt 1 ps 1.0 lc rgb "grey"

hbomega = 1.5

rgb(r,g,b) = (255*r*256**2 + 255*g*256 + 255*b)
G(x) = exp(-x**2/2)
C(n)=(2**n*n!*pi**(.5))**(-.5)
E(n)=hbomega*(n+.5)

P0(x) = (1)*C(0)*G(x)
P1(x) = (2*x)*C(1)*G(x)
P2(x) = (4*x**2-2)*C(2)*G(x)
P3(x) = (8*x**3-12*x)*C(3)*G(x)
P4(x) = (16*x**4-48*x**2+12)*C(4)*G(x)

# plot :

do for [i=0:4] {
    set label "n=".i at L+0.1,E(i)
    set arrow from -L,E(i) to L,E(i) nohead
}

set rmargin 5

set samples 1000
plot .5*hbomega*x**2 w l ls 1 lc rgb 'blue' notitle,\
     E(0)+P0(x) w l ls 1 lc rgb 'red' notitle, \
     E(1)+P1(x) w l ls 1 lc rgb 'red' notitle, \
     E(2)+P2(x) w l ls 1 lc rgb 'red' notitle, \
     E(3)+P3(x) w l ls 1 lc rgb 'red' notitle, \
     E(4)+P4(x) w l ls 1 lc rgb 'red' notitle


set ylabel "E_{n} + |{/Symbol y}_{n}(x)|²"
plot .5*hbomega*x**2 w l ls 1 lc rgb 'blue' notitle,\
     E(0)+(P0(x))**2 w l ls 1 lc rgb 'red' notitle, \
     E(1)+(P1(x))**2 w l ls 1 lc rgb 'red' notitle, \
     E(2)+(P2(x))**2 w l ls 1 lc rgb 'red' notitle, \
     E(3)+(P3(x))**2 w l ls 1 lc rgb 'red' notitle, \
     E(4)+(P4(x))**2 w l ls 1 lc rgb 'red' notitle





