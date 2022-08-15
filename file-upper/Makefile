ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

SOURCE_FILES = $(wildcard *.s) $(wildcard *.S)
OBJECT_FILES = $(patsubst %.S,bin/%.o, $(patsubst %.s,bin/%.o,$(SOURCE_FILES)))

all: bin/file-upper

bin/file-upper: $(OBJECT_FILES)
	ld -o bin/file-upper $(OBJECT_FILES) -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

bin/%.o : %.s bin
	as $(DEBUG_FLAGS) $< -o $@

bin/%.o : %.S bin
	clang $(DEBUG_FLAGS) -c $< -o $@

bin:
	mkdir -p bin
