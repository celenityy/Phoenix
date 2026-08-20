# 🤖 Android

List of features for Phoenix's **Android** configuration.

**Note that this will not cover features already detailed on the standard `Features` page [here](./features.md). This page is ONLY focused on deviations.**

## Fingerprinting

Phoenix for Android enables a *slightly different* set of protections *([targets](https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc))* for [FPP](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters) than Phoenix for desktop. **These differences are as follows:**

- Phoenix for Android **doesn't** block first-party canvas data extraction *(`-CanvasImageExtractionPrompt`)*, due to prompts unfortunately not being supported on Android. **Third parties are still blocked from extracting canvas data, and canvas data is still randomized when extracted.**

- Phoenix **Extended** for Android also disables [WebGL](https://blog.browserscan.net/docs/webgl-fingerprinting) *(On Desktop, regardless of Phoenix configuration, WebGL is always blocked by default via uBlock Origin. We can't control uBlock Origin on Android though, so we take this measure to disable it globally)*.

## Enhancements

* Phoenix for Android includes its own set of granular overrides to unbreak websites with [FPP](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters) *(via `privacy.fingerprintingProtection.granularOverrides`)* by default.
