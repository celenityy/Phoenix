#!/bin/bash

cat configs/no-sync.cfg build/configs/discord-spec.cfg > configs/discord.cfg

cat configs/discord.cfg configs/ui-fix.cfg > configs/ui-fix/discord.cfg

cat configs/no-sync.cfg build/configs/youtube-spec.cfg > configs/youtube.cfg

cat configs/youtube.cfg configs/ui-fix.cfg > configs/ui-fix/youtube.cfg

cat configs/no-sync.cfg build/configs/twitter-spec.cfg > configs/twitter.cfg

cat configs/twitter.cfg configs/ui-fix.cfg > configs/ui-fix/twitter.cfg

cat configs/hardened.cfg configs/ui-fix.cfg > configs/ui-fix/hardened.cfg

cat configs/no-sync.cfg configs/ui-fix.cfg > configs/ui-fix/no-sync.cfg

cat configs/no-sync.cfg configs/hardened.cfg > configs/hardened-no-sync.cfg

cat configs/hardened-no-sync.cfg configs/ui-fix.cfg > configs/ui-fix/hardened-no-sync.cfg

cat configs/hardened.cfg build/configs/dev-spec.cfg > configs/dev.cfg

cat configs/dev.cfg configs/ui-fix.cfg > configs/ui-fix/dev.cfg
