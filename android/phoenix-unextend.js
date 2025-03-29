//
// Unextend Phoenix...

// By default, IronFox uses Phoenix's 'Extended' Hardening config. This will cause breakage, and may not be desirable for everyone.
// So this exists to easily revert IronFox to use Phoenix's standard 'base'/recommended config instead.

// 001 ADVANCED FINGERPRINTING PROTECTION

/// Set FPP to only cover our default targets

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC");

/// Enable WebGL
// https://blog.browserscan.net/docs/webgl-fingerprinting
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern

pref("webgl.disabled", false);

pref("browser.phoenix.unextend.001.applied", true);

/// 002 WEBRTC

pref("media.peerconnection.ice.default_address_only", false);
pref("media.peerconnection.ice.no_host", false);
pref("media.peerconnection.ice.relay_only", false);

pref("browser.phoenix.unextend.002.applied", true);

// 003 MISC. PRIVACY

/// Always send cross-origin referers

pref("network.http.referer.XOriginPolicy", 0);

pref("browser.phoenix.unextend.003.applied", true);

// 004 ATTACK SURFACE REDUCTION

/// Enable WebAssembly
// https://spectrum.ieee.org/more-worries-over-the-security-of-web-assembly

pref("javascript.options.wasm", true);

pref("browser.phoenix.unextend.004.applied", true);

// 005 MISC.

/// Standard Autoplay Blocking

pref("media.autoplay.blocking_policy", 0); // [Default = 0]

pref("browser.phoenix.unextend.005.applied", true);

pref("browser.phoenix.unextend.applied", true);
