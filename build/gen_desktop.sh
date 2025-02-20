#!/bin/bash

cat build/prefs/phoenix-core.js build/prefs/phoenix-desktop-common.js build/prefs/phoenix-desktop.js > prefs/phoenix-desktop.js

python3 build/convert.py prefs/phoenix-desktop.js phoenix.cfg

cat build/prefs/extended/phoenix-extended-core.js build/prefs/extended/phoenix-extended-desktop-common.js build/prefs/extended/phoenix-extended-desktop.js > prefs/phoenix-extended-desktop.js

python3 build/convert.py prefs/phoenix-extended-desktop.js build/configs/hardened-temp.cfg

awk '!/NO-SPEC/' phoenix.cfg > build/configs/spec-temp.cfg

cat build/configs/spec-temp.cfg build/configs/hardened-temp.cfg > configs/hardened.cfg

rm build/configs/hardened-temp.cfg build/configs/spec-temp.cfg

cat configs/hardened.cfg configs/ui-fix.cfg > configs/ui-fix/hardened.cfg

cat configs/hardened.cfg build/configs/specialized-spec.cfg build/configs/discord-spec.cfg > configs/discord.cfg

cat configs/discord.cfg configs/ui-fix.cfg > configs/ui-fix/discord.cfg

cat configs/hardened.cfg build/configs/specialized-spec.cfg build/configs/element-spec.cfg > configs/element.cfg

cat configs/element.cfg configs/ui-fix.cfg > configs/ui-fix/element.cfg

cat configs/hardened.cfg build/configs/specialized-spec.cfg build/configs/youtube-spec.cfg > configs/youtube.cfg

cat configs/youtube.cfg configs/ui-fix.cfg > configs/ui-fix/youtube.cfg

cat configs/hardened.cfg build/configs/specialized-spec.cfg build/configs/twitter-spec.cfg > configs/twitter.cfg

cat configs/twitter.cfg configs/ui-fix.cfg > configs/ui-fix/twitter.cfg

awk '!/NO-OSX/' phoenix.cfg > macos/phoenix.cfg
