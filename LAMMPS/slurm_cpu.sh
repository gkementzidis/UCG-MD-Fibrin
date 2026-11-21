#!/bin/bash
#SBATCH --job-name=C8+
#SBATCH --output=run_%j.out
#SBATCH --error=run_%j.err
#SBATCH -p long-40core
#SBATCH --time=40:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=20

# Load the LAMMPS module
module load lammps/intel/2024.0/29Aug2024

cd $SLURM_SUBMIT_DIR

# mkdir output_dump
mkdir output_data_01
mkdir output_restart_01

# Define input file
INPUT="input.in"

mpirun -np $SLURM_NTASKS lmp_mpi -in $INPUT

# CONVERSION
for i in {1000000..101000000..1000000}
do
    mpirun -np $SLURM_NTASKS lmp_mpi -r2data ./output_restart_01/fibri-$i.restart ./output_data_01/fibri-$i.data
done
