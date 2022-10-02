ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/dot

bin/dot: bin main.s
	clang $(DEBUG_FLAGS) -lSystem -lc -e main -arch arm64 -o bin/dot main.s

bin:
	mkdir -p bin
