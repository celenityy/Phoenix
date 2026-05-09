import sys

def process_file(input_file, output_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    with open(output_file, 'w') as file:
        for line in lines:
            # The handling of indents here is very hacky... please submit a PR if you have a better solution! :P

            # Check if the line contains "defaultPref("
            if "                defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("                  defaultPref(", "pref(")
                file.write(modified_line)
            elif "              defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("              defaultPref(", "pref(")
                file.write(modified_line)
            elif "          defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("          defaultPref(", "pref(")
                file.write(modified_line)
            elif "        defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("      defaultPref(", "pref(")
                file.write(modified_line)
            elif "    defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("    defaultPref(", "pref(")
                file.write(modified_line)
            elif "  defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("  defaultPref(", "pref(")
                file.write(modified_line)
            elif "defaultPref(" in line and "[FN]" not in line:
                # Change defaultPref to pref
                modified_line = line.replace("defaultPref(", "pref(")
                file.write(modified_line)
            # Check if the line contains "lockPref("
            elif "                  lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("                  lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "              lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("              lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "          lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("          lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "      lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("      lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "    lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("    lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "  lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("  lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            elif "lockPref(" in line and "[FN]" not in line:
                # Change lockPref to pref and add ", locked)"
                modified_line = line.replace("lockPref(", "pref(").replace(")", ", locked)")
                file.write(modified_line)
            # Check if the line contains "pref("
            elif "              pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("              pref(", "pref(")
                file.write(modified_line)
            elif "          pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("          pref(", "pref(")
                file.write(modified_line)
            elif "      pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("      pref(", "pref(")
                file.write(modified_line)
            elif "      pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("      pref(", "pref(")
                file.write(modified_line)
            elif "    pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("    pref(", "pref(")
                file.write(modified_line)
            elif "  pref(" in line and "[FN]" not in line:
                # Remove indent before pref
                modified_line = line.replace("  pref(", "pref(")
                file.write(modified_line)
            elif "pref(" in line and "[FN]" not in line:
                # Leave pref as is
                file.write(line)

# Check if the correct number of arguments is provided
if len(sys.argv) != 3:
    print("Usage: python3 convert-cfg-to-js.py <input.cfg> <output.js>")
    sys.exit(1)

# Get the input and output file names from command line args
input_file = sys.argv[1]
output_file = sys.argv[2]

# Process the file
process_file(input_file, output_file)

print(f"Processed {input_file} and saved to {output_file}.")
