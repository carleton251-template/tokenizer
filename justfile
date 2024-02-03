# Change "no" to "yes" to use Dave's binaries
USE_BINARIES := "no"

SRCS := if USE_BINARIES == "yes" {
	replace("lib/linkedlist.o lib/talloc.o main.c tokenizer.c", ".o", "-"+arch()+".o")
} else {
	"linkedlist.c talloc.c main.c tokenizer.c"
}


CC := "clang"
CFLAGS := "-gdwarf-4 -fPIC"

default:
	just --list

build:
	{{CC}} {{CFLAGS}} {{SRCS}} -o interpreter
	rm -f *.o
	rm -f vgcore.*

compile target:
	{{CC}} {{CFLAGS}} -c {{target}} -o {{trim_end_match(target, ".c")}}-{{arch()}}.o

clean:
	-rm *.o
	-rm interpreter
