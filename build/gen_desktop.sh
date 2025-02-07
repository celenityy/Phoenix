#!/bin/bash

cat build/prefs/phoenix-core.js build/prefs/phoenix-desktop-common.js build/prefs/phoenix-desktop.js > prefs/phoenix-desktop.js

python3 build/convert.py prefs/phoenix-desktop.js phoenix.cfg

cat build/prefs/extended/phoenix-extended-core.js build/prefs/extended/phoenix-extended-desktop-common.js build/prefs/extended/phoenix-extended-desktop.js > prefs/phoenix-extended-desktop.js

python3 build/convert.py prefs/phoenix-extended-desktop.js configs/extended.cfg

cat configs/extended.cfg configs/ui-fix.cfg > configs/ui-fix/extended.cfg

cat build/configs/specialized-spec.cfg build/configs/discord-spec.cfg > configs/discord.cfg

cat configs/discord.cfg configs/ui-fix.cfg > configs/ui-fix/discord.cfg

cat build/configs/specialized-spec.cfg build/configs/element-spec.cfg > configs/element.cfg

cat configs/element.cfg configs/ui-fix.cfg > configs/ui-fix/element.cfg

cat build/configs/specialized-spec.cfg build/configs/youtube-spec.cfg > configs/youtube.cfg

cat configs/youtube.cfg configs/ui-fix.cfg > configs/ui-fix/youtube.cfg

cat build/configs/specialized-spec.cfg build/configs/twitter-spec.cfg > configs/twitter.cfg

cat configs/twitter.cfg configs/ui-fix.cfg > configs/ui-fix/twitter.cfg
