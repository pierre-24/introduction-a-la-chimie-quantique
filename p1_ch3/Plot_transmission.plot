set term pngcairo enhanced dashed font 'Helvetica,16' size 800, 500 dashed
set output "Transmission.png"

set style line 1 pt 7 ps .75 lw 2
set style line 2 pt 7 ps .75 lw 2 dashtype 2

set key at screen .8,.4 right bottom

set xlabel "{/Symbol e} = E/V_{0}"
set ylabel "T"

set xrange [0:2.5]
set yrange [0:1.1]

k(m,x)=sqrt(2*m*(1-x))
T(a,m,x)=(1+(exp(k(m,x)*a)-exp(-k(m,x)*a))**2/(16*x*(1-x)))**(-1)

set samples 1000
plot T(5,1,x) t 'a=5' ls 1 lc rgb "red" ,\
     T(2,1,x) t 'a=2' ls 1 lc rgb "blue"  ,\
     T(1,1,x) t 'a=1' ls 1 lc rgb "green"
