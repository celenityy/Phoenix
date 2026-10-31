- Switched the default DNS over HTTPS back to [Quad9](https://quad9.net/), due to them now meeting our criteria *(as well as the discontinuation of our current default provider, Mullvad)*.
- [Blocked Local Network Access requests from insecure origins](https://codeberg.org/celenity/Phoenix/commit/3fb64456fbd24a2c7d2f7582fad95d02511894c0) by default.
- [If captive portal detection/connectivity checks are enabled, we now use our servers *(`captive.celenity.dev`)*](https://codeberg.org/celenity/Phoenix/commit/769046ce9698799e554ff2ec05bd9b029646179f) by default, instead of Mozilla's.
  - We also now use `HTTPS` for connectivity checks if they are enabled *(though captive portal detection itself is still performed over standard `HTTP`, as it must be for them to work properly)*.
  - We still disable captive portal detection and connectivity checks by default and don't recommend enabling them, this is simply for users who do wish to re-enable them at their own risk/discretion.
- [Fixed an issue that prevented `about:home` from loading properly for some users](https://codeberg.org/celenity/Phoenix/commit/444e9534f2388725b47a1661a6646068a47542de) on `159.0` and newer.
- [Disabled DoH auto-bootstrap by default for now](https://codeberg.org/celenity/Phoenix/commit/5b530cb58c95fc27961e815a7bd703cc19fd319d), as [it unfortunately breaks ex. IPv6-only networks](https://codeberg.org/celenity/bugs/issues/589).
  - The feature can still be enabled though if desired, by setting `browser.phoenix.trr.autoBootstrap` to `true` at [`about:config`](about:config).
- If DoH auto-bootstrap is enabled, [`1.0.0.1` is now always used for Cloudflare *(instead of just as a fall-back)*](https://codeberg.org/celenity/Phoenix/commit/975544d257cda5eddae9171bfc6ab18e4d0bd445), to [improve compatibility and resolve issues with certain networks](https://codeberg.org/celenity/Phoenix/commit/975544d257cda5eddae9171bfc6ab18e4d0bd445).
- [Disabled PDF.js feature promotions](https://codeberg.org/celenity/Phoenix/commit/1ce5ba5f00e07a5101e29bdfb8d5e2955e4c2d99).
- [Disabled Mozilla's newly-added private browsing mode intro animation](https://codeberg.org/celenity/Phoenix/commit/270949d2caa12b0ee7a212239ba9449c1f434be0).
- [Prevented storage of telemetry pings *(via `telemetry.fog.enable_store_submitted_pings`)*](https://codeberg.org/celenity/Phoenix/commit/bf86c3d96e5ceee074e546c6cd302a33e2c21fa4).
- Other minor tweaks, fixes, and enhancements.

### Desktop-only

- [Removed Firefox Multi-Account Containers](https://codeberg.org/celenity/Phoenix/commit/7a9f0e51be171a7bec6538ea5dbb9e544693a64d), as its functionality is now built-in to Firefox.
- [Disabled Firefox/Mozilla branding elements at `about:neterror`](https://codeberg.org/celenity/Phoenix/commit/b399cef80e43deed7874a54bf0dc6d926cd0473b) by default.
- [Disabled Firefox Sync promotions](https://codeberg.org/celenity/Phoenix/commit/cea18e6dba7e63ce4c9799ca4e101579a2dad02b).
- [Added a new preference to disable the Mozilla Ad Routing Service *(MARS)* Ad Client](https://codeberg.org/celenity/Phoenix/commit/c81b5219791c8ce7c06bd18f6b728a24fac5dcec).