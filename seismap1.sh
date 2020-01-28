
#!/bin/sh
#
#make a plot of earthquakes in US over topograph data	
#
PS_OUT="OKEQ10wells.ps"
#select range
RANGE="-R-103.4/-94.4/33.6/38"
PROJ="-JM6"
ANOT="-B5eSWn"
gmtset PAPER_MEDIA letter+ COLOR_BACKGROUND 139/218/170 COLOR_NAN 215/215/255 MEASURE_UNIT inch
gmtset PLOT_DEGREE_FORMAT D
rm $PS_OUT
#
#makes color file

FLAGS="-Cseis -I -T2/4/.1 -Z"
makecpt ${FLAGS} > quakecolor.cpt
#
#lat long file to gridfile
FLAGS="-F -I30c -V"
xyz2grd US_topo.llz -Gtopo.grd ${RANGE} ${FLAGS}
#
FLAGS="-A90 -Ne0.6 -V"
grdgradient topo.grd -Grrlf.grd ${FLAGS}
#
FLAGS="-P -V -Y1.5 -K"
psbasemap ${RANGE} ${PROJ} "${ANOT}" ${FLAGS} > $PS_OUT
#
FLAGS="-Ctopo.cpt -Irrlf.grd -V -O -K"
grdimage topo.grd ${RANGE} ${PROJ} ${FLAGS} >> $PS_OUT
#
FLAGS="-Dh -N1/2 -N2/2 -V -O -K"
pscoast ${RANGE} ${PROJ} ${FLAGS} >> $PS_OUT
#
#Plot points EQ data
awk '{print $4, $3, $6}' 2010-2014eqOKKS.txt > equakes.xyz
FLAGS="-Sc.2 -Cquakecolor.cpt -O -W -K"
psxy equakes.xyz   ${RANGE}  ${PROJ} ${FLAGS} >> $PS_OUT
#
#plot Wells
awk '{print $2, $1}' OKinjectxy.txt > wells.xy
FLAGS="-Ss0.05 -Gblack -O -W -K"
psxy wells.xy ${RANGE}  ${PROJ} ${FLAGS} >> $PS_OUT
#
#Scalebar and text at bottom
gmtset ANOT_FONT_SIZE 14
gmtset HEADER_FONT_SIZE 16
FLAGS="-Cquakecolor.cpt -D3/1.4/6/0.25h -Y-1.8 -O -K"
psscale ${FLAGS} -B.5:"Earthquake Magnitude": >> $PS_OUT
#
#
#FLAGS="-O -K"
#psxy ${RANGE} ${PROJ} ${FLAGS} < /dev/null >> $PS_OUT
#rm topo.grd rlf.grd
#
# Done
#
