#!/bin/bash

cat configs/hardened.cfg configs/ui-fix.cfg > configs/ui-fix/hardened.cfg

cat configs/no-sync.cfg configs/ui-fix.cfg > configs/ui-fix/no-sync.cfg

cat configs/no-sync.cfg configs/hardened.cfg > configs/hardened-no-sync.cfg

cat configs/hardened-no-sync.cfg configs/ui-fix.cfg > configs/ui-fix/hardened-no-sync.cfg

cat configs/hardened-no-sync.cfg build/configs/specialized-spec.cfg > build/configs/specialized-core.cfg

cat build/configs/specialized-core.cfg build/configs/discord-spec.cfg > configs/discord.cfg

cat configs/discord.cfg configs/ui-fix.cfg > configs/ui-fix/discord.cfg

cat build/configs/specialized-core.cfg build/configs/element-spec.cfg > configs/element.cfg

cat configs/element.cfg configs/ui-fix.cfg > configs/ui-fix/element.cfg

cat build/configs/specialized-core.cfg build/configs/youtube-spec.cfg > configs/youtube.cfg

cat configs/youtube.cfg configs/ui-fix.cfg > configs/ui-fix/youtube.cfg

cat build/configs/specialized-core.cfg build/configs/twitter-spec.cfg > configs/twitter.cfg

cat configs/twitter.cfg configs/ui-fix.cfg > configs/ui-fix/twitter.cfg
