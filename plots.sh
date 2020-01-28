#!/bin/sh
# Script to make plots with
#
#Current Plot: Res VS Elevation
#
PS_OUT="RE_plot_-I0.5.ps"
#x axis, y axis
RAN="-R/-500/300/0/3000"
PRO="-JX6/6"
ANO="-Bf1a100:Residual Temperature (C) :/a500f1:Elevation (M):eWSn"
gmtset ANNOT_FONT_SIZE 16 LABEL_FONT_SIZE 18 PAPER_MEDIA letter+ ANNOT_OFFSET_PRIMARY 0.02 LABEL_OFFSET 0.03 TICK_LENGTH 0.075
gmtset MEASURE_UNIT inch	
rm $PS_OUT
#
FLAGS="-P -K"
psbasemap ${RAN} ${PRO} "${ANO}" ${FLAGS} > $PS_OUT
#
#list x then y values
FLAGS="-: -Sc.05 -G200 -O -K"
awk '{print $2, $1}' re_data.txt > re_data.xy
psxy re_data.xy ${RAN} ${PRO} ${FLAGS} >> $PS_OUT
#
FLAGS="-: -Ss.25 -Gred -O -K"
awk '{print $2, $1}' re_bin.txt > re_bin.xyz
psxy re_bin.xyz ${RAN} ${PRO} ${FLAGS} >> $PS_OUT
#
FLAGS="-O"
psxy ${RAN} ${PRO} ${FLAGS} < /dev/null >> $PS_OUT
#
rm .gmt*
#
# Done
#
