#!/bin/bash
# Create BHZ files symbolic link of the HHZ files.
# ls /lustre/janus_scratch/howa1663/CC_JdF/2011.*/2011*/ft*HHZ* > HHZ.txt

Lst_HHZ=`ls /lustre/janus_scratch/howa1663/CC_JdF/2011.*/2011*/ft*HHZ*`
for list_HHZ in $Lst_HHZ
do 
	list_BHZ=`echo $list_HHZ | sed 's/HHZ/BHZ/'`
	ln -s $list_HHZ $list_BHZ
	echo `date`: Symbolic link $list_BHZ to $list_HHZ >> HHZ_2_BHZ.log
done
