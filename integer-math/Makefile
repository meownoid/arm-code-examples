ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/math

bin/math: bin main.s debug.s
	clang $(DEBUG_FLAGS) -lSystem -lc -e main -arch arm64 -o bin/math main.s

bin:
	mkdir -p bin
