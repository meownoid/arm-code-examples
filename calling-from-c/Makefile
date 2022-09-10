ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/test

bin/test: bin main.c toupper.s
	clang $(DEBUG_FLAGS) -o bin/test main.c toupper.s

bin:
	mkdir -p bin
