# MSTM (fork)

This is a fork of Dan Mackowski's MSTM method, released under the MIT license.
This fork is maintained by Inigo Gonzalez de Arrieta (https://github.com/inigogonzalezdearrieta).
New functionalities and some code cleanup are to be expected.
Main goal: to develop new methods to analyze effective medium theories numerically.

## Installation

In the manual, Dan Mackowski recommends compiling the parallel version of the code by combining gfortran with Microsoft's implementation of the MPI protocol (ms-mpi). This leads to a complicated installation procedure that can be easily avoided in modern Windows machines by running WSL (Windows Subsystem for Linux). The instructions below assume that the reader is running a Debian-based OS (such as Ubuntu), either natively or through WSL.

The following command should be used to install the serial and parallel compilers:

> sudo apt install gfortran mpich

MSTM relies on intrinsic subroutines of the gfortran compiler and its parallel counterpart, mpif90 (part of the MPICH package). Therefore, the use of this compiler will be assumed in this guide.

### Serial compilation

Run the following command from the command line:

> gfortran -O2 -fallow-argument-mismatch -o mstm-serial.out mstm-intrinsics.f90 mpidefs-serial.f90 mstm-v4.0.f90

The -O2 flag is required for non-critical optimization of the code. The -fallow-argument-mismatch flag is required in modern versions of gfortran to avoid compilation errors.

### Parallel compilation

Run the following command from the command line:

> mpif90 -O2 -fallow-argument-mismatch -o mstm-parallel.out mstm-intrinsics.f90 mpidefs-parallel.f90 mstm-v4.0.f90

The mpidefs file changes in order to accommodate different variable definitions.

### Running the code

It is best to compile both programs on the same directory (e.g., MSTM/bin) and add it to the $PATH. To do that, open your *~/.profile* file:

> nano ~/.profile

and paste the following code at the end:

> export PATH="$PATH:/new/path/to/your/binary/file"

It is also more convenient to define aliases for the *mstm-serial.out* and *mstm-parallel.out* files. To do so, open the bash configuration file:

> nano ~/.bashrc

and paste the following code at the end:

> alias mstm="mstm-serial.out"
>
> alias mstmp="mstm-parallel.out"

After restarting the terminal these changes should be permanent.
