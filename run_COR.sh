#!/bin/bash

#SBATCH -J S2Cpp
#SBATCH -o S2Cpp_%j.out
#SBATCH -e S2Cpp_%j.err
#SBATCH -N 1
#SBATCH --ntasks-per-node=12
#SBATCH --time=24:00:00
#SBATCH --mem=MaxMemPerNode

module load gcc/5.1.0
module load fftw
#. ~/.my.bashforSEED2COR


cppexe=/projects/howa1663/Code/CROS_CO/SEED2COR_parallel/Seed2Cor
cd /lustre/janus_scratch/howa1663/CC_JdF
#cd /lustre/janus_scratch/life9360/TEST_001
export OMP_NUM_THREADS=12; $cppexe parameters.txt <<- END
Y
END
