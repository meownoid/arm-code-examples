ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

SOURCE_FILES = $(wildcard *.s)
OBJECT_FILES = $(patsubst %.s,bin/%.o,$(SOURCE_FILES))

all: bin/itoa

bin/itoa: $(OBJECT_FILES)
	ld -o bin/itoa $(OBJECT_FILES) -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start

bin/%.o : %.s bin
	as $(DEBUG_FLAGS) $< -o $@

bin:
	mkdir -p bin
