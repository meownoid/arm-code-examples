import click

TEMPLATE = """
ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

SOURCE_FILES = $(wildcard {src_dir}*.s)
OBJECT_FILES = $(patsubst {src_dir}%.s,{bin_dir}/%.o,$(SOURCE_FILES))

all: {bin_dir}/{name}

{bin_dir}/{name}: $(OBJECT_FILES)
	ld -o {bin_dir}/{name} $(OBJECT_FILES) -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start

{bin_dir}/%.o : {src_dir}%.s {bin_dir}
	as $(DEBUG_FLAGS) $< -o $@

{bin_dir}:
	mkdir -p {bin_dir}
"""


@click.command()
@click.option("--source-dir", type=str, default="", help="Source directory")
@click.option("--bin-dir", type=str, default="bin", help="Binary directory")
@click.argument("name", type=str)
def main(source_dir: str, bin_dir: str, name: str):
    print(TEMPLATE.strip().format(src_dir=source_dir, bin_dir=bin_dir, name=name))


if __name__ == "__main__":
    main()
