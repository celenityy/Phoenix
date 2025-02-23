#!/usr/bin/env bash

awk '!/NO-OSX/' configs/phoenix.cfg > macos/phoenix.cfg

cat macos/phoenix.cfg configs/hardened.cfg > configs/macos/hardened.cfg

cat macos/phoenix.cfg configs/ui-fix.cfg > configs/macos/ui-fix.cfg

cat macos/phoenix.cfg configs/ui-fix/hardened.cfg > configs/macos/ui-fix/hardened.cfg

cat macos/phoenix.cfg configs/apple-maps.cfg > configs/macos/apple-maps.cfg

cat macos/phoenix.cfg configs/ui-fix/apple-maps.cfg > configs/macos/ui-fix/apple-maps.cfg

cat macos/phoenix.cfg configs/discord.cfg > configs/macos/discord.cfg

cat macos/phoenix.cfg configs/ui-fix/discord.cfg > configs/macos/ui-fix/discord.cfg

cat macos/phoenix.cfg configs/element.cfg > configs/macos/element.cfg

cat macos/phoenix.cfg configs/ui-fix/element.cfg > configs/macos/ui-fix/element.cfg

cat macos/phoenix.cfg configs/google-maps.cfg > configs/macos/google-maps.cfg

cat macos/phoenix.cfg configs/ui-fix/google-maps.cfg > configs/macos/ui-fix/google-maps.cfg

cat macos/phoenix.cfg configs/twitter.cfg > configs/macos/twitter.cfg

cat macos/phoenix.cfg configs/ui-fix/twitter.cfg > configs/macos/ui-fix/twitter.cfg

cat macos/phoenix.cfg configs/youtube.cfg > configs/macos/youtube.cfg

cat macos/phoenix.cfg configs/ui-fix/youtube.cfg > configs/macos/ui-fix/youtube.cfg
