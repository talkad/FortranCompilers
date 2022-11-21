#!/bin/bash

# gfortran -c heat_equation_abstract.f90 heat_equation.f90 heat_map.f90 main.f90 -fopenmp
# gfortran -o scaling_script heat_equation_abstract.o heat_equation.o heat_map.o main.o -fopenmp

ifort -c heat_equation_abstract.f90 heat_equation.f90 heat_map.f90 main.f90 -qopenmp
ifort -o scaling_script heat_equation_abstract.o heat_equation.o heat_map.o main.o -qopenmp -O3


for i in {1..12}
do
   ./scaling_script $i
   # srun -p cluster -N1 -c $i ./scaling_script $i
done

python strong_scale.py