#!/bin/bash
# Move the directories of every month from the Split directoies to the CC_JdF directory.
if [ $# -ne 1 ]
then
	echo "Please put in the number of splits"
	exit 1
fi

Back=` pwd `
JdF_dir=/lustre/janus_scratch/howa1663/CC_JdF
for num in `seq 1 $1`
do
        cd $JdF_dir
        cd 'Split'$num
	mv ./20[0-9][0-9].[A-Z][A-Z][A-Z] ../
	echo "Done for Split"$num
done
