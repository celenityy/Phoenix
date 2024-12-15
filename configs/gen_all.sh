#!/bin/bash

cat phoenix.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/phoenix.cfg

cat phoenix.cfg configs/No-Sync/no-sync-specific.cfg > configs/No-Sync/no-sync.cfg

cat configs/No-Sync/no-sync.cfg configs/Discord/discord-specific.cfg > configs/Discord/discord.cfg

cat configs/Discord/discord.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/discord.cfg

cat configs/No-Sync/no-sync.cfg configs/YouTube/youtube-specific.cfg > configs/YouTube/youtube.cfg

cat configs/YouTube/youtube.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/youtube.cfg

cat configs/No-Sync/no-sync.cfg configs/Twitter/twitter-specific.cfg > configs/Twitter/twitter.cfg

cat configs/Twitter/twitter.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/twitter.cfg

cat phoenix.cfg configs/Hardened/hardened-specific.cfg > configs/Hardened/hardened.cfg

cat configs/Hardened/hardened.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/hardened.cfg

cat configs/No-Sync/no-sync.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/no-sync.cfg

cat configs/Hardened/hardened.cfg configs/No-Sync/no-sync-specific.cfg > configs/Hardened-No-Sync/hardened-no-sync.cfg

cat configs/Hardened-No-Sync/hardened-no-sync.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/hardened-no-sync.cfg

cat configs/Hardened/hardened.cfg configs/Dev/dev-specific.cfg > configs/Dev/dev.cfg

cat configs/Dev/dev.cfg configs/Firefox-UI-Fix/firefox-ui-fix-specific.cfg > configs/Firefox-UI-Fix/dev.cfg