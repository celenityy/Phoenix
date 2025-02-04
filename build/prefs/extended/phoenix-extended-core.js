//

// This file contains preferences shared across Phoenix 'Extended' configs.

// 001 ADVANCED FINGERPRINTING PROTECTION

/// Disable WebGL
// https://blog.browserscan.net/docs/webgl-fingerprinting
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern

pref("webgl.disabled", true);

pref("browser.phoenix.extended.core.status", "001");

// 002 WEBRTC
// This will likely break WebRTC...

/// Force a single candidate for ICE generation
pref("media.peerconnection.ice.default_address_only", true);

/// Forcefully exclude local IP addresses, even in trusted scenarios
pref("media.peerconnection.ice.no_host", true);

/// Only use TURN servers/relays, no p2p...
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/40#note_2884663
pref("media.peerconnection.ice.relay_only", true);

pref("browser.phoenix.extended.core.status", "002");

// 003 MISC. PRIVACY

/// Disable TCP/dFPI storage access heuristics
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics

pref("privacy.restrict3rdpartystorage.heuristic.opened_window_after_interaction", false);
pref("privacy.restrict3rdpartystorage.heuristic.recently_visited", false);
pref("privacy.restrict3rdpartystorage.heuristic.redirect", false); // [DEFAULT - Android]
pref("privacy.restrict3rdpartystorage.heuristic.window_open", false); // [DEFAULT - Android]

/// Only send cross-origin referers if hosts match

pref("network.http.referer.XOriginPolicy", 2);

pref("browser.phoenix.extended.core.status", "003");

// 004 ATTACK SURFACE REDUCTION

/// Disable WebAssembly
// https://spectrum.ieee.org/more-worries-over-the-security-of-web-assembly

pref("javascript.options.wasm", false);

pref("browser.phoenix.extended.core.status", "004");

// 005 MISC.

/// Prevent sites from automatically refreshing

pref("accessibility.blockautorefresh", true);
pref("browser.meta_refresh_when_inactive.disabled", true); // [DEFAULT - Android]

/// Stricter Autoplay Blocking

pref("media.autoplay.blocking_policy", 2); // [Default = 0]

pref("browser.phoenix.extended.core.status", "005");

pref("browser.phoenix.extended.core.status", "successfully applied :D", locked);

