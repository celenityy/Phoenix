- [Enabled CNSA 2.0 post-quantum key agreement](https://codeberg.org/celenity/Phoenix/commit/54eab1f0d4c31c4ed92b356bc4c75017b1b8b137) by default.
- [Enabled disk cache encryption](https://codeberg.org/celenity/Phoenix/commit/8f0fee93c7ede1c2f0dfd97367b31897af1c8a40) by default.
  - We still disable disk cache by default, but this improves privacy and security for users who decide to re-enable it.
- [Updated the add-on blocklist](https://codeberg.org/celenity/Phoenix/commit/f3f8d8ca7b92e0df75848df92428c1a1dc3f16a4).
- [Re-organized preferences related to data collection/telemetry](https://codeberg.org/celenity/Phoenix/commit/cdf6107624c602dcf2a2985567b1a759f9bcfa85).
- [Cleaned up and re-organized the add-on blocklist](https://codeberg.org/celenity/Phoenix/commit/ace3a5c190df34e7a4095f6774292210842e0e05).
- Minor tweaks and adjustments.

### Android-only

- [Removed various GMP-related preferences](https://codeberg.org/celenity/Phoenix/commit/a11b7b20991b486ff7269581d7d2df2953378bdf) that are now unused, as GeckoView no longer includes the relevant components.
- [Removed unused update-related preferences](https://codeberg.org/celenity/Phoenix/commit/b37d49959e5e9b6c3533bb2c210c5f8356778924).
- [Explicitly set `app.update.log` to its default value](https://codeberg.org/celenity/Phoenix/commit/36fcf3f96cf076d71ed3190380e9cee80d57387f) so that it can be found/set from [`about:config`](about:config).

### Desktop-only

- [Disabled Mozilla's newly added **clock**, **crossword**, **"picture of the day"**, **sports**, and **stocks** widgets](https://codeberg.org/celenity/Phoenix/commit/2040e0f3254b14f620315f3ff07e57ccfdd70a3b) by default, but exposed the UI so that users can re-enable them if desired.
- [Disabled display of web notifications on `about:home`](https://codeberg.org/celenity/Phoenix/commit/a8a6a92e50dcf11c418d3d09a6d14c0a11746569) by default, but exposed the UI so that users can re-enable it if desired.
- [Disabled tab group promotions](https://codeberg.org/celenity/Phoenix/commit/270ab97c8e56930d64ef16ce92aed371f69ebbd0).
- **WINDOWS**: [Disabled Firefox `Kit` branding for the default browser button in Windows settings](https://codeberg.org/celenity/Phoenix/commit/b0f9897fe7df3c0b42d32a3f348b724b2c697f3e) by default.

### Specialized configs

- [Re-enabled tooltips for **YouTube** and **YouTube Music**](https://codeberg.org/celenity/Phoenix/commit/ba26a74ec5022829a46aa2118fcc447d4fdd217f) by default.