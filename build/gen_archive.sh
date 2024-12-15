#!/bin/bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from this 'archives' folder...

zip -R archives/phoenix.zip 'filter.pac' 'configs/' 'defaults/' 'etc/' 'phoenix.cfg' 'policies/' 'README.md' -x 'build/*' '.git*' '.DS_Store'
