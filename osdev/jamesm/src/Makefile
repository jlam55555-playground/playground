# Makefile for JamesM's kernel tutorials.
# The C and C++ ruls are already set up by default.
# The only one that needs changing is the assembler
# rule, as we use nasm instead of GNU as.

SOURCES=boot.o main.o

CFLAGS=-nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32
LDFLAGS=-TLink.ld -m elf_i386
ASFLAGS=-felf

all: $(SOURCES) link

clean:
	-rm *.o link

link:
	ld $(LDFLAGS) -o kernel $(SOURCES)

.s.o:
	nasm $(ASFLAGS) $<
