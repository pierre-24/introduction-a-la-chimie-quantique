set term pngcairo enhanced dashed font 'Helvetica,14' size 800, 800 dashed
set output "2dpol.png"

set multiplot layout 3,2

unset border

set grid polar 45
set grid ls 0 lt 1 lc 0 lw 0.3
set polar
set yrange [-1.75:1.75]
unset xtics
unset ytics
unset key
set ttics 45

set rrange [0:1.6]
unset rlabel

set size square
set trange [0:2*pi]

set lmargin 0
set tmargin 0

set style line 1 lw 1. lt 1
set style line 2 lw 2. lt 1

i = {0.0,1.0}
P(u,n)=(2*pi)**(-.5)*exp(i*n*u)
E(n)=n**2

set sample 200

do for [j=0:2] {
set tmargin 1
set rrange [0:1.6]
set rtics .5
set label 1 "m_{l} = ".j at graph 1.25,.5
plot 1 lc rgb "black", 1+real(P(t,j))**1 lc rgb "blue" lw 2, 1+imag(P(t,j))**1 lc rgb "red" lw 2
unset label 1
set rrange [0:.2]
set rtics .1
plot 1 lc rgb "black", real(P(t,j))**2 lc rgb "blue" lw 2, imag(P(t,j))**2 lc rgb "red" lw 2
}
