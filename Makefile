# Default Makefile for Fortran programs
DEFAULT_FC = gfortran
# if the FC environment variable is not set, use the default compiler
ifeq ($(FC),)
FC = $(DEFAULT_FC)
endif
# print the compiler that will be used
$(info Using compiler $(FC))

# if the compiler is ifort, use the following flags
ifeq ($(FC),ifort)
FFLAGS = -check -traceback -debug extended -debug-parameters -warn
# if the compiler is gfortran, use the following flags
else ifeq ($(FC),gfortran)
FFLAGS = -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -g -fcheck=all -fbacktrace
endif

# default target
all: clean create-file read-file-performance

# Compile create-file.f90 to create-file
create-file: create-file.f90
	$(FC) $(FFLAGS) -o create-file create-file.f90

# Compile read-file-performance.f90 to read-file-performance
read-file-performance: read-file-performance.f90
	$(FC) $(FFLAGS) -o read-file-performance read-file-performance.f90

# Clean up
clean:
	rm -f create-file read-file-performance
