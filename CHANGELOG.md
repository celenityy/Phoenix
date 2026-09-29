**IMPORTANT**: We've officially migrated our issue tracker [to a new, unified one on Codeberg](https://codeberg.org/celenity/bugs/issues). **Please note that issues will no longer be accepted on GitHub, GitLab or in any repo outside of [the new unified Codeberg issue tracking repo](https://codeberg.org/celenity/bugs/issues))**.

- [Disabled AI Speech Recognition](https://codeberg.org/celenity/Phoenix/commit/7f3aea6198b35e373bb5494f8b4d30c31c44e1f5) by default.
- [Enabled the `ML-DSA` post-quantum signature scheme](https://codeberg.org/celenity/Phoenix/commit/7c57de37695fa83d33887e880510ca9b9ad25e66) by default.
- [Enforced Safe Browsing in all contexts](https://codeberg.org/celenity/Phoenix/commit/d75940bcad7fcd1ed74ec7eb7290199ff92ea916) by default *(so that checks are also applied to iframes, in addition to top-level channels)*.
- Other minor tweaks, fixes, and refinements.

### Desktop-only

- **LINUX**: [Disabled Geoclue](https://codeberg.org/celenity/Phoenix/commit/38aee4a0e2e9f5451aa293d5d7295ceeecbdb6e8) by default *(to reduce our reliance on OS-provided/external services, in favor of the browser's built-in network geolocation provider)*.
- **non-OS X**: [Explicitly enabled the network geolocation provider](https://codeberg.org/celenity/Phoenix/commit/c945258738ecd1a2ec54de9a4ccf59310d9d3d46) by default, to ensure that it's properly enabled, instead of just relying on the fall-back/testing provider.
- Added [DNSBunker](https://codeberg.org/celenity/Phoenix/commit/196846d3fd9f2153c01b099dde0f9f59bbe89b58) and [`dnsforge.de`](https://codeberg.org/celenity/Phoenix/commit/f3485c46b49ae6a43db0a403d5de646de59ec0c0) to the list of built-in DNS over HTTPS providers.
- [Disabled fetching GMP plug-ins from Chromium servers](https://codeberg.org/celenity/Phoenix/commit/6254c888c6901472277ed94680bb797a57c62d09) *(if GMP is enabled)* to prevent additional unnecessary connections to Mozilla.
- [Disabled the Remote Settings-backed new tab renderer](https://codeberg.org/celenity/Phoenix/commit/f54634ac5f4d4141bdcc7b776290af0382afe06e).
  - This also fixes an issue that caused favicons to not display properly on `about:home` for some users.
- [Disabled reliance on OS location services/system permission for geolocation](https://codeberg.org/celenity/Phoenix/commit/c29e383f5201f96ebf1c90e05253f5ca62cf9aab), so that the network geolocation provider can always fall-back/work properly as expected.
- [Prevented the browser from automatically downloading tab group AI models](https://codeberg.org/celenity/Phoenix/commit/c7a7373a4e6aae3d8a3e725bc1970a25d7d273bd) *(if the relevant functionality is enabled)*.
- [Set Firefox Sync to use a generic default device name](https://codeberg.org/celenity/Phoenix/commit/7b9fc7e4678b1d1d625640f56709d0d4fd5a3e3d) to avoid leaking the username and device hostname/model to Mozilla *(as well as whether a user is using a fork)*.
- [Disabled recent search widgets on `about:home`](https://codeberg.org/celenity/Phoenix/commit/a22131468a39a5ca232a5690215864035180f3df) by default, but enabled the UI to allow users to enable them if desired.
- [Enabled the ability to control media playback speed for media in Picture-in-Picture windows](https://codeberg.org/celenity/Phoenix/commit/c667742fe2c9c5a6f8879ce34f6de9743221c68b) by default.
- [The new Unified Trust Panel is now only disabled on ESR](https://codeberg.org/celenity/Phoenix/commit/dd878edfde702d6242d0d06a3c56fabb971324c9), due to the removal of Firefox's cookie banner blocker on release.
- [Disabled newly-added Firefox Sync client info ping/telemetry](https://codeberg.org/celenity/Phoenix/commit/2dfa96f0849b81d1562ebd9fdc1079ee8be5ab45).
- [Disabled Mozilla VPN promotional messaging on `about:home`](https://codeberg.org/celenity/Phoenix/commit/5c7da79df68b16194b02407a2498bf802e26c1b8).

### Specialized configs

- [Disabled search actions](https://codeberg.org/celenity/Phoenix/commit/6db4e297aa86392cd23a46c9a03f22a1e5330b30).
- [Disabled URL bar mentions](https://codeberg.org/celenity/Phoenix/commit/7b19b0c7d451bf9da013d67ec9f0305f5bfb2847).