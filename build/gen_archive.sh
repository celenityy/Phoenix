#!/bin/bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

rm archives/phoenix.zip

zip -R archives/phoenix.zip 'filter.pac' 'configs/*' 'configs/ui-fix/*' 'etc/*' 'etc/profile.d/*' 'phoenix.cfg' 'policies.json' 'personal-policies/*' 'prefs/*' 'userjs/*' 'userjs/linux/*' 'userjs/linux/dev/*' 'userjs/linux/discord/*' 'userjs/linux/element/*' 'userjs/linux/hardened/*' 'userjs/linux/hardened-no-sync/*' 'userjs/linux/no-sync/*' 'userjs/linux/twitter/*' 'userjs/linux/ui-fix-base/*' 'userjs/linux/youtube/*' 'userjs/linux/ui-fix/dev/*' 'userjs/linux/ui-fix/discord/*' 'userjs/linux/ui-fix/element/*' 'userjs/linux/ui-fix/hardened/*' 'userjs/linux/ui-fix/hardened-no-sync/*' 'userjs/linux/ui-fix/no-sync/*' 'userjs/linux/ui-fix/twitter/*' 'userjs/linux/ui-fix/youtube/*' 'userjs/macos/*' 'userjs/macos/dev/*' 'userjs/macos/discord/*' 'userjs/macos/element/*' 'userjs/macos/hardened/*' 'userjs/macos/hardened-no-sync/*' 'userjs/macos/no-sync/*' 'userjs/macos/twitter/*' 'userjs/macos/ui-fix-base/*' 'userjs/macos/youtube/*' 'userjs/macos/ui-fix/dev/*' 'userjs/macos/ui-fix/discord/*' 'userjs/macos/ui-fix/element/*' 'userjs/macos/ui-fix/hardened/*' 'userjs/macos/ui-fix/hardened-no-sync/*' 'userjs/macos/ui-fix/no-sync/*' 'userjs/macos/ui-fix/twitter/*' 'userjs/macos/ui-fix/youtube/*' 'README.md' -x 'build/*' 'legacy/*' '.git*' '.DS_Store'
