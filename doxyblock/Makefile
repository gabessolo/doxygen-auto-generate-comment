IDIR =.
CC=g++
CFLAGS=-I$(IDIR)

ODIR=obj
LDIR =lib

LIBS=

_DEPS = doxyblock.h 
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = doxyblock.o fixblock.o addblock.o tools.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


$(ODIR)/%.o: %.cpp $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

doxyblock: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o 
