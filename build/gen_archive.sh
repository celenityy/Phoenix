#!/bin/bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

rm archives/phoenix.zip

zip -R archives/phoenix.zip 'configs/*' 'configs/ui-fix/*' 'etc/*' 'etc/profile.d/*' 'phoenix.cfg' 'policies.json' 'prefs/*' 'userjs/*' 'userjs/linux/*' 'userjs/linux/dev/*' 'userjs/linux/discord/*' 'userjs/linux/element/*' 'userjs/linux/extended/*' 'userjs/linux/twitter/*' 'userjs/linux/ui-fix-base/*' 'userjs/linux/youtube/*' 'userjs/linux/ui-fix/dev/*' 'userjs/linux/ui-fix/discord/*' 'userjs/linux/ui-fix/element/*' 'userjs/linux/ui-fix/extended/*' 'userjs/linux/ui-fix/twitter/*' 'userjs/linux/ui-fix/youtube/*' 'userjs/macos/*' 'userjs/macos/dev/*' 'userjs/macos/discord/*' 'userjs/macos/element/*' 'userjs/macos/extended/*' 'userjs/macos/twitter/*' 'userjs/macos/ui-fix-base/*' 'userjs/macos/youtube/*' 'userjs/macos/ui-fix/dev/*' 'userjs/macos/ui-fix/discord/*' 'userjs/macos/ui-fix/element/*' 'userjs/macos/ui-fix/extended/*' 'userjs/macos/ui-fix/twitter/*' 'userjs/macos/ui-fix/youtube/*' 'COPYING' 'README.md' -x 'build/*' '.code-workspace' '.domains' '.DS_Store' '.git*' 'gitlab-ci.yml' 'legacy/*' '_redirects'
