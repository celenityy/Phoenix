# ✨ Extended

List of features for Phoenix's **Extended** configuration.

**Note that this will not cover features already detailed on the standard `Features` page [here](Features.md). This page is ONLY focused on deviations**.

**For features specific to `Android` configurations of Phoenix, please see [here](Android.md)**.

## Privacy

- Disables cross-origin referers unless the hosts match
- Disables [Total Cookie Protection (dFPI)](https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/) [storage access heuristics](https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics)
- Forcefully excludes local IP addresses from WebRTC, even in trusted scenarios
- Forces a single candidate for WebRTC ICE generation
- Requires [the use of TURN servers/relays](https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/40#note_2884663) for WebRTC

### Fingerprinting

**Extended** alters the set of protections *([targets](https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc))* for [FPP](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters) from Phoenix's standard config to:

- Spoof the timezone to `UTC-0` by default *(`+JSDateTimeUTC`)*

To combat fingerprinting, **Extended** also:

- Disables [WebGL](https://blog.browserscan.net/docs/webgl-fingerprinting)
- Enables [dynamic rounding of content dimensions](https://bugzilla.mozilla.org/show_bug.cgi?id=1407366)

## Security

- Disables [WebAssembly (WASM)](https://spectrum.ieee.org/more-worries-over-the-security-of-web-assembly)

## Enhancements

- Enables stricter blocking of [media autoplay](https://support.mozilla.org/kb/block-autoplay) by default
- Prevents websites from automatically refreshing
