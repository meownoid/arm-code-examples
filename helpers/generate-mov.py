import sys

import click


class IntegerParamType(click.ParamType):
    name = "integer"

    def convert(self, value, param, ctx):
        if isinstance(value, int):
            return value

        if value.startswith("0x"):
            base = 16
        elif value.startswith("0b"):
            base = 2
        elif value.startswith("0"):
            base = 8
        else:
            base = 10

        try:
            return int(value, base)
        except ValueError:
            self.fail(f"{value!r} is not a valid integer", param, ctx)


def upper_hex(x):
    r = hex(x)


@click.command()
@click.argument("register", type=str)
@click.argument("value", type=IntegerParamType())
def main(register: str, value: int):
    """Generates ARM assembly code to move value into register."""

    if value >> 64 != 0:
        print(
            "WARNING: value takes more than 64 bit and will be truncated",
            file=sys.stderr,
        )

    mask = 0x0000_0000_0000_FFFF

    for shift in [0, 16, 32, 48]:
        suffix = "z" if shift == 0 else "k"
        v = (value & mask << shift) >> shift

        if v == 0 and shift > 0:
            continue

        lsl = "" if shift == 0 else f", LSL #{shift}"

        print(f"mov{suffix} {register}, #0x{v:X}{lsl}")


if __name__ == "__main__":
    main()
