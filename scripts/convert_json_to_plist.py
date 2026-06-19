import json
import plistlib
import sys

def convert_json_to_plist(json_file_path, plist_file_path):
  # Load the JSON data
  with open(json_file_path, 'r') as json_file:
    json_data = json.load(json_file)

  # Remove the 'policies' key
  if 'policies' in json_data:
    json_data = json_data['policies']

  # Convert JSON data to plist format
  with open(plist_file_path, 'wb') as plist_file:
    plistlib.dump(json_data, plist_file)

  print(f"Conversion complete! The plist file is saved as '{plist_file_path}'.")

if __name__ == "__main__":
  if len(sys.argv) != 3:
    print("Usage: python convert_json_to_plist.py <input_json_file> <output_plist_file>")
    sys.exit(1)

  input_json_file = sys.argv[1]
  output_plist_file = sys.argv[2]

  convert_json_to_plist(input_json_file, output_plist_file)
