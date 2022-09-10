ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/inline

bin/inline: bin main.c
	clang $(DEBUG_FLAGS) -o bin/inline main.c

bin:
	mkdir -p bin
