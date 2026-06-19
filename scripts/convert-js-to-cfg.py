import sys

def process_file(input_file, output_file):
  with open(input_file, 'r') as file:
    lines = file.readlines()

  with open(output_file, 'w') as file:
    for line in lines:
      # Check if the line contains "pref("
      if "pref(" in line:
        # Check if the line contains ", locked" or ", sticky"
        if ", locked" in line:
          # Change pref to lockPref and remove ", locked"
          modified_line = line.replace("pref(", "lockPref(").replace(", locked", "")
        elif ", sticky" in line:
          # Leave pref as is and remove ", sticky"
          modified_line = line.replace(", sticky", "")
        else:
          # Change pref to defaultPref
          modified_line = line.replace("pref(", "defaultPref(")

          # Write the modified line
          file.write(modified_line)
      else:
          # Leave the line unchanged (ex. for comments)
          file.write(line)

# Check if the correct number of arguments is provided
if len(sys.argv) != 3:
  print("Usage: python3 convert-js-to-cfg.py <input.js> <output.cfg>")
  sys.exit(1)

# Get the input and output file names from command line args
input_file = sys.argv[1]
output_file = sys.argv[2]

# Process the file
process_file(input_file, output_file)

print(f"Processed {input_file} and saved to {output_file}.")
