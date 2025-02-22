#!/bin/bash

python3 build/convert.py prefs/phoenix-desktop.js build/configs/phoenix-spec.cfg

cat build/configs/phoenix-spec.cfg configs/hardened.cfg > configs/macos/hardened.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix.cfg > configs/macos/ui-fix.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/hardened.cfg > configs/macos/ui-fix/hardened.cfg

cat build/configs/phoenix-spec.cfg configs/apple-maps.cfg > configs/macos/apple-maps.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/apple-maps.cfg > configs/macos/ui-fix/apple-maps.cfg

cat build/configs/phoenix-spec.cfg configs/discord.cfg > configs/macos/discord.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/discord.cfg > configs/macos/ui-fix/discord.cfg

cat build/configs/phoenix-spec.cfg configs/element.cfg > configs/macos/element.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/element.cfg > configs/macos/ui-fix/element.cfg

cat build/configs/phoenix-spec.cfg configs/google-maps.cfg > configs/macos/google-maps.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/google-maps.cfg > configs/macos/ui-fix/google-maps.cfg

cat build/configs/phoenix-spec.cfg configs/twitter.cfg > configs/macos/twitter.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/twitter.cfg > configs/macos/ui-fix/twitter.cfg

cat build/configs/phoenix-spec.cfg configs/youtube.cfg > configs/macos/youtube.cfg

cat build/configs/phoenix-spec.cfg configs/ui-fix/youtube.cfg > configs/macos/ui-fix/youtube.cfg
