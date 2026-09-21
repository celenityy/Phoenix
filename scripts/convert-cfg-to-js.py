#!/usr/bin/python3

import sys


def process_file(input_file: str, output_file: str) -> None:
  with open(input_file) as infile, open(output_file, "w") as outfile:

    for line in infile:
      if "[FN]" in line:
        continue

      stripped: str = line.lstrip()

      if stripped.startswith("defaultPref("):
        transformed: str = stripped.replace("defaultPref(", "pref(")
        outfile.write(transformed)

      elif stripped.startswith("lockPref("):
        transformed: str = stripped.replace("lockPref(", "pref(").replace(")", ", locked)")
        outfile.write(transformed)

      elif stripped.startswith("pref("):
        outfile.write(stripped)


def main() -> int:

  required_args: int = 3
  if len(sys.argv) != required_args:
    print("Usage: python3 convert-cfg-to-js.py <input.cfg> <output.js>")
    return 1

  try:
    process_file(sys.argv[1], sys.argv[2])
    print(f"Processed {sys.argv[1]} and saved to {sys.argv[2]}.")

  except OSError as e:
    print(e)
    return 1

  return 0


if __name__ == "__main__":
  sys.exit(main())
