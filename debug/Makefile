ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/debug

bin/debug: bin main.s debug.s
	clang $(DEBUG_FLAGS) -lSystem -lc -e main -arch arm64 -o bin/debug main.s

bin:
	mkdir -p bin
