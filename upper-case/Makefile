ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

SOURCE_FILES = $(wildcard *.s)
OBJECT_FILES = $(patsubst %.s,bin/%.o,$(SOURCE_FILES))

all: bin/upper-case

bin/upper-case: $(OBJECT_FILES)
	ld -o bin/upper-case $(OBJECT_FILES) -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start

bin/%.o : %.s bin
	as $(DEBUG_FLAGS) $< -o $@

bin:
	mkdir -p bin
