ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/mult

bin/mult: bin main.s debug.s
	clang $(DEBUG_FLAGS) -lSystem -lc -e main -arch arm64 -o bin/mult main.s

bin:
	mkdir -p bin
