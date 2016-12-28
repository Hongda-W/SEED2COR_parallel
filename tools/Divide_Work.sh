#!/bin/bash
# Divide the work by month to improve the efficiency of readseed.
# Split the seed.lst file by months
# Create different directoies for every divided time periods and go into that directory to run 'new_run_COR.sh' 

SEED_dir=/lustre/janus_scratch/howa1663/Seis_Data/SEED
JdF_dir=/lustre/janus_scratch/howa1663/CC_JdF # aim directory
run_COR_dir=/projects/howa1663/Code/CROS_CO/SEED2COR_parallel

mkdir $SEED_dir/Divide_SeedLst/
cd $SEED_dir/Divide_SeedLst/
cp ../seed.lst ./seed.lst #copy the seed list that we want to split to this directory
gawk -F. '{if (NR==1) 
	{ MON = $2;
	NUM = 1;}
else if ($2 !~ MON)
	{ NUM += 1;
	  MON = $2;}
print $0 > "seed"NUM".lst"; }' seed.lst # Divide the original seed.lst to mutiple files according to the months
N=`ls | wc -l`
N=$[$N - 1]
for num in `seq 1 $N`
do
	cd $JdF_dir
	mkdir 'Split'$num # make a working directory for every subjob
	cd 'Split'$num
	cp ../parameters.txt ./
	cat parameters.txt | gawk -v num=$num '{if ($0 ~ /seed.lst/) {printf "/lustre/janus_scratch/howa1663/Seis_Data/SEED/Divide_SeedLst/seed%d.lst\n", num }  else print $0 }' > parameters_new.txt # change the seed lst file in parameter file
        cp $run_COR_dir/run_COR.sh ./
        cat run_COR.sh | gawk -v WD=$PWD '{if ($0 ~ /cd \/lustre\/janus_scratch\/howa1663\/CC_JdF/) {printf "cd %s\n", WD} else print $0 }' | sed 's/parameters.txt/parameters_new.txt/' > new_run_COR.sh # edit the new script to run the COR
#         ml load slurm # load slurm to submit the job
        sbatch --qos=janus-long new_run_COR.sh
done
