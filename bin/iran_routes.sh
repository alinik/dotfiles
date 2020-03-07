#!/bin/bash -x
CSV_PATH=~/bin/ir.csv
CMD="ip r"
[ `id -u` -ne 0 ] && CMD="sudo $CMD"
OUTPUT="$HOME/bin/route_dump"
CMD="echo $CMD"            
function make_routes(){
    ACTION=$1
    VIA='via 192.168.1.1'
   [ ! -f ~/bin/ir.csv ] && wget https://www.nirsoft.net/countryip/ir.csv -O $CSV_PATH
    for route in ` awk -F, '/,/ {print $1"/"32-(log($3)/log(2)) }' $CSV_PATH `
        do 
        $CMD $ACTION $route $VIA 
    done
    #Customs
    $CMD $ACTION 5.144.134.0/24 $VIA # cdn.p30download.com
    $CMD $ACTION 91.189.89.32 $VIA # mirrors.ubuntu.com
    $CMD $ACTION 185.223.44.7 $VIA # ib.bpi.ir
    $CMD $ACTION 185.55.226.40 $VIA # dl.royalmind.ir
    $CMD $ACTION 185.142.156.0/24 $VIA # ir.archive.ubuntu.com
    $CMD $ACTION 171.22.26.0/24 $VIA # motamem.org
    $CMD $ACTION 185.143.232.0/24 $VIA # ikco.ir
    $CMD $ACTION 31.24.232.0/21 $VIA # tehran.ir
    $CMD $ACTION 88.135.37.0/24 $VIA # faradars.org
    $CMD $ACTION 193.34.244.0/24 $VIA #Mofid CDIR
    $CMD $ACTION 185.143.234.0/24 $VIA #arvan
    $CMD $ACTION 185.143.233.0/24 $VIA #arvan
}
make_routes a > ${OUTPUT}_a.sh
make_routes d > ${OUTPUT}_r.sh
chmod a+x ${OUTPUT}_?.sh

