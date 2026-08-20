# 🛜 Network Connections

This page serves to document connections commonly made by your browser with Phoenix installed. It will explain the purpose of each connection, what data is shared, and how to disable *(or override if applicable)* the connection if desired.

Please also see our [Privacy Notice](./Transparency-Privacy-Notice.md) for more details.

## Default

These connections are made **by default**, out of the box.

### [Add-on Updates](https://blog.mozilla.org/addons/how-to-turn-off-add-on-updates/)

- `https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=2&*`

If you install add-ons from outside of the AMO *(`addons.mozilla.org`)*, you may notice additional connections to other servers as part of this functionality *(as specified by the extension(s) you install)*.

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads updates for installed extensions and themes.

**Type(s) of data shared**: Identifiers of installed add-ons, Current versions of installed add-ons, Browser version, User Agent, public IP address.

**How often the connection occurs**: Hourly *(`extensions.update.interval`)*.

**Control**: You can disable add-on updates globally by setting `extensions.update.enabled` to `false` in your [`about:config`](about:config).

You can also disable updates for individual add-ons by setting `extensions.{GUID}.update.enabled` to `false` in your [`about:config`](about:config), replacing `{GUID}` with the ID of your desired add-on *(IDs of your installed extensions can be found at [`about:support`](about:support))*. **For example**: if I wanted to disable updates for uBlock Origin, I would set `extensions.uBlock0@raymondhill.net.update.enabled` to `false`. **Or** on **Desktop**, you can disable updates for individual add-ons by navigating to [`about:addons`](about:addons), selecting your desired add-on, and selecting `Off` to the right of `Allow automatic updates`.

Note that disabling add-on updates is **NOT** recommended.

### [Application Update Service](https://firefox-source-docs.mozilla.org/toolkit/mozapps/update/docs/InAppUpdateProcess.html) *(**DESKTOP**)*

- `https://aus5.mozilla.org/update/6/Firefox/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads application updates, and language packs.

**Type(s) of data shared**: Browser version, locale, OS, OS architecture, OS version, User Agent, public IP address.

**How often the connection occurs**: Hourly *(`app.update.background.interval` & `app.update.interval`)*.

**Control**: You can disable this functionality by setting the following preferences in your [`about:config`](about:config):

- `app.update.auto` -> `false`
- `app.update.background.enabled` -> `false`
- `app.update.langpack.enabled` -> `false`
- `app.update.interval` -> `999999999`
- **Windows**: `app.update.BITS.enabled` -> `false`
- **non-Windows**: `app.update.service.enabled` -> `false`

Note that disabling this feature is **NOT** recommended.

### [Autograph](https://github.com/mozilla-services/autograph)

- `https://content-signature-2.cdn.mozilla.net/g/chains/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Provides signing/verification for various functionality, including: [content signatures](https://github.com/mozilla-services/autograph/blob/main/signer/contentsignaturepki/README.md), extension signing *([1](https://github.com/mozilla-services/autograph/blob/main/signer/xpi/README.md), [2](https://wiki.mozilla.org/Add-ons/Extension_Signing))*, and [application updates](https://github.com/mozilla-services/autograph/blob/main/signer/mar/README.md) *(**Desktop**)*.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after.

**Control**: This request can be disabled by appending `,content-signature-2.cdn.mozilla.net` to the value of `network.dns.localDomains` in your [`about:config`](about:config) *(or by blocking `content-signature-2.cdn.mozilla.net` on the network level)*; though it is **NOT** recommended to disable or block this connection.

### [DNS over HTTPS](https://wikipedia.org/wiki/DNS_over_HTTPS)

- `https://base.dns.mullvad.net/dns-query`

**Operator**: [Mullvad VPN AB](https://mullvad.net/) - *[Privacy policy](https://mullvad.net/help/privacy-policy)*

**Purpose**: Provides encrypted domain name resolution.

**Type(s) of data shared**: Domain names of servers you connect to, User Agent, public IP address.

**How often the connection occurs**: Every time you connect to a domain.

**Control**: You can change DNS providers by setting the values of `network.trr.custom_uri` and `network.trr.uri` in your [`about:config`](about:config) to your preferred provider's URL.

**Or** on **Desktop**, you can change DNS providers by navigating to [`about:preferences#privacy`](about:preferences#privacy) and scrolling to the bottom, where you'll find the `DNS over HTTPS` section. Under `Max Protection` -> `Choose provider:`, you can either select one of our presets:

- **Cloudflare** - `https://mozilla.cloudflare-dns.com/dns-query` - *[Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/cloudflare-resolver-firefox/)*
- **Cloudflare (Malware Protection)** - `https://security.cloudflare-dns.com/dns-query` - *[Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/public-dns-resolver/)*
- **DNS4EU (Ad Blocking)** - `https://noads.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **DNS4EU (Protective)** - `https://protective.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **DNS4EU (Unfiltered)** - `https://unfiltered.joindns4.eu/dns-query` - *[Privacy policy](https://www.joindns4.eu/privacy-policy)*
- **Mullvad (Unfiltered)** - `https://dns.mullvad.net/dns-query` - *[Privacy policy](https://mullvad.net/help/privacy-policy)*

**Or** you can add your own provider by selecting `Custom`, and entering your desired URL.

You can also disable DNS over HTTPS entirely by setting `network.trr.mode` to `5` in your [`about:config`](about:config), **or** on **Desktop**, you can select `Off` from the same page you just navigated to at [`about:preferences#privacy`](about:preferences#privacy); though disabling DNS over HTTPS is **NOT** recommended.

### Initial add-on installation *(**DESKTOP**)*

- `https://addons.mozilla.org/firefox/downloads/latest/@testpilot-containers/latest.xpi`
- `https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads and installs the [Firefox Multi-Account Containers](https://addons.mozilla.org/addon/multi-account-containers/) and [uBlock Origin](https://addons.mozilla.org/addon/ublock-origin/) extensions.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Once, on initial set-up.

**Control**: This request can be disabled by appending `,addons.mozilla.org` to the value of `network.dns.localDomains` in your [`about:config`](about:config) *(or by blocking `addons.mozilla.org` on the network level)*; though it is **NOT** recommended to disable or block this connection.

### [Push Service](https://mozilla-push-service.readthedocs.io/en/latest/)

- `wss://push.services.mozilla.com/`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Provides support for [web push notifications](https://support.mozilla.org/kb/push-notifications-firefox) and [Remote Settings](https://searchfox.org/mozilla-central/rev/97feebcab27f1a92e70ceacaa77211e9eaba0e6e/services/settings/remote-settings.sys.mjs#593-609).

**Type(s) of data shared**: Random identifier *(`dom.push.userAgentID`)*, User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and periodically after.

**Control**: You can disable this functionality by setting the following preferences in your [`about:config`](about:config):

- `dom.push.connection.enabled` -> `false`
- `dom.push.userAgentID` -> ` `

Note that disabling this feature is **NOT** recommended.

### [Remote Settings](https://remote-settings.readthedocs.io/en/latest/)

- `https://firefox.settings.services.mozilla.com/v1/buckets/blocklists/collections/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/monitor/collections/changes/changeset?_expected=*`
- `https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/bundles/security-state--intermediates.zip`
- `https://firefox-settings-attachments.cdn.mozilla.net/bundles/startup.json.mozlz4`
- `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/tracking-protection-lists/*`
- `https://firefox-settings-attachments.cdn.mozilla.net/security-state-staging/cert-revocations/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads configurations and databases for [various functionality](https://mozilla-services.github.io/remote-settings-permissions/), including: [Add-on blocklists](https://firefox.settings.services.mozilla.com/v1/buckets/blocklists/collections/addons-bloomfilters/changeset?_expected=0), [Certificate Revocations](https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/cert-revocations/changeset?_expected=0), [Certificate Transparency logs](https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/ct-logs/changeset?_expected=0), [Intermediate Certificates](https://firefox.settings.services.mozilla.com/v1/buckets/security-state/collections/intermediates/changeset?_expected=0), [Tracking Protection lists](https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/tracking-protection-lists/changeset?_expected=0), [Translation models](https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/translations-models/changeset?_expected=0), etc.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Hourly *(`services.settings.poll_interval`)*.

**Control**: This functionality can be disabled globally by setting the following preferences in your [`about:config`](about:config):

- `services.settings.poll_interval` -> `999999999`
- `services.settings.server` -> ` `

You'll **also** need to append `,firefox.settings.services.mozilla.com,firefox-settings-attachments.cdn.mozilla.net` to the value of `network.dns.localDomains` in your [`about:config`](about:config) *(or you can block `firefox.settings.services.mozilla.com` and `firefox-settings-attachments.cdn.mozilla.net` on the network level)*; though it is **NOT** recommended to disable or block this functionality.

You can also disable certain individual parts of this functionality if desired by setting the following preferences in your [`about:config`](about:config):

- **[Add-on blocklists](https://support.mozilla.org/kb/add-ons-cause-issues-are-on-blocklist)**: `extensions.blocklist.enabled` -> `false`
- **[CRLite](https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/) filters**: `security.remote_settings.crlite_filters.enabled` -> `false`
- **Fingerprinting Protection Overrides**: `privacy.fingerprintingProtection.remoteOverrides.enabled` -> `false` *(Note that the overrides may still be fetched with this pref disabled; your browser will just ignore them)*
- **[Intermediate certificate](https://support.globalsign.com/ca-certificates/intermediate-certificates/overview-intermediate-certificates) downloads**: `security.remote_settings.intermediates.enabled` -> `false`
- **[Tracking blocklists](https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track)**: `browser.safebrowsing.provider.mozilla.lists` -> `disabled`

Note that disabling this functionality is **NOT** recommended.

### [Safe Browsing](https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work)

- `https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&*`
- `https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&*`
- `https://safebrowsing.ironfoxoss.org/v5/hashes:search?*`
- `https://safebrowsing.ironfoxoss.org/v5/hashLists:batchGet?*`

**Operator**: [IronFox OSS](https://ironfoxoss.org/) - *[Privacy policy](https://codeberg.org/celenity/Phoenix/wiki/Transparency#google-safe-browsing)*

**Purpose**: Provides real-time protection against malware and phishing *([Proxies `https://safebrowsing.googleapis.com`](https://gitlab.com/ironfox-oss/safebrowsing-proxy))*.

**Type(s) of data shared**: [Partial URL hashes upon potential matches](https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/), User Agent, public IP address.

**How often the connection occurs**: Every browser launch, and every 30 minutes after.

**Control**: You can use Google's standard, unproxied Safe Browsing endpoint instead of the IronFox proxy if preferred, by setting the following preferences in your [`about:config`](about:config):

- `browser.safebrowsing.provider.google4.gethashURL` -> `https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST`
- `browser.safebrowsing.provider.google4.updateURL` -> `https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST`
- `browser.safebrowsing.provider.google5.gethashURL` -> `https://safebrowsing.googleapis.com/v5/hashes:search?key=%GOOGLE_SAFEBROWSING_API_KEY%`
- `browser.safebrowsing.provider.google5.updateURL` -> `https://safebrowsing.googleapis.com/v5/hashLists:batchGet?key=%GOOGLE_SAFEBROWSING_API_KEY%`

**Or**, to disable Safe Browsing entirely:

- On **Desktop**, you can disable Safe Browsing by navigating to [`about:preferences#privacy`](about:preferences#privacy), scrolling down to the `Security` section, and unchecking the box to the left of `Block dangerous and deceptive content` *(under `Deceptive Content and Dangerous Software Protection`)*, **or** you can set `browser.safebrowsing.malware.enabled` & `browser.safebrowsing.phishing.enabled` to `false` in your [`about:config`](about:config).
- On **Android**, you can disable Safe Browsing by setting `browser.safebrowsing.features.malware.update` & `browser.safebrowsing.features.phishing.update` to `false` in your [`about:config`](about:config).

Note that disabling Safe Browsing is **NOT** recommended.

### [System Add-on Updates](https://firefox-source-docs.mozilla.org/toolkit/mozapps/extensions/addon-manager/SystemAddons.html#system-add-on-updates)

- `https://archive.mozilla.org/pub/system-addons/*`
- `https://aus5.mozilla.org/update/3/SystemAddons/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads and updates [system add-ons](https://firefox-source-docs.mozilla.org/toolkit/mozapps/extensions/addon-manager/SystemAddons.html).

**Type(s) of data shared**: Browser version, locale, OS, OS architecture, OS version, User Agent, public IP address.

**How often the connection occurs**: Hourly.

**Control**: You can disable this functionality by setting `extensions.systemAddon.update.enabled` to `false` in your [`about:config`](about:config); though this is **NOT** recommended.

### [uBlock Origin](Content-Blocking.md)

- `https://cdn.jsdelivr.net/gh/uBlockOrigin/uAssetsCDN@main/*` - *[Privacy Policy](https://www.jsdelivr.com/terms/privacy-policy)*
- `https://cdn.statically.io/gh/uBlockOrigin/uAssetsCDN/main/*` - *[Privacy Policy](https://statically.io/policies/privacy/)*
- `https://filters.adtidy.org/extension/ublock/filters/*` - *[Privacy Policy](https://adguard.com/privacy.html)*
- `https://gitlab.com/celenityy/BadBlock/-/raw/*` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://gitlab.com/celenityy/Phoenix/-/raw/*` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://gitlab.com/DandelionSprout/adfilt/-/raw/master/*` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/*` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://malware-filter.gitlab.io/urlhaus-filter/urlhaus-filter-ag-online.txt` - *[Privacy Policy](https://about.gitlab.com/privacy/)*
- `https://malware-filter.pages.dev/urlhaus-filter-ag-online.txt` - *[Privacy Policy](https://www.cloudflare.com/privacypolicy/)*
- `https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext`
- `https://publicsuffix.org/list/public_suffix_list.dat` - *[Privacy policy](https://www.mozilla.org/privacy/)*
- `https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist-basic.txt` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://raw.githubusercontent.com/yokoffing/filterlists/main/*` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://secure.fanboy.co.nz/*`
- `https://someonewhocares.org/hosts/hosts`
- `https://ublockorigin.github.io/uAssets/*` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://ublockorigin.github.io/uAssetsCDN/*` - *[Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)*
- `https://ublockorigin.pages.dev/*` - *[Privacy Policy](https://www.cloudflare.com/privacypolicy/)*

**Purpose**: Downloads and updates for filterlists and other resources in uBlock Origin.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Periodically.

**Control**: You can disable uBlock Origin from [`about:addons`](about:addons) within your web browser; though doing so is **NOT** recommended.

## Additional

The following are **optional**, **non-standard** connections your browser with Phoenix might make, depending on the features you decide to use.

### [Android debugging](https://firefox-source-docs.mozilla.org/devtools-user/about_colon_debugging/index.html#connecting-to-a-remote-device) *(**DESKTOP**)*

- `https://ftp.mozilla.org/pub/labs/devtools/adb-extension/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Installs the `Firefox DevTools ADB Extension` to provide support for debugging Firefox-based Android web browsers.

**Type(s) of data shared**: OS, OS architecture, User Agent, public IP address.

**How often the connection occurs**: When/if you select the option to `Enable USB Devices` *(under `Connect a Device`)* from [`about:debugging#/setup`](about:debugging#/setup), and hourly *(`extensions.update.interval`)* after.

**Control**: You can choose to not install the `Firefox DevTools ADB Extension` by not selecting the option to `Enable USB Devices`.

You can also disable updates for the `Firefox DevTools ADB Extension` by setting `extensions.adb@mozilla.org.update.enabled` to `false` in your [`about:config`](about:config), **or**, you can disable updates for the for the `Firefox DevTools ADB Extension` by navigating to [`about:addons`](about:addons), selecting `Firefox DevTools ADB Extension`, and selecting `Off` to the right of `Allow automatic updates`. Note that disabling updates for the `Firefox DevTools ADB Extension` is **NOT** recommended.

### [Firefox Sync](https://www.mozilla.org/firefox/features/sync/)

- `https://api.accounts.firefox.com/v1/account/attached_clients`
- `https://api.accounts.firefox.com/v1/account/devices?filterIdleDevicesTimestamp=*`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/info/collections`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/info/configuration`
- `https://sync-1-us-west1-g.sync.services.mozilla.com/1.5/*/storage/*`
- `https://token.services.mozilla.com/1.0/sync/1.5`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Syncs user data.

**Type(s) of data shared**: Types of data specified at [`about:preferences#sync`](about:preferences#sync) *([in encrypted form]((https://hacks.mozilla.org/2018/11/firefox-sync-privacy/))*, User Agent, public IP address.

**How often the connection occurs**: Every browser launch, periodically after, and upon selecting `Sync now` at [`about:preferences#sync`](about:preferences#sync) .

**Control**: You can choose to not use Firefox Sync, **or** on **Desktop**, you can sign-out if you've already set it up from [`about:preferences#sync`](about:preferences#sync). On **Desktop**, you can **also** disable Firefox Sync entirely by setting `identity.fxaccounts.enabled` to `false` in your [`about:config`](about:config).

If preferred, you can also [self-host](https://blog.diego.dev/posts/firefox-sync-server/) Firefox Sync.

### [Geolocation](https://support.mozilla.org/kb/does-firefox-share-my-location-websites)

- `https://api.beacondb.net/v1/geolocate`

**Operator**: [BeaconDB](https://beacondb.net/) - *[Privacy policy](https://beacondb.net/privacy/)*

**Purpose**: Provides geolocation for **Windows**, and serves as a fallback when the system's geolocation provider is unavailable for other platforms.

**Type(s) of data shared**: Strength and general information of nearby cellular towards and Wi-Fi networks *(if available/supported)*, User Agent, public IP address.

**How often the connection occurs**:

- **Windows**: When/if you grant a website permission to access your location.
- **non-Windows**: When/if you grant a website permission to access your location **and** if your system's geolocation provider is unavailable.

**Control**: You can simply choose not to grant websites permission to access your location, **or** you can disable the network geolocation provider entirely by setting `geo.provider.use_mls` to `false` in your [`about:config`](about:config); though doing so **WILL** break geolocation on **Windows**, and may cause issues with geolocation on other platforms if OS geolocation provider is unavailable.

You can also change the network geolocation provider if desired by setting the value of `geo.provider.network.url` to your preferred URL in the [`about:config`](about:config).

### *Manual* Add-on Updates *(**DESKTOP**)*

- `https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=2&...`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads updates for installed extensions and themes.

**Type(s) of data shared**: Identifiers of installed add-ons, Current versions of installed add-ons, Browser version, User Agent, public IP address.

**How often the connection occurs**: When/if you select the option to `Check for Updates` *(Found when selecting the gear to the right of `Manage Your Extensions`)* from [`about:addons`](about:addons).

**Control**: You can avoid manually checking for updates, if desired.

### [New Tab Wallpapers](https://support.mozilla.org/kb/customize-your-wallpapers) *(**DESKTOP**)*

- `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/newtab-wallpapers-v2/*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads wallpapers for Firefox Home *([`about:home`](about:home))*.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Upon setting the `browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled` preference in your [`about:config`](about:config) to `true`, and every browser launch after.

**Control**: You can avoid setting `browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled` to `true` in your [`about:config`](about:config), or set it to `false` if you previously enabled it.

### [Password Breach Alerts](https://support.mozilla.org/kb/firefox-password-manager-alerts-breached-websites) *(**DESKTOP**)*

- `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxmonitor-breaches/changeset?_expected=...`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Downloads [information regarding data breaches](https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxmonitor-breaches/changeset?_expected=0) to notify users if their information has been compromised.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Periodically if the Password Manager is enabled, which is done by checking the box to the left of `Ask to save passwords` *(under the `Passwords` section)* at [`about:preferences#privacy`](about:preferences#privacy), **or** by setting `signon.rememberSignons` to `true` in your [`about:config`](about:config).

**Control**: You can disable this functionality by unchecking the box to the left of `Show alerts about passwords for breached websites` *(under the `Passwords` section)* at [`about:preferences#privacy`](about:preferences#privacy), **or** by setting `signon.management.page.breach-alerts.enabled` to `false` in your [`about:config`](about:config).

### [Weather](https://support.mozilla.org/kb/how-it-works-firefox-weather) *(**DESKTOP**)*

- `https://merino.services.mozilla.com/api/v1/suggest?q=*&providers=accuweather&request_type=weather&sid=*`

**Operator**: [Mozilla](https://www.mozilla.org/) - *[Privacy policy](https://www.mozilla.org/privacy/)*

**Purpose**: Displays weather updates on Firefox Home *([`about:home`](about:home))*.

**Type(s) of data shared**: User Agent, public IP address.

**How often the connection occurs**: Upon setting the `browser.newtabpage.activity-stream.showWeather` preference in your [`about:config`](about:config) to `true`, **or** upon enabling `Weather` on your [`about:home`](about:home) or [`about:preferences#home`](about:preferences#home), and every browser launch after.

**Control**: You can avoid setting `browser.newtabpage.activity-stream.showWeather` to `true` in your [`about:config`](about:config), or set it to `false` if you previously enabled it. **Or** you can toggle `Weather` to `false` by selecting the gear on the bottom right on your [`about:home`](about:home), **or** you can uncheck the box to the left of `Weather` at [`about:preferences#home`](about:preferences#home).
