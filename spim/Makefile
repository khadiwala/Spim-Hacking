#
# SPIM S20 MIPS Simulator.
# Makefile for SPIM.
#
# Copyright (C) 1990-2005 by James Larus (larus@cs.wisc.edu).
# ALL RIGHTS RESERVED.
#
# SPIM is distributed under the following conditions:
#
#   You may make copies of SPIM for your own use and modify those copies.
#
#   All copies of SPIM must retain my name and copyright notice.
#
#   You may not sell SPIM or distributed SPIM in conjunction with a commerical
#   product or service without the expressed written consent of James Larus.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE.
#
# $Header: $

#
# To make spim, type:
#
#   make spim
#
# Cannot make xpsim under windows.  Use PCSpim instead.
#
# To verify spim works, type:
#
#   make test
#

.SUFFIXES:
.SUFFIXES: .c .o

#
# The following parameters must be set for the target machine:
#
#

# Path for directory that contains the source of the CPU code:
CPU_DIR = ../CPU
VPATH = src:$(CPU_DIR)

# Path of directory that contains SPIM tests:
TEST_DIR = ../Tests

# Path of directory that contains documentation:
DOC_DIR = ../Documentation



# Full path for the directory that will hold the executable files:
BIN_DIR = /usr/bin

# Full path for the directory that will hold the exception handler:
EXCEPTION_DIR = .

# Full path for the directory that will hold the man files:
MAN_DIR = /usr/share/man/en


# If you have flex, use it instead of lex.  If you use flex, define this
# variable and set LEXFLAGS.
MYLEX = flex

# SPIM needs flex's -I flag since the scanner is used interactively.
# You can set the -8 flag so that funny characters do not hang the scanner.
LEXFLAGS = -I -8


# If you use lex, set the variables this way:
#MYLEX = lex
#LEXFLAGS =


# Size of the segments when spim starts up (data segment must be >= 64K).
# (These sizes are fine for most users since SPIM dynamically expands
# the memory as necessary.)
MEM_SIZES = -DTEXT_SIZE=65536 -DDATA_SIZE=131072 -DK_TEXT_SIZE=65536


#
# End of parameters
#


ENDIAN=`cat configuration`

DEFINES = $(ENDIAN) $(MEM_SIZES) -DDEFAULT_EXCEPTION_HANDLER="\"$(EXCEPTION_DIR)/exceptions.s\"" -DSPIM_VERSION="\"`cat ../VERSION`\""

CC = gcc
CFLAGS = -I. -I$(CPU_DIR) $(DEFINES) -g -Wall
YFLAGS = -d --file-prefix=y
YCFLAGS =
LDFLAGS = -lm
CSH = bash

# lex.yy.c is usually compiled with -O to speed it up.

LEXCFLAGS = -O $(CFLAGS)



OBJS = spim-utils.o run.o mem.o inst.o data.o sym-tbl.o y.tab.o lex.yy.o \
       syscall.o display-utils.o string-stream.o


spim:   force
	make -f Makefile spim2

spim2:	$(OBJS) spim.o
	$(CC) -g $(OBJS) spim.o $(LDFLAGS) -o spim -lm


force:	configuration

configuration:
	./Configure

#

#
# Test spim with a torture test:
#

test:	spim
	@echo
	@echo "Testing tt.bare.s:"
	$(CSH) -c "./spim -delayed_branches -delayed_loads -noexception -file $(TEST_DIR)/tt.bare.s >& test.out"
	@tail -2 test.out
	@echo

	@echo
	@echo "Testing tt.core.s:"
	$(CSH) -c "./spim -ef $(CPU_DIR)/exceptions.s -file $(TEST_DIR)/tt.core.s < $(TEST_DIR)/tt.in >& test.out"
	@tail -2 test.out
	@echo

	@echo
	@echo "Testing tt.endian.s:"
	$(CSH) -c "./spim -ef $(CPU_DIR)/exceptions.s -file $(TEST_DIR)/tt.endian.s  >& test.out"
	@tail -2 test.out
	@echo
	@echo

# This test currently only works for little-endian machines.  The file
# tt.alu.bare.s needs to be converted in places for big-endian machines.

test_bare: spim
	@echo
	@echo "Testing tt.alu.bare.s:"
	$(CSH) -c "./spim -bare -noexception -file $(TEST_DIR)/tt.alu.bare.s >& test.out"
	@tail -2 test.out
	@echo

	@echo
	@echo "Testing tt.fpt.bare.s:"
	$(CSH) -c "./spim -bare -noexception -file $(TEST_DIR)/tt.fpu.bare.s >& test.out"
	@tail -2 test.out
	@echo
	@echo

#

TAGS:	*.c *.h *.l *.y
	etags *.l *.y *.c *.h


clean:
	rm -f spim spim.exe *.o TAGS test.out lex.yy.c y.tab.c y.tab.h y.output

install: spim
	install -D spim $(BIN_DIR)/spim
	install -D -m 0444 $(CPU_DIR)/exceptions.s $(EXCEPTION_DIR)/exceptions.s

install-man:
	install -D -m 0444 $(DOC_DIR)/spim.man $(MAN_DIR)

very-clean: clean
	rm -f configuration

splint: spim
	splint -weak -preproc -warnposix +matchanyintegral spim.c y.tab.c lex.yy.c



#
# Dependences not handled well by makedepend:
#


y.tab.h: y.tab.c

y.tab.c: $(CPU_DIR)/parser.y
	bison $(YFLAGS) $(CPU_DIR)/parser.y

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) $(YCFLAGS) -c y.tab.c


lex.yy.c: $(CPU_DIR)/scanner.l
	$(MYLEX) $(LEXFLAGS) $(CPU_DIR)/scanner.l

lex.yy.o: lex.yy.c
	$(CC) $(LEXCFLAGS) -c lex.yy.c


#
# DO NOT DELETE THIS LINE -- make depend depends on it.

data.o: $(CPU_DIR)/spim.h
data.o: $(CPU_DIR)/string-stream.h
data.o: $(CPU_DIR)/spim-utils.h
data.o: $(CPU_DIR)/inst.h
data.o: $(CPU_DIR)/reg.h
data.o: $(CPU_DIR)/mem.h
data.o: $(CPU_DIR)/sym-tbl.h
data.o: $(CPU_DIR)/parser.h
data.o: $(CPU_DIR)/run.h
data.o: $(CPU_DIR)/data.h
display-utils.o: $(CPU_DIR)/spim.h
display-utils.o: $(CPU_DIR)/string-stream.h
display-utils.o: $(CPU_DIR)/spim-utils.h
display-utils.o: $(CPU_DIR)/inst.h
display-utils.o: $(CPU_DIR)/data.h
display-utils.o: $(CPU_DIR)/reg.h
display-utils.o: $(CPU_DIR)/mem.h
display-utils.o: $(CPU_DIR)/run.h
display-utils.o: $(CPU_DIR)/sym-tbl.h
dump_ops.o: $(CPU_DIR)/op.h
inst.o: $(CPU_DIR)/spim.h
inst.o: $(CPU_DIR)/string-stream.h
inst.o: $(CPU_DIR)/spim-utils.h
inst.o: $(CPU_DIR)/inst.h
inst.o: $(CPU_DIR)/reg.h
inst.o: $(CPU_DIR)/mem.h
inst.o: $(CPU_DIR)/sym-tbl.h
inst.o: $(CPU_DIR)/parser.h
inst.o: $(CPU_DIR)/scanner.h
inst.o: y.tab.h
inst.o: $(CPU_DIR)/data.h
inst.o: $(CPU_DIR)/op.h
mem.o: $(CPU_DIR)/spim.h
mem.o: $(CPU_DIR)/string-stream.h
mem.o: $(CPU_DIR)/spim-utils.h
mem.o: $(CPU_DIR)/inst.h
mem.o: $(CPU_DIR)/reg.h
mem.o: $(CPU_DIR)/mem.h
run.o: $(CPU_DIR)/spim.h
run.o: $(CPU_DIR)/string-stream.h
run.o: $(CPU_DIR)/spim-utils.h
run.o: $(CPU_DIR)/inst.h
run.o: $(CPU_DIR)/reg.h
run.o: $(CPU_DIR)/mem.h
run.o: $(CPU_DIR)/sym-tbl.h
run.o: y.tab.h
run.o: $(CPU_DIR)/syscall.h
run.o: $(CPU_DIR)/run.h
spim-utils.o: $(CPU_DIR)/spim.h
spim-utils.o: $(CPU_DIR)/string-stream.h
spim-utils.o: $(CPU_DIR)/spim-utils.h
spim-utils.o: $(CPU_DIR)/inst.h
spim-utils.o: $(CPU_DIR)/data.h
spim-utils.o: $(CPU_DIR)/reg.h
spim-utils.o: $(CPU_DIR)/mem.h
spim-utils.o: $(CPU_DIR)/scanner.h
spim-utils.o: $(CPU_DIR)/parser.h
spim-utils.o: y.tab.h
spim-utils.o: $(CPU_DIR)/run.h
spim-utils.o: $(CPU_DIR)/sym-tbl.h
string-stream.o: $(CPU_DIR)/spim.h
string-stream.o: $(CPU_DIR)/string-stream.h
sym-tbl.o: $(CPU_DIR)/spim.h
sym-tbl.o: $(CPU_DIR)/string-stream.h
sym-tbl.o: $(CPU_DIR)/spim-utils.h
sym-tbl.o: $(CPU_DIR)/inst.h
sym-tbl.o: $(CPU_DIR)/reg.h
sym-tbl.o: $(CPU_DIR)/mem.h
sym-tbl.o: $(CPU_DIR)/data.h
sym-tbl.o: $(CPU_DIR)/parser.h
sym-tbl.o: $(CPU_DIR)/sym-tbl.h
sym-tbl.o: y.tab.h
syscall.o: $(CPU_DIR)/spim.h
syscall.o: $(CPU_DIR)/string-stream.h
syscall.o: $(CPU_DIR)/inst.h
syscall.o: $(CPU_DIR)/reg.h
syscall.o: $(CPU_DIR)/mem.h
syscall.o: $(CPU_DIR)/sym-tbl.h
syscall.o: $(CPU_DIR)/syscall.h
lex.yy.o: $(CPU_DIR)/spim.h
lex.yy.o: $(CPU_DIR)/string-stream.h
lex.yy.o: $(CPU_DIR)/spim-utils.h
lex.yy.o: $(CPU_DIR)/inst.h
lex.yy.o: $(CPU_DIR)/reg.h
lex.yy.o: $(CPU_DIR)/sym-tbl.h
lex.yy.o: $(CPU_DIR)/parser.h
lex.yy.o: $(CPU_DIR)/scanner.h
lex.yy.o: y.tab.h
lex.yy.o: $(CPU_DIR)/op.h
spim.o: $(CPU_DIR)/spim.h
spim.o: $(CPU_DIR)/string-stream.h
spim.o: $(CPU_DIR)/spim-utils.h
spim.o: $(CPU_DIR)/inst.h
spim.o: $(CPU_DIR)/reg.h
spim.o: $(CPU_DIR)/mem.h
spim.o: $(CPU_DIR)/parser.h
spim.o: $(CPU_DIR)/sym-tbl.h
spim.o: $(CPU_DIR)/scanner.h
spim.o: y.tab.h
y.tab.o: $(CPU_DIR)/spim.h
y.tab.o: $(CPU_DIR)/string-stream.h
y.tab.o: $(CPU_DIR)/spim-utils.h
y.tab.o: $(CPU_DIR)/inst.h
y.tab.o: $(CPU_DIR)/reg.h
y.tab.o: $(CPU_DIR)/mem.h
y.tab.o: $(CPU_DIR)/sym-tbl.h
y.tab.o: $(CPU_DIR)/data.h
y.tab.o: $(CPU_DIR)/scanner.h
y.tab.o: $(CPU_DIR)/parser.h
