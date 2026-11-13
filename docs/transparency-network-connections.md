# Network Connections

*See also: [Privacy Notice](./transparency-privacy-notice)*.

Phoenix goes to great lengths to disable non-essential services and minimize network activity. That being said, it does retain connections
required for essential functionality.

This page serves to document connections commonly made by your browser with Phoenix installed.

It explains the purpose of each connection, what data is shared, and how to disable *(or override if applicable)* the connection if desired.

Connections are divided into two sections:
- **Default**: Connections that your browser with Phoenix makes by default, out of the box.
- **Additional**: Non-standard connections that your browser with Phoenix *might* make, depending on your settings/configuration and environment.

## Table of Contents

- [Default](#default)
  - [DNS over HTTPS](#dns-over-https)
  - [Safe Browsing](#safe-browsing)
  - [Tracking Protection](#tracking-protection)
  - [uBlock Origin](#ublock-origin)
  - [Tracking Protection Exceptions](#tracking-protection-exceptions)
  - [Add-on Blocklists](#add-on-blocklists)
  - [Add-on Updates](#add-on-updates)
  - [Application Update Service](#application-update-service) *(Desktop)*
  - [Certificate Transparency Logs](#certificate-transparency-logs)
  - [CRLite](#crlite)
  - [Fingerprinting Protection Overrides](#fingerprinting-protection-overrides)
  - [Firefox Translations](#firefox-translations)
  - [Initial Add-on Installation](#initial-add-on-installation)
  - [Intermediate Certificates](#intermediate-certificates)
  - [MITM Priming](#mitm-priming)
  - [System Add-on Updates](#system-add-on-updates)
  - [URL Query Parameter Stripping](#url-query-parameter-stripping)
  - [Web Compatibility Interventions](#web-compatibility-interventions)
  - [Remote Settings](#remote-settings)
  - [Push Service](#push-service)
  - [Autograph](#autograph)
- [Additional](#additional)
  - [Android Debugging](#android-debugging) *(Desktop)*
  - [Captive Portal Detection](#captive-portal-detection)
  - [Connectivity Checks](#connectivity-checks)
  - [Firefox Sync](#firefox-sync)
  - [Geolocation](#geolocation)
  - [Manual Add-on Updates](#manual-add-on-updates)
  - [New Tab Wallpapers](#new-tab-wallpapers)
  - [Password Breach Alerts](#password-breach-alerts)
  - [Weather](#weather)

## Default

These connections are made **by default**, out of the box.

### DNS over HTTPS

- `https://dns.quad9.net/dns-query`

**Operator**: [Quad9](https://quad9.net/) - *[Privacy policy](https://quad9.net/privacy/policy/)*

**Purpose**: [Provides encrypted domain name resolution](https://wikipedia.org/wiki/DNS_over_HTTPS).

**Type(s) of data shared**: Domain names of servers you connect to, User Agent, public IP address.

**How often the connection occurs**: Every time you connect to a domain.

**Control**: You can change DNS providers by setting the values of `network.trr.custom_uri` and `network.trr.uri`
at [`about:config`](about:config) to your preferred provider's URL.

**Or** on **Desktop**, you can change DNS providers by navigating to [`about:preferences#privacy`](about:preferences#privacy), and
scrolling to the bottom, where you'll find the `DNS over HTTPS` section.
Under `Max Protection` -> `Choose provider:`, you can either select one of our presets:

- **Cloudflare** - `https://mozilla.cloudflare-dns.com/dns-query` - *[Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/cloudflare-resolver-firefox/)*
- **Cloudflare (Malware Protection)** - `https://security.cloudflare-dns.com/dns-query` - *[Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/public-dns-resolver/)*
- **DNS4EU (Ad Blocking)** - `https://noads.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **DNS4EU (Protective)** - `https://protective.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **DNS4EU (Unfiltered)** - `https://unfiltered.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **DNSBunker** - `https://dnsbunker.org/dns-query` - *[Privacy policy](https://dnsbunker.org/privacy.html)*
- **dnsforge.de (Blank)** - `https://blank.dnsforge.de/dns-query` - *[Privacy policy](https://adminforge.de/datenschutz/)*
- **dnsforge.de (Hard)** - `https://hard.dnsforge.de/dns-query` - *[Privacy policy](https://adminforge.de/datenschutz/)*
- **dnsforge.de (Normal)** - `https://dnsforge.de/dns-query` - *[Privacy policy](https://adminforge.de/datenschutz/)*

**Or** you can add your own provider by selecting `Custom`, and entering your desired URL.

You can also disable DNS over HTTPS entirely by setting `network.trr.mode` to `5` at [`about:config`](about:config),
**or** on **Desktop**, you can select `Off` from the same page you just navigated to at [`about:preferences#privacy`](about:preferences#privacy).

**WARNING**: Disabling this feature is not recommended, as it will compromise your privacy and security.

**NOTE**: Upon first launch, your browser with Phoenix will use your system's DNS provider to resolve the domain for your chosen DNS over HTTPS
provider. At the cost of compatibility issues and breakage with certain networks *(such as those that are IPv6 only)*, you can prevent this by:

- Setting `browser.phoenix.trr.autoBootstrap` to `true` at [`about:config`](about:config) and restarting the browser
- Manually setting `network.trr.bootstrapAddr` to the IP address of your chosen DNS over HTTPS provider

Note that the auto-bootstrap functionality only supports Phoenix's built-in DNS over HTTPS providers, so if you are using a custom one, you
**must** manually configure the value of `network.trr.bootstrapAddr`.

___

### Safe Browsing

- `https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&*`
- `https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&*`
- `https://safebrowsing.ironfoxoss.org/v5/hashes:search?*`
- `https://safebrowsing.ironfoxoss.org/v5/hashLists:batchGet?*`

**Operator**: [IronFox OSS](https://ironfoxoss.org/) - *[Privacy policy](https://codeberg.org/celenity/Phoenix/wiki/Transparency#google-safe-browsing)*

**Purpose**: [Provides real-time protection against malware and phishing]((https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work)) *([Proxies `https://safebrowsing.googleapis.com`](https://gitlab.com/ironfox-oss/safebrowsing-proxy))*.

**Type(s) of data shared**: [Partial URL hashes upon potential matches](https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/), User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and every 30 minutes after.

**Control**: You can use Google's standard, unproxied Safe Browsing endpoint instead of the IronFox proxy if preferred, by setting the following preferences in your [`about:config`](about:config):

- `browser.safebrowsing.provider.google4.gethashURL` -> `https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST`
- `browser.safebrowsing.provider.google4.updateURL` -> `https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST`
- `browser.safebrowsing.provider.google5.gethashURL` -> `https://safebrowsing.googleapis.com/v5/hashes:search?key=%GOOGLE_SAFEBROWSING_API_KEY%`
- `browser.safebrowsing.provider.google5.updateURL` -> `https://safebrowsing.googleapis.com/v5/hashLists:batchGet?key=%GOOGLE_SAFEBROWSING_API_KEY%`

**Or**, to disable Safe Browsing entirely:

- On **Desktop**, you can disable Safe Browsing by navigating to [`about:preferences#privacy`](about:preferences#privacy),
scrolling down to the `Security` section, and unchecking the box to the left of `Block dangerous and deceptive content`
*(under `Deceptive Content and Dangerous Software Protection`)*, **or** you can set the following preferences at [`about:config`](about:config):
  - `browser.safebrowsing.malware.enabled` -> `false`
  - `browser.safebrowsing.phishing.enabled` -> `false`

- On **Android**, you can disable Safe Browsing by setting the following preferences at [`about:config`](about:config):
  - `browser.safebrowsing.features.malware.update` -> `false`
  - `browser.safebrowsing.features.phishing.update` -> `false`

**WARNING**: Disabling this functionality is not recommended, as it will compromise your security.

___

### Tracking Protection

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/tracking-protection-lists/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/tracking-protection-lists/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads and updates tracker, cryptominer, and harmful add-on blocklists](https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Tracking protection can be disabled by setting the following preferences at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy and security.

- Cryptomining:
  - `privacy.trackingprotection.cryptomining.enabled` -> `false`
  - `browser.safebrowsing.features.cryptomining.annotate.update` -> `false` *(Hidden)*
- Email tracking:
  - `privacy.trackingprotection.emailtracking.enabled` -> `false`
  - Private browsing: `privacy.trackingprotection.emailtracking.pbmode.enabled` -> `false`
- Fingerprinting:
  - `privacy.trackingprotection.fingerprinting.enabled` -> `true`
  - `browser.safebrowsing.features.fingerprinting.annotate.update` -> `false` *(Hidden)*
- General/misc. tracking:
  - `privacy.trackingprotection.enabled` -> `false`
  - Private browsing: `privacy.trackingprotection.pbmode.enabled` -> `false`
- Harmful add-ons:
  - `privacy.trackingprotection.harmfuladdon.enabled` -> `false`
- Social tracking:
  - `privacy.trackingprotection.socialtracking.enabled` -> `false`
  - `browser.safebrowsing.features.socialtracking.annotate.update` -> `false` *(Hidden)*

**In addition** to the preferences above, if you wish to disable all tracking protection entirely, you should **also** set:
  - `browser.safebrowsing.provider.mozilla.lists` -> `disabled`
  - `privacy.trackingprotection.annotate_channels` -> `false`
  - `privacy.trackingprotection.antifraud.annotate_channels` -> `false`
  - `privacy.trackingprotection.consentmanager.annotate_channels` -> `false`

___

### uBlock Origin

- `https://assets.celenity.dev/ublock/badlists.txt` - *[Privacy Policy](./transparency-privacy-notice#ublock-origin-assets)*
- `https://assets.celenity.dev/ublock/phoenix/assets.json` - *[Privacy Policy](./transparency-privacy-notice#ublock-origin-assets)*
- `https://badblock.celenity.dev/abp/*` - *[Privacy Policy](https://calibour.com/)*
- `https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/*` - *[Privacy Policy](https://www.jsdelivr.com/terms/privacy-policy)*
- `https://cdn.jsdelivr.net/gh/uBlockOrigin/uAssetsCDN@main/*` - *[Privacy Policy](https://www.jsdelivr.com/terms/privacy-policy)*
- `https://cdn.statically.io/gh/uBlockOrigin/uAssetsCDN/main/*` - *[Privacy Policy](https://statically.io/policies/privacy/)*
- `https://filters.adtidy.org/extension/ublock/filters/*` - *[Privacy Policy](https://adguard.com/privacy.html)*
- `https://gitlab.com/DandelionSprout/adfilt/-/raw/master/*` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://malware-filter.gitlab.io/urlhaus-filter/urlhaus-filter-ag-online.txt` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://malware-filter.pages.dev/urlhaus-filter-ag-online.txt` - *[Privacy Policy](https://www.cloudflare.com/privacypolicy/)*
- `https://publicsuffix.org/list/public_suffix_list.dat` - *[Privacy policy](https://www.mozilla.org/privacy/)*
- `https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist-basic.txt` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://secure.fanboy.co.nz/*`
- `https://ublockorigin.github.io/uAssets/*` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://ublockorigin.github.io/uAssetsCDN/*` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://ublockorigin.pages.dev/*` - *[Privacy Policy](https://www.cloudflare.com/privacypolicy/)*

**Purpose**: Downloads and updates for [Phoenix's uBlock Origin configuration](./features-content-blocking), as well as
filterlists and various other resources.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Periodically.

**Control**: You can enable disable filterlists by navigating to uBlock Origin's Dashboard -> `Filter lists`, or you can disable
uBlock Origin entirely from [`about:addons`](about:addons).

**WARNING**: Disabling uBlock Origin is not recommended, as it will compromise your privacy and security.

___

### Tracking Protection Exceptions

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/url-classifier-exceptions/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads a list of exceptions to reduce breakage caused by the tracking protection blocklists](https://support.mozilla.org/kb/manage-enhanced-tracking-protection-exceptions).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Tracking protection exceptions can be disabled by setting the following preferences at `about:config`:

**WARNING**: Disabling this functionality may cause breakage across websites.

- Exceptions for *major* site issues:
  - `privacy.trackingprotection.allow_list.baseline.enabled` -> `false`
- Exceptions for *minor* site issues:
  - `privacy.trackingprotection.allow_list.convenience.enabled` -> `false` *(This is Phoenix's default value)*

___

### Add-on Blocklists

- `https://firefox.settings.services.mozilla.com/v1/buckets/blocklists/collections/addons-bloomfilters/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads and updates malicious add-on blocklists](https://support.mozilla.org/kb/add-ons-cause-issues-are-on-blocklist).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: The add-on blocklist can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy and security.

- `extensions.blocklist.enabled` -> `false`

**NOTE**: Phoenix also includes [its own extended add-on blocklist](https://codeberg.org/celenity/Phoenix/src/branch/dev/policies/phoenix-core.json),
which is applied via enterprise policies. There is not currently a way to disable Phoenix's list without
manually editing Phoenix's `policies.json` file.

___

### Add-on Updates

- `https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=2&*`

**NOTE**: If you install add-ons from outside of `addons.mozilla.org`, you may notice additional connections to other servers
as part of this functionality *(as specified by the extension(s) you install)*.

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads updates for installed extensions and themes](https://blog.mozilla.org/addons/how-to-turn-off-add-on-updates/).

**Type(s) of data shared**: Identifiers of installed add-ons, Current versions of installed add-ons, Browser version, User Agent, public IP address.

**How often the connection occurs**: Hourly *(`extensions.update.interval`)*.

**Control**: You can disable add-on updates globally by setting the following preference at [`about:config`](about:config):

**WARNING**: Disabling this feature is not recommended, as it will compromise your privacy and security.

- `extensions.update.enabled` -> `false`

You can also disable updates for individual add-ons by setting `extensions.{GUID}.update.enabled` to `false` at
[`about:config`](about:config), replacing `{GUID}` with the ID of your desired add-on *(IDs of installed extensions can be found at [`about:support`](about:support))*.

**For example**: if I wanted to disable updates for uBlock Origin, I would set `extensions.uBlock0@raymondhill.net.update.enabled` to `false`.
**Or**, on **Desktop**, you can disable updates for individual add-ons by navigating to [`about:addons`](about:addons),
selecting your desired add-on, and selecting `Off` to the right of `Allow automatic updates`.

___

### Application Update Service

**NOTE**: This only applies to **DESKTOP**.

- `https://aus5.mozilla.org/update/6/Firefox/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads application updates and language packs](https://firefox-source-docs.mozilla.org/toolkit/mozapps/update/docs/InAppUpdateProcess.html).

**Type(s) of data shared**: Browser version, locale, OS, OS architecture, OS version, User Agent, public IP address.

**How often the connection occurs**: Hourly *(`app.update.background.interval` & `app.update.interval`)*.

**Control**: You can disable this functionality by setting the following preferences at [`about:config`](about:config):

**WARNING**: Disabling this feature is not recommended, as it will compromise your privacy and security.

- `app.update.auto` -> `false`
- `app.update.background.enabled` -> `false`
- `app.update.disabledForTesting` -> `true`
- `app.update.langpack.enabled` -> `false`
- `app.update.interval` -> `2147483647`
- **non-Windows**: `app.update.service.enabled` -> `false`

___

### Certificate Transparency Logs

- `https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/ct-logs/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads logs to enforce Certificate Transparency for web certificates](https://developer.mozilla.org/docs/Web/Security/Defenses/Certificate_Transparency).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Certificate Transparency can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it is **critical** from a privacy and security perspective.

- `security.pki.certificate_transparency.mode` -> `0`

___

### CRLite

- `https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/cert-revocations/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/security-state-staging/cert-revocations/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads certificate revocation data](https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: CRLite can be disabled by setting the following preferences at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it is **critical** from a privacy and security perspective.

- `security.pki.crlite_mode` -> `0`
- `security.remote_settings.crlite_filters.enabled` -> `false`

___

### Fingerprinting Protection Overrides

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fingerprinting-protection-overrides/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads a list of overrides to reduce breakage caused by Mozilla's [Suspected Fingerprinters Protection *(FPP)*](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Fingerprinting protection overrides can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality may cause breakage across websites.

- `privacy.fingerprintingProtection.remoteOverrides.enabled` -> `false`

**NOTE**: Disabling this setting does not prevent the browser from downloading the list of overrides, but it does prevent them from being applied.

Phoenix also includes its own set of [Fingerprinting Protection Overrides](./features-fpp-overrides) to reduce breakage and harden protection
for websites as needed. To disable Phoenix's overrides, you can set the following preferences at `about:config`:

- Overrides that *harden* protection for websites:
  - `browser.phoenix.fingerprintingProtection.granular.hardenOverrides.enabled` -> `false`
- Overrides that *relax* protection for websites:
  - `browser.phoenix.fingerprintingProtection.granular.unbreakOverrides.enabled` -> `false`
- Overrides that disable timezone spoofing for websites:
  - `browser.phoenix.fingerprintingProtection.granular.unbreakTimezoneOverrides.enabled` -> `false`

___

### Firefox Translations

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/translations-models/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/translations-models-v2/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/translations-wasm/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/translations-wasm-v2/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads configuration data and machine learning models [to support local, on-device website translation](https://support.mozilla.org/kb/website-translation).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Firefox Translations can be disabled by setting the following preferences at [`about:config`](about:config):

- `browser.ai.control.translations` -> `blocked`
- `browser.translations.enable` -> `false`
- `browser.translations.simulateUnsupportedEngine` -> `true`
- Desktop: `extensions.translations.disabled` -> `true`

___

### Initial Add-on Installation

**NOTE**: This only applies to **DESKTOP**.

- `https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads and installs the [uBlock Origin](https://addons.mozilla.org/addon/ublock-origin/) extension.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Once, on initial set-up.

**Control**: There is not currently a way to prevent this connection without manually editing Phoenix's `policies.json` file.

___

### Intermediate Certificates

- `https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/intermediates/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/bundles/security-state--intermediates.zip`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads/preloads intermediate certificates](https://sslinsights.com/what-is-intermediate-certificate/).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Intermediate certificate downloading can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy and security.

- `security.remote_settings.intermediates.enabled` -> `false`

___

### MITM Priming

- `https://mitmdetection.services.mozilla.com/`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Used to check for and notify users upon a MITM attack](https://searchfox.org/firefox-main/rev/a9a644f66adb0cbb132f042bb7df24032f56346a/toolkit/content/aboutNetError.mjs#859).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Upon reaching a certificate error, if the reason for the error is unknown.

**Control**: MITM priming can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy and security.

- `security.certerrors.mitm.priming.enabled` -> `false`

You can also change the MITM priming endpoint if desired by setting the value of `security.certerrors.mitm.priming.endpoint`
to your preferred URL at [`about:config`](about:config).

___

### System Add-on Updates

- `https://archive.mozilla.org/pub/system-addons/*`
- `https://aus5.mozilla.org/update/3/SystemAddons/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads and updates system add-ons](https://firefox-source-docs.mozilla.org/toolkit/mozapps/extensions/addon-manager/SystemAddons.html).

**Type(s) of data shared**: Browser version, locale, OS, OS architecture, OS version, User Agent, public IP address.

**How often the connection occurs**: Hourly.

**Control**: You can disable this functionality by setting the following preference at [`about:config`](about:config):

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy and security.

- `extensions.systemAddon.update.enabled` -> `false`

___

### URL Query Parameter Stripping

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/query-stripping/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads and updates a list of URL tracking parameters for the browser to strip](https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/query-stripping/index.html).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: URL Query Parameter Stripping can be disabled by setting the following preferences at `about:config`:

**WARNING**: Disabling this functionality is not recommended, as it will compromise your privacy.

- Standard browsing:
  - `privacy.query_stripping.enabled` -> `false`
- Private browsing:
  - `privacy.query_stripping.enabled.pbmode` -> `false`

**NOTE**: Phoenix includes its own extended list of query parameters to strip from URLs, which is also disabled by the settings above.

___

### Web Compatibility Interventions

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/webcompat-interventions/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads configuration data to apply work-arounds for website breakage](https://wiki.mozilla.org/Compatibility/System_Addon/Interventions).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Web Compatibility Interventions can be disabled by setting the following preference at `about:config`:

**WARNING**: Disabling this functionality may cause breakage across websites.

- `extensions.webcompat.enable_interventions` -> `false`

___

### Remote Settings

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/monitor/collections/changes/changeset?_expected=*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/bundles/security-state--intermediates.zip`
- `https://firefox-settings-attachments.cdn.mozilla.net/bundles/startup.json.mozlz4`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads configurations and databases](https://remote-settings.readthedocs.io/en/latest/) for [various functionality](https://mozilla.github.io/remote-settings-permissions/), including many of the services documented above.

Remote Settings is used for, but not limited to:

- [Add-on blocklists](#add-on-blocklists)
- [Certificate Revocations](#crlite)
- [Certificate Transparency logs](#certificate-transparency-logs)
- [Fingerprinting Protection overrides](#fingerprinting-protection-overrides)
- [Intermediate Certificates](#intermediate-certificates)
- [New Tab Wallpapers](#new-tab-wallpapers) *(Desktop)*
- [Password Breach Alerts](#password-breach-alerts)
- [Tracking Protection lists](#tracking-protection)
- [Tracking Protection exceptions](#tracking-protection-exceptions)
- [Translation models and configuration data](#firefox-translations)
- [URL Query Parameter Stripping](#url-query-parameter-stripping)
- [Web Compatibility Interventions](#web-compatibility-interventions)
- As well as many other features...

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: Phoenix does not provide support for disabling Remote Settings in its entirety, as it is **critical** from a privacy and
security perspective. Individual services/functionality it supports can be controlled with the steps documented on this page.

___

### Push Service

- `wss://push.services.mozilla.com/`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Provides support](https://mozilla-push-service.readthedocs.io/en/latest/) for [Remote Settings](#remote-settings) and
[web push notifications](https://support.mozilla.org/kb/push-notifications-firefox).

**Type(s) of data shared**: Random identifier *(`dom.push.userAgentID`)*, User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after.

**Control**: You can disable this functionality by setting the following preferences at [`about:config`](about:config):

**WARNING**: Disabling this functionality is not recommended, as it is **critical** from a privacy and security perspective.

- `dom.push.connection.enabled` -> `false`
- `dom.push.userAgentID` -> ` `

___

### Autograph

- `https://content-signature-2.cdn.mozilla.net/g/chains/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Provides signing/verification for various functionality](https://github.com/mozilla-services/autograph), including, but not limited to:

- [Content signatures](https://github.com/mozilla-services/autograph/blob/main/signer/contentsignaturepki/README.md)
- Extension signing *([1](https://github.com/mozilla-services/autograph/blob/main/signer/xpi/README.md), [2](https://wiki.mozilla.org/Add-ons/Extension_Signing))*
- On Desktop: [Application updates](https://github.com/mozilla-services/autograph/blob/main/signer/mar/README.md)

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after.

**Control**: Phoenix does not provide support for disabling Autograph, as it is **critical** from a privacy and security perspective.

## Additional

The following are **optional**, **non-standard** connections your browser with Phoenix might make, depending on the features you decide to use.

### Android Debugging

**NOTE**: This only applies to **DESKTOP**.

- `https://ftp.mozilla.org/pub/labs/devtools/adb-extension/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Installs and updates the `Firefox DevTools ADB Extension` [to provide support for debugging Firefox-based Android web browsers](https://firefox-source-docs.mozilla.org/devtools-user/about_colon_debugging/index.html#connecting-to-a-remote-device).

**Type(s) of data shared**: OS, OS architecture, User Agent, public IP address.

**How often the connection occurs**: When/if you select the option to `Enable USB Devices` *(under `Connect a Device`)* from
[`about:debugging#/setup`](about:debugging#/setup), and hourly *(`extensions.update.interval`)* after.

**Control**: You can choose to not install the `Firefox DevTools ADB Extension` by not selecting the option to `Enable USB Devices`.

You can also disable updates for the `Firefox DevTools ADB Extension` by setting `extensions.adb@mozilla.org.update.enabled` to `false`
at [`about:config`](about:config), **or** you can disable updates for the for the `Firefox DevTools ADB Extension` by navigating
to [`about:addons`](about:addons), selecting `Firefox DevTools ADB Extension`, and selecting `Off` to the right of `Allow automatic updates`.

**WARNING**: Disabling updates for the `Firefox DevTools ADB Extension` is not recommended, as it will compromise your privacy and security.

___

### Captive Portal Detection

- `http://captive.celenity.dev/canonical.html`

**Operator**: [celenity](https://celenity.dev/) - *[Privacy policy](./transparency-privacy-notice#captive-portal-detection)*

**Purpose**: [Checks if the internet is behind a captive portal, and allows the user to authenticate with it if necessary for internet access](https://firefox-source-docs.mozilla.org/networking/captive_portals.html).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after, if Captive Portal detection is enabled.

**Control**: Phoenix does not enable Captive Portal detection by default due to privacy and security concerns.

To prevent this connection, simply avoid setting `network.captive-portal-service.enabled` to `true` at [`about:config`](about:config),
or set it to `false` if you previously enabled it.

You can also change the Captive Portal endpoint if desired by navigating to [`about:config`](about:config) and
setting the value of `captivedetect.canonicalURL` to your preferred URL, and `captivedetect.canonicalContent` to the expected data that the browser
should receive from the endpoint.

___

### Connectivity Checks

- `https://captive.celenity.dev/success.txt?ipv4`
- `https://captive.celenity.dev/success.txt?ipv6`
- `captive.celenity.dev` *(DNS Resolution)*

**Operator**: [celenity](https://celenity.dev/) - *[Privacy policy](./transparency-privacy-notice#connectivity-checks)*

**Purpose**: [Checks if the browser has internet connectivity, primarily to improve handling of network connectivity issues](https://firefox-source-docs.mozilla.org/networking/connectivity_checking.html).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after, if connectivity checks are enabled.

**Control**: Phoenix does not enable connectivity checks by default due to privacy and security concerns.

To prevent this connection, simply avoid setting `network.connectivity-service.enabled` to `true` at [`about:config`](about:config),
or set it to `false` if you previously enabled it.

You can also change the connectivity check endpoint if desired by setting the following preferences at [`about:config`](about:config) to your
desired endpoint:

- `network.connectivity-service.DNS_HTTPS.domain`
- `network.connectivity-service.DNSv4.domain`
- `network.connectivity-service.DNSv6.domain`
- `network.connectivity-service.IPv4.url`
- `network.connectivity-service.IPv6.url`

___

### Firefox Sync

- `https://api.accounts.firefox.com/v1/account/attached_clients`
- `https://api.accounts.firefox.com/v1/account/devices?filterIdleDevicesTimestamp=*`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/info/collections`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/info/configuration`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/storage/*`
- `https://token.services.mozilla.com/1.0/sync/1.5`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Provides E2EE sync of user data](https://www.mozilla.org/firefox/features/sync/).

**Type(s) of data shared**: Types of data specified at [`about:preferences#sync`](about:preferences#sync) *([in encrypted form]((https://hacks.mozilla.org/2018/11/firefox-sync-privacy/))*, User Agent, public IP address.

**How often the connection occurs**: Every browser launch, periodically after, and upon selecting `Sync now` at [`about:preferences#sync`](about:preferences#sync) .

**Control**: You can choose to not use Firefox Sync, **or** on **Desktop**, you can sign-out if you've already set it
up from [`about:preferences#sync`](about:preferences#sync).
On **Desktop**, you can **also** disable Firefox Sync entirely by setting `identity.fxaccounts.enabled` to `false` at [`about:config`](about:config).

If preferred, you can also [self-host](https://blog.diego.dev/posts/firefox-sync-server/) Firefox Sync.

___

### Geolocation

- `https://api.beacondb.net/v1/geolocate`

**Operator**: [BeaconDB](https://beacondb.net/) - *[Privacy policy](https://beacondb.net/privacy/)*

**Purpose**: [Provides geolocation](https://support.mozilla.org/kb/does-firefox-share-my-location-websites) for non-macOS users *(and is used as a fall-back for geolocation on macOS)*.

**Type(s) of data shared**: Strength and general information of nearby cellular towards and Wi-Fi networks *(if available/supported)*, User Agent,
public IP address.

**How often the connection occurs**:

- **Windows**: When/if you grant a website permission to access your location.
- **non-Windows**: When/if you grant a website permission to access your location **and** if your system's geolocation provider is unavailable.

**Control**: You can simply choose not to grant websites permission to access your location, **or** you can disable the
network geolocation provider entirely by setting the following preferences at [`about:config`](about:config):

- `geo.provider.network.url` -> ` `
- `geo.provider.use_mls` -> `false`

You can also change the network geolocation provider if desired by setting the value of `geo.provider.network.url`
to your preferred URL at [`about:config`](about:config).

**WARNING**: Disabling the geolocation provider **WILL** break geolocation on **Linux** and **Windows**, and may cause issues
with geolocation on other platforms if the OS geolocation provider is unavailable.

If desired, after disabling the network geolocation provider, you can re-enable the OS geolocation provider for Linux and Windows by setting 
the following preferences at [`about:config`](about:config), depending on your platform:

**WARNING**: Re-enabling the OS geolocation provider is **NOT** recommended. This is **especially** the case for Windows, as
if the OS provider is enabled, the browser will use Microsoft's privacy-invasive location services to retrieve your location.

- Linux: `geo.provider.use_geoclue` -> `true`
- Windows: `geo.provider.ms-windows-location` -> `true`, `geo.provider.use_winrt` -> `true`

___

### Manual Add-on Updates

- `https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=2&...`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads updates for installed extensions and themes.

**Type(s) of data shared**: Identifiers of installed add-ons, Current versions of installed add-ons, Browser version, User Agent, public IP address.

**How often the connection occurs**: Depending on your platform, this occurs:

- On Desktop: When you select the option to `Check for Updates` *(Found when selecting the gear to the right of `Manage Your Extensions`)*
at [`about:addons`](about:addons)

- On Android: When you select the option to `Check for updates` under `Add-ons Tools` at the `Debug Drawer` *(which can be enabled by navigating to `Secret Settings` -> `Debug`, and toggling the `Enable Debug Drawer` option)*

**Control**: You can avoid manually checking for updates, if desired.

___

### New Tab Wallpapers

**NOTE**: This only applies to **DESKTOP**.

- `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/newtab-wallpapers-v2/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Downloads wallpapers for Firefox Home](https://support.mozilla.org/kb/customize-your-wallpapers) *([`about:home`](about:home))*.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Upon setting the `browser.newtabpage.activity-stream.feeds.wallpaperfeed` preference
at [`about:config`](about:config) to `true`, and every browser launch after.

**Control**: Phoenix does not enable download of new tab wallpapers by default to improve privacy.

To prevent this connection, simply avoid setting `browser.newtabpage.activity-stream.feeds.wallpaperfeed` to `true`
at [`about:config`](about:config), or set it to `false` if you previously enabled it.

___

### Password Breach Alerts

**NOTE**: This only applies to **DESKTOP**.

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxmonitor-breaches/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads [information regarding data breaches](https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxmonitor-breaches/changeset?_expected=0) to [notify users if their information has been compromised](https://support.mozilla.org/kb/firefox-password-manager-alerts-breached-websites).

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Periodically if the Password Manager *(`signon.rememberSignons`)* is enabled.

**Control**: You can disable this functionality by unchecking the box to `Show alerts about passwords for breached websites`
*(under the `Passwords` section)* at [`about:preferences#passwordsAutofill`](about:preferences#passwordsAutofill), **or** by
setting `signon.management.page.breach-alerts.enabled` to `false` at [`about:config`](about:config).

___

### Weather

**NOTE**: This only applies to **DESKTOP**.

- `https://merino.services.mozilla.com/api/v1/suggest?q=*&providers=accuweather&request_type=weather&sid=*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: [Displays weather updates on Firefox Home](https://support.mozilla.org/kb/how-it-works-firefox-weather) *([`about:home`](about:home))*.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Upon setting the `browser.newtabpage.activity-stream.showWeather` preference at [`about:config`](about:config)
to `true`, **or** upon enabling `Weather` at [`about:home`](about:home) or [`about:preferences#home`](about:preferences#home), and
every browser launch after.

**Control**: Phoenix does not enable display of weather data by default to improve privacy.

To prevent this connection, simply avoid setting `browser.newtabpage.activity-stream.showWeather` to `true` at [`about:config`](about:config), or
set it to `false` if you previously enabled it.
This can also be disabled by toggling `Weather` to `false` by selecting the gear on the bottom right at [`about:home`](about:home), **or** by
unchecking the box to the left of `Weather` at [`about:preferences#home`](about:preferences#home).
