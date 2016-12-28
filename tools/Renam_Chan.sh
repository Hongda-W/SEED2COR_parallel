#!/bin/bash
## NOT Useful!!!
# Create symbolic link files with new channel name for old channel files
# Applicable for data from year 2000 to 2099, rename the filtered .SAC; .amp; .ph files.

if [ $# -ne 3 ] 
then
  echo "USAGE: "$0" [dir] [old_chan_name] [new_chan_name] Need modification!!"
  exit 1
fi
# a="JAN" b="FEB" c="MAR" d="APR" e="JUN" f="JUL" g="AUG" h="SEP" i="OCT" j="NOV" k="DEC"
startT=`date +%s`
# Mon_lst=`ls -d $1/20[0-9][0-9]'.'[[:upper:]][A-Z][A-Z]`
Mon_lst=`ls -d $1/20[0-9][0-9]'.'{JAN,FEB,MAR,APR,JUN,JUL,AUG,SEP,OCT,NOV,DEC}`
N_Mon=`echo $Mon_lst | wc -w`
# /20[0-9][0-9]'.'[[:upper:]][A-Z][A-Z]'.'[0-9]*/ft_20[0-9][0-9]'.'[A-Z][A-Z][A-Z]'.'[0-9]*'.'*'.'$2'.'*`
for mons in $Mon_lst
do
	cd $mons
# 	Day_lst=`ls -d ./20[0-9][0-9]'.'[[:upper:]][A-Z][A-Z]'.'[0-9]*`
	Day_lst=`ls -d ./20[0-9][0-9]'.'{JAN,FEB,MAR,APR,JUN,JUL,AUG,SEP,OCT,NOV,DEC}'.'[0-9]?`
	for days in $Day_lst
	do
	cd ./$days
	list_old=`ls *HHZ*` # Not finished, need modification
	list_new=`echo $list_old | sed 's/$2/$3/'` # Not finished, need modification
	ln -s $list_old $list_new
	echo `date`: Symbolic link $list_old to $list_new >> /projects/howa1663/Code/CROS_CO/SEED2COR_parallel/tools/Renam_Chan.log
	done
done
endT=`date +%s`
echo All symbolic link created, runtime: $((endT-startT)) seconds. >> /projects/howa1663/Code/CROS_CO/SEED2COR_parallel/tools/Renam_Chan.log
