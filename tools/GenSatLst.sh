#!/bin/bash

gawk 'BEGIN{FS="] "} {if ($0 ~ /[[:digit:]][0-9]\]/) { if ($2 ~ /\[Data/) {printf "%s] %s\n", $2,$3} else print $2 } else  print $0}' station_origin.lst | gawk 'BEGIN{FS="] "} {if ($0 ~ /[[:digit:]][0-9]\]/) print $2; else print $0}' | gawk -F"\t" '{$5=360+$5; printf " %s %.6f %.6f %s\n",$2,$5,$4,$1} ' > station.lst
