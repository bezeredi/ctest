UNAME=$(shell uname)

CCFLAGS=-Wall -Wextra -Wno-unused-parameter -O2 -DCOLOR_OK
ifdef CTEST_COLOR_OK
CCFLAGS+=-DCOLOR_OK
endif

ifeq ($(UNAME), Darwin)
LDFLAGS=-Wl,-flat_namespace,-undefined,dynamic_lookup
endif

all: ctest

remake: clean all

%.o: %.c ctest.h
	gcc $(CCFLAGS) -c -o $@ $<

ctest: main.o ctest.h mytests.o
	gcc $(LDFLAGS) main.o mytests.o -o runtests

clean:
	rm -f runtests *.o

