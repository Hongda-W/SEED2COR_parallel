#!/bin/bash
# Rename the files in the Split directories and move them to the according daily directory
# Every Split directory can only have 1 Month's data

if [ $# -ne 3 ]
then
  echo "USAGE: "$0" [dir] [old_chan_name] [new_chan_name]"
  exit 1
fi
Split_lst=`ls -d $1/'Split'[0-9]*`
for splits in $Split_lst
do
        cd $splits
#	MON_Lst=`ls -d 20[0-9][0-9]'.'[[:upper:]][A-Z][A-Z]`
	MON=`ls -d 20[0-9][0-9]'.'{JAN,FEB,MAR,APR,JUN,JUL,AUG,SEP,OCT,NOV,DEC} 2>>/dev/null`
	if [[ -z "${MON// }" ]] # if string is NULL
	then
	    break
	else 
	do
	cd $MON
	YM=`pwd | gawk -F/ '{print $NF}'` # something like 2012.MAR
#        Day_lst=`ls -d 20[0-9][0-9]'.'[[:upper:]][A-Z][A-Z]'.'[0-9]*`
	Day_lst=`ls -d $YM'.'[0-9]*`
        for days in $Day_lst
        do
#            mv $splits/$MON/$days/ft_20[0-9][0-9]'.'[A-Z][A-Z][A-Z]'.'[0-9]*'.'*'.'$2'.'* $1/$MON/$days
	    mv $splits/$MON/$days/ft_$days'.'*'.'$2'.'* $1/$MON/$days
	    cd $1/$MON/$days
#	    list_old=`ls ft_20[0-9][0-9]'.'[A-Z][A-Z][A-Z]'.'[0-9]*'.'*'.'$2'.'*`
	    list_old=`ls ft_$days'.'*'.'$2'.'*`
	    for olds in $list_old
	    do
	        news=`echo $olds | sed "s/.$2./.$3./"`
		if [ -e $news ]
		then
		    echo $news alredy exits >> /projects/howa1663/Code/CROS_CO/SEED2COR_parallel/tools/Renam_N_move.log
		else
		  ln -s $olds $news
		  echo `date`: Symbolic link $olds to $news >> /projects/howa1663/Code/CROS_CO/SEED2COR_parallel/tools/Renam_N_move.log
		fi
	    done
	done
done
fi
done

