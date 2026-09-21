#!/usr/bin/python3

import json
import plistlib
import sys
from typing import Any


def convert_json_to_plist(json_file_path: str, plist_file_path: str) -> None:
  # Load the JSON data.
  with open(json_file_path) as json_file:
    json_data: Any = json.load(json_file)

  # Remove the "policies" key.
  if "policies" in json_data:
    json_data = json_data["policies"]

  # Convert JSON data to plist format.
  with open(plist_file_path, "wb") as plist_file:
    plistlib.dump(json_data, plist_file)

  print(f'Conversion complete! The plist file is saved as "{plist_file_path}".')


def main() -> int:

  required_args: int = 3
  if len(sys.argv) != required_args:
    print("Usage: python3 convert_json_to_plist.py <input_json_file> <output_plist_file>")
    return 1

  try:
    convert_json_to_plist(sys.argv[1], sys.argv[2])

  except (json.JSONDecodeError, OSError) as e:
    print(e)
    return 1

  return 0


if __name__ == "__main__":
  sys.exit(main())
