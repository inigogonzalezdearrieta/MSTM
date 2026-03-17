# Makefile created to streamline compilation instructions.
# Created by Inigo on 2026/03/09.

# Detect installed compilers.
MPIF90 := $(shell command -v mpif90 2>/dev/null) # Returns 0 if it exists, without printing to stdout or stderr.
GFORTRAN := $(shell command -v gfortran 2>/dev/null)

# Compilation is slightly different with each compiler.
ifeq ($(MPIF90),)
	ifeq ($(GFORTRAN),)
		$(error Neither mpif90 nor gfortran found in PATH)
	else
		FC := gfortran
    	SRC := code/mstm-intrinsics.f90 code/mpidefs-serial.f90 code/mstm-v4.0.f90
	endif
else
	FC := mpif90
	SRC := code/mstm-intrinsics.f90 code/mpidefs-parallel.f90 code/mstm-v4.0.f90
endif

# Local directory of binary files (should be in $PATH).
BINDIR := /usr/local/bin
# The second flag prevents errors.
FFLAGS := -O2 -fallow-argument-mismatch
TARGET := mstm.out

$(TARGET):
	$(FC) $(FFLAGS) -o $(TARGET) $(SRC)

install: $(TARGET)
	mkdir -p $(BINDIR) # No error if the bin directory already exists.
	sudo cp $(TARGET) $(BINDIR)/$(TARGET)

clean:
	rm -f *.mod # Delete all modules.

uninstall:
	rm -f $(BINDIR)/$(TARGET)
