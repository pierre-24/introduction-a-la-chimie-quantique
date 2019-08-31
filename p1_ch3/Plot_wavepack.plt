set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 500 dashed
set output "Wavepacket.png"

set xrange [-10:10]
set yrange [-2.5:1.5]

set xlabel "Distance"

unset ytics

set style line 1 lt 1 lw 2 pt 1 ps 1.0
set style line 2 lt 7 lw 2 pt 1 ps 1.0 dashtype 2
set style line 3 lt 1 lw .5 pt 1 ps 1.0 lc rgb "grey"

rgb(r,g,b) = (255*r*256**2 + 255*g*256 + 255*b) 

P(x,k)=cos(x*k)
G(k,a,k0)=exp(-a**2*(k-k0)**2)
R(x,k) = G(k,.1,10)*P(x,k)
E(x) = R(x,1)

# plot :

set samples 1000
plot G(x,.5,0)*P(x,5.) w l ls 1 lc rgb 'red' title '{/Symbol Y}',\
    (G(x,.5,0)*P(x,5.))**2-2 w l ls 1 lc rgb 'blue'  title '|{/Symbol Y}|²'





