# This is a c++ code. Using g++ compiler.
CC=g++

# Compiler flags.
CFLAGS= -g

#vpath %.cc /home/wuyi/usr/ve490_v4/cudd
vpath %.c /home/wangchen/Research/cudd/cudd-2.5.0/cudd: 


WHERE	= /home/wangchen/Research/cudd/cudd-2.5.0
#WHERE_ABC	= ../abc
LIBS	= $(WHERE)/dddmp/libdddmp.a $(WHERE)/cudd/libcudd.a \
	$(WHERE)/mtr/libmtr.a $(WHERE)/st/libst.a $(WHERE)/util/libutil.a \
	$(WHERE)/epd/libepd.a 
#LIBS	= libabc.a 


MAINSRC = main.cc 
OTHSRC1 = bnet.cc queue.cc basics.cc
OTHSRC2 = find_print_candidate_MFFC.cc

SRC = $(MAINSRC) $(OTHSRC1)  $(OTHSRC2) 
OBJ = $(SRC:.cc=.o)
TARGET = main

# make all runs.
all: $(TARGET)


%.o: %.cc
	$(CC) $(CFLAGS) -o $@  -c $< 

	

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)  $(LIBS) -lm -ldl -rdynamic -lreadline -ltermcap -lpthread -lrt 

#$(TARGET): $(OBJ)
#	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)


# make clean
clean:
	rm -f $(OBJ) $(TARGET)

