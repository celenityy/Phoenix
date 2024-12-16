#!/bin/bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from this 'archives' folder...

rm archives/phoenix.zip

zip -R archives/phoenix.zip 'filter.pac' 'configs/*' 'configs/ui-fix/*' 'defaults/*' 'defaults/pref/*' 'etc/*' 'etc/profile.d/*' 'phoenix.cfg' 'policies.json' 'personal-policies/*' 'README.md' -x 'build/*' 'legacy/*' '.git*' '.DS_Store'
