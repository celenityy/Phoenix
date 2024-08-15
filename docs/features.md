# Features (WIP)

Note that this list is not exhaustive, Phoenix also covers much more that can be seen directly from our cfg files & policies. This is just what's notable.

#### Privacy & Security

* Disables all Mozilla Data Collection & Reporting - Enforces that no data is ever sent

* Removes special privileges from certain Mozilla domains

* Removes tracking parameters from various built-in Mozilla URLs

* Disables Push/Web Notifications

* Disables Search Suggestions/keylogging

* Prevents installed search engines from remotely updating

* Enforces that full URLs are always shown

* Enforces always showing punycode to protect against [IDN Homograph Attacks](https://wikipedia.org/wiki/IDN_homograph_attack)

* Disables autofilling/autocompleting URLs to avoid undesired connections

* Enforces excluding JavaScript from URLbar results

* Disables all network prefetching & speculative connections

* Enforces that single word searches are never leaked to your DNS provider

* Disables middle click on new tab button automatically opening clipboard URLs or searches

* Enables & enforces [HTTPS By Default](https://blog.mozilla.org/security/2021/08/10/firefox-91-introduces-https-by-default-in-private-browsing/) for all windows

* Enables & enforces [HTTPS-Only Mode](https://support.mozilla.org/kb/https-only-prefs) for all windows

* [Blocks & upgrades insecure HTTP mixed content on secure HTTPS webpages](https://support.mozilla.org/kb/mixed-content-blocking-firefox)

* Always warns you when navigating to insecure webpages

* Shows detailed information on insecure warning pages

* Disables TLS1.3 0-RTT [as it is not forward secret](https://github.com/tlswg/tls13-spec/issues/1001)

* Enforces [Intermediate CA Preloading](https://wiki.mozilla.org/Security/CryptoEngineering/Intermediate_Preloading)

* Fully disables downgrading to insecure TLS 1.0/1.1 connections

* Enforces TLS 1.3 downgrade protection

* Enforces only loading secure websockets from HTTPS pages

* Enforces that additional ports are always blocked from accessing the internet

* Enables Post Quantum Key Agreement (Kyber)

* Enforces MITM Detection

* Disables Captive Portal & undesired Connectivity Checks

* Prevents undesired proxy leakage 

* Enables [DNS over HTTPS](https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/) without fallback & sets to [Quad9](https://quad9.net/) by default

* Expands list of built-in DoH providers

* Disables DoH Connectivity Checks

* Prevents disabling DoH from registry checks

* Enforces [EncryptedClientHello](https://blog.cloudflare.com/announcing-encrypted-client-hello)

* Enables native DNS HTTPS Lookups

* Enables & enforces [CRLite Revocation Checks](https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/)

* Enables & enforces [OCSP Revocation Checks](https://wikipedia.org/wiki/Online_Certificate_Status_Protocol) with [Stapling](https://knowledge.digicert.com/quovadis/ssl-certificates/ssl-general-topics/what-is-ocsp-stapling) & [Must-Staple](https://scotthelme.co.uk/ocsp-must-staple/) as a fallback for CRLite

* Makes exceptions for certificate errors session only

* Enables [Strict Public Key Pinning](https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning) to prevent MITM

* Always prompts before downloading files

* Always notifies when downloading files

* Enforces blocking insecure downloads

* Disables sending metadata of downloaded files to Google as part of Safe Browsing

* Enforces that no data from Safe Browsing is ever shared with Google

* Enforces that Wi-Fi Scanning is disabled

* Disables [Browser "Region Updates"](https://firefox-source-docs.mozilla.org/toolkit/modules/toolkit_modules/Region.html) & [Geo Targetting](https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_geolocation-for-default-search-engine)

* Denies websites access to geolocation by default

* Removes Google & Microsoft Geolocation Providers (Hopefully better solution can be found here)

* Hardens WebRTC

* Always sandboxes the [WebRTC Media Transport](https://searchfox.org/mozilla-central/source/security/sandbox/common/SandboxSettings.cpp)

* Disables Search & Form History - [Can be leaked to websites](https://blog.mindedsecurity.com/2011/10/autocompleteagain.html)

* Disables disk caching

* Never stores unnecessary site session data

* Always sanitizes cache, sessions, & form data on exit

* Sanitizes cookies (You can set site exceptions as needed) & history on exit by default

* Disables logging domains blocked through Firefox's Tracking Protection to about:protections

* Always deletes cached files from windows opened with external applications

* Prevents exposing content in the window title for Private Browsing

* When downloads are deleted in Firefox, also removes them from session list & history

* Adds a fire button in Private Browsing Windows to reset sessions

* Disables Firefox automatically starting & restoring sessions after reboot on Windows

* Disables [LaterRun](https://bugzilla.mozilla.org/show_bug.cgi?id=1200639) - [Mechanism that tracks profile creation time & # of uses](https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41568)

* Disables coloring visited links

* Disables collecting & generating background thumbnails of webpages

* Enforces only allowing extensions signed by Mozilla

* Enforces Mozilla's [Extension Blocklist](https://wiki.mozilla.org/Extension_Blocklisting) & includes our own blocklist of questionable/malicious/undesired extensions from the AMO

* Only allows installing extensions from the [AMO](https://addons.mozilla.org/) (With exceptions for [Mullvad's browser extension](https://mullvad.net/help/mullvad-browser-extension), [Bypass Paywalls Clean](https://gitflic.ru/project/magnolia1234/bypass-paywalls-firefox-clean), & [Query AMO ID](https://github.com/mkaply/queryamoid))

* Installs, enforces, & configures [uBlock Origin](https://github.com/gorhill/uBlock)

* Disables bypassing 3rd party extension installation prompts

* By default, allows [LocalCDN](https://www.localcdn.org/) & [Mullvad's browser extension](https://mullvad.net/help/mullvad-browser-extension) to run on quarantined domains

* Disables JavaScript in PDF.js

* Opens PDFs inline & in browser where possible by default

* Enforces using US English as locale by default to protect against fingerprinting

* Enables rounding of window sizes to protect against fingerprinting

* Always disables [WebGPU](https://browserleaks.com/webgpu)

* Enforces that if WebGL is disabled, it should stay disabled

* Prevents use of system colors to protect against fingerprinting

* Enforces use of a standard cross-platform widget theme to protect against fingerprinting

* Enables & enforces Firefox's [Strict Enhanced Tracking Protection](https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_strict-enhanced-tracking-protection)

* Always enables & enforces [Do Not Track](https://wikipedia.org/wiki/Do_Not_Track) & [Global Privacy Control](https://globalprivacycontrol.org/)

* Disables ["Privacy Preserving Attribution"](https://support.mozilla.org/kb/privacy-preserving-attribution)

* Enables trimming cross-origin referers (like Safari)

* Restricts referers for trackers

* Ensures that [Hyperlink Auditing](https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/) is always disabled

* Improves Firefox's built in query stripping to be on par with Brave & LibreWolf

* Disables autofilling passwords on websites

* Enables [alerts for breached & vulnerable passwords](https://support.mozilla.org/kb/mozilla-monitor-faq) by default, as it is harmless and [never exposes sensitive data to Mozilla](https://blog.mozilla.org/security/2018/06/25/scanning-breached-accounts-k-anonymity/)

* Enables strong password generation by default

* Prevents cross-origin sub-resources from opening HTTP authentication dialogs

* Disables Windows SSO

* Disallows [Negotiate Authentication](https://people.redhat.com/mikeb/negotiate/) by default

* Enforces crashing on insecure password input

* Enforces [protection against password spoofing for cross-domain auth requests](https://bugzilla.mozilla.org/show_bug.cgi?id=791594)

* Disables [JavaScript Just-in-time Compilation (JIT)](https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/)

* Disables [ASM.JS](https://rh0dev.github.io/blog/2017/the-return-of-the-jit/)

* Disables [MathML](https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml)

* Disables [Graphite](https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite) & [SVG OpenType](https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg) fonts

* Disables [WebXR](https://developer.mozilla.org/docs/Web/API/WebXR_Device_API)

* Disables [Accessibility Services](https://support.mozilla.org/kb/accessibility-services#w_malware-and-adware)

* Ensures that [Content Analysis](https://github.com/chromium/content_analysis_sdk) is always disabled

* Enforces Site Isolation & isolates all websites

* Enables [GPU Sandboxing](https://www.ghacks.net/2023/01/17/firefox-110-will-launch-with-gpu-sandboxing-on-windows/)

* Disables [GNOME Integration](https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp)

* Enables protection against [CSRF Attacks](https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions)

* Enforces sandboxing [Gecko Media Plugins](https://wiki.mozilla.org/GeckoMediaPlugins)

* Fully removes & disables [DRM technology](https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next)

* Enables automatic browser updates by default on macOS & Windows

* Immediately shows a badge on the hamburger menu when a browser update is available by default

* Notifies users when an update is being downloaded by default

* Enforces extension updates

* Disables Remote Debugging features

* Enforces that URLs are never logged in Reader errors

* Enables [Containers](https://support.mozilla.org/kb/how-use-firefox-containers) & isolates site permissions per container

* Enables Mozilla's new UI for switching & managing browser profiles

* Forces pop-ups to open in new tabs instead of new windows

* Always blocks pop-ups by default

* Reduces events that can cause pop-ups

* Prevents scripts from moving, resizing, & messing with windows

* Disables [OpenH264](https://wikipedia.org/wiki/OpenH264) by default

* Locks various prefs that actively harm privacy rather than improve it

#### Misc.

* Disables Mozilla [Feature/Extension Recommendations](https://support.mozilla.org/kb/recommendations-firefox) & [Discovery](https://support.mozilla.org/kb/personalized-extension-recommendations)

* Disables [Fakespot](https://www.fakespot.com/) Integration

* Disables [Pocket](https://getpocket.com/) Integration

* Disables [Firefox Relay](https://relay.firefox.com/) Integration

* Disables "Top Sites"

* Disables all sponsored content

* Disables ["Firefox Suggest"](https://mozilla-services.github.io/merino/firefox.html)

* Removes all Mozilla Promotions & Advertising

* Disables Mozilla Onboarding & about:welcome

* Disables "UI Tour" & various other "feature tours"

* Enables adding custom search engines in about:preferences#search

* Allows using a different search engine in Private Windows vs. Normal Windows

* Enables Bookmark, Calculator, Open Page, & Unit Conversion URLbar suggestions by default

* Disables Clipboard, Search Engines, & History URLbar suggestions by default

* Enables suggestions when an HTTPS page can't be found

* Disallows PDFs from preventing copying of text

* Disables checking if Firefox is the default Browser

* Disables checking if PDF.js is the default PDF Viewer

* Enables showing sidebar/table of contents by default when opening PDFs

* Always allows showing passwords when hidden

* Disallows websites from dictating whether to allow filling passwords

* Disables [password truncation](https://www.ghacks.net/2020/05/18/firefox-77-wont-truncate-text-exceeding-max-length-to-address-password-pasting-issues/)

* [Enables Cookie Banner Reduction](https://support.mozilla.org/kb/cookie-banner-reduction) by default

* Enables various performance tweaks from [Fastfox](https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js)

* Enables smooth scrolling by default & enforces with prefs from [Smoothfox](https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js)

* Enables support for custom CSS

* Automatically exports bookmarks to HTML by default

* Enables the ability to toggle [Compact Mode](https://support.mozilla.org/kb/compact-mode-workaround-firefox) if desired

* Enables viewing image info from the context menu

* Enables wallpaper support on about:home

* Enables settings UI for toggling experimental features (about:preferences#experimental)

* Prevents Private Windows separating from regular browsing windows on Windows by default

* Opens searches & webpages navigated to from the URLbar in new tabs by default

* Opens bookmarks in new tabs by default

* Disables annoying "Tab Manager" drop-down option on top right unless actually needed

* Enables wrapping text in the debugger by default

* Enables Firefox's On-Device [Translations](https://support.mozilla.org/kb/website-translation) feature by default

* Automatically translates all supported languages by default

* Highlights all matching findbar results by default

* Disables prompting to use Firefox as your mailto handler by default

* Adds support for more granular page zooming

* Prevents websites from hijacking browser shortcuts

* Enables some nice-to-have devtool features