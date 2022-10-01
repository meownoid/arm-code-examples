ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

all: bin/distance

bin/distance: bin main.s distance.s
	clang $(DEBUG_FLAGS) -lSystem -lc -e main -arch arm64 -o bin/distance main.s distance.s

bin:
	mkdir -p bin
