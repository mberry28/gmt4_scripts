
#!/bin/bash
#
#plot for cross-correlation result
#
OUT="ResvEle.ps"
box=" -R-425/250/0/3250"
pro="-JX5i/5i"
#LABEL_OFFSET 0.03 TICK_LENGTH 0.075
gmtset MEASURE_UNIT inch

FLAGS='-K -X1.2'
psbasemap ${box} ${pro} ${FLAGS}  -Bf200a200:"Residual  Temperature(C)":/f500a500:"Elevation (m)":WeSn >$OUT	 
#
FLAGS=" -G220/220/220 -Ss0.04 -O -K"
awk '{print $1, $2}' re_data.txt > re_data.xy
psxy re_data.xy ${box} ${pro} ${FLAGS} >>$OUT
#
#overlay binned averages
FLAGS=" -G0/0/255 -Sc0.15 -Ey  -O -K"
awk '{print $1, $2, $3}' re_bin.txt > re_bin.xyz
psxy re_bin.xyz ${box} ${pro} ${FLAGS} >>$OUT

#flag="-G0/0/255 -Sc0.04i  -O -K"
#rm temp.dat
#awk  '{print 2*3.14/$1/1000,$2}' KMtony > temp.dat 
#psxy  temp.dat ${box} ${pro} ${flag}  >>$OUT
#slegend legend -R980/1000/0/1  
