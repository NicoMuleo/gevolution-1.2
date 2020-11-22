# programming environment
COMPILER     := mpic++
INCLUDE      := -I../LATfield2 -I/usr/include/hdf5/openmpi -I../class_public-2.9.4/include -I/usr/include -I/usr/include/healpix_cxx #-I/usr/local/hdf5/bin -I/usr/local/hdf5/include -I/usr/local/hdf5/lib  # add the path to LATfield2 and other libraries (if necessary)
LIB          := -lfftw3 -lm -lhdf5 -lgsl -lgslcblas -L/usr/lib/x86_64-linux-gnu/hdf5/openmpi -L../class_public-2.9.4 -lclass -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu -lchealpix -lcfitsio -L/usr/lib/x86_64-linux-gnu

# target and source
EXEC         := gevolution
SOURCE       := main.cpp
HEADERS      := $(wildcard *.hpp)

# mandatory compiler settings (LATfield2)
DLATFIELD2   := -DFFT3D -DHDF5

# optional compiler settings (LATfield2)
DLATFIELD2   += -DH5_HAVE_PARALLEL
#DLATFIELD2   += -DEXTERNAL_IO
#DLATFIELD2   += -DSINGLE     # switches to single precision, use LIB -lfftw3f

# optional compiler settings (gevolution)
DGEVOLUTION  := -DPHINONLINEAR
DGEVOLUTION  += -DBENCHMARK
DGEVOLUTION  += -DEXACT_OUTPUT_REDSHIFTS
#DGEVOLUTION  += -DVELOCITY      # enables velocity field utilities
#DGEVOLUTION  += -DCOLORTERMINAL
#DGEVOLUTION  += -DCHECK_B
#DGEVOLUTION  += -DHAVE_CLASS    # requires LIB -lclass
DGEVOLUTION  += -DHAVE_HEALPIX  # requires LIB -lchealpix

# further compiler options
#OPT          := -O3 -std=c++11 -fopenmp

$(EXEC): $(SOURCE) $(HEADERS) makefile
	$(COMPILER) $< -o $@ $(OPT) $(DLATFIELD2) $(DGEVOLUTION) $(INCLUDE) $(LIB)
	
lccat: lccat.cpp
	$(COMPILER) $< -o $@ $(OPT) $(DGEVOLUTION) $(INCLUDE)

clean:
	-rm -f $(EXEC) lccat

