# 👁️ Privacy Notice

*Also see [Network Connections](./Transparency-Network-Connections.md) for more details*.

Privacy Considerations when using Phoenix

**1.** Phoenix does not collect any data of any kind. It is impossible for us to even if we wanted to, due to the nature of this project.

**2.** Phoenix will **never** sell your data or use your data for any kind of tracking/profiling.

**3.** Phoenix will **never** expose your data to 3rd parties without clear user consent unless explicitly outlined here or elsewhere.

## 1st Party

### uBlock Origin Assets

With Phoenix installed, uBlock Origin may connect to `https://gitlab.com/celenityy/Phoenix/-/raw/pages/uBlock/assets.json` for updates to [our configuration](https://phoenix.celenity.dev/content-blocking). This configuration is primarily used for enabling and disabling filterlists in uBlock Origin by default, and for adding non-standard filterlists to uBlock Origin.

uBlock Origin may also connect to `https://gitlab.com/celenityy/Phoenix/-/raw/pages/uBlock/badlists.txt` - which contains a blocklist of filterlists known to cause issues with uBlock Origin, overly generic whitelisting, and whitelists that some invasive services co-erce users to enable.

`assets.json` and `badlists.txt` [are hosted on GitLab](https://gitlab.com/celenityy/Phoenix/-/tree/pages/uBlock); with the exception of your IP address, no sensitive or identifying data is shared with GitLab. See GitLab's privacy policy [here](https://about.gitlab.com/privacy/).

See more details on other connections uBlock Origin might make [below](#ublock-origin).

## 3rd Parties

### Mozilla

While we fully disable telemetry, studies, crash reports, diagnostics, & any other form of data collection that we can from Firefox, we still rely on Mozilla for infrastructure that provides critical functionality. This functionality may include but is not limited to:

* **Browser Updates**
* **Browsing, Downloading, & Updating Extensions & Plug-ins**
* **Certificate Revocation Checks**
* **Downloading & Updating Mozilla's blocklist for malicious & unsafe add-ons, plugins, & graphics drivers**
* **Downloading & Updating Mozilla's Tracking Protection database**
* **Signing/Verification of requests**
* **Mozilla's 'Remote Settings' Service**

You can check out [Mozilla's Privacy Policy](https://www.mozilla.org/privacy/firefox/) here to better understand what kind of data is collected by these services & how it is handled. You can also see Mozilla's documentation [here](https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections) for more info & to learn how you can disable this functionality. **Note that Phoenix neuters or disables most of the functionality outlined in Mozilla's privacy policy & documentation that isn't specified above**

Additionally, while not enabled by default, Phoenix also supports [Firefox Sync](https://www.mozilla.org/firefox/features/sync/). Firefox Sync uses E2EE, **meaning Mozilla has no access to your sensitive browsing data**. You can learn more about what data is collected & how it's handled by Mozilla [here](https://www.mozilla.org/privacy/firefox/#sync) & [here](https://www.mozilla.org/privacy/mozilla-accounts/). You can also learn more about Sync's design [here](https://hacks.mozilla.org/2018/11/firefox-sync-privacy/).

### Search

Firefox's default search engine is currently Google. This is **not** the case for Phoenix.

Phoenix's default search engine is [DuckDuckGo](https://duckduckgo.com/), due to its strong focus on privacy, high quality results, and good reputation.

See DuckDuckGo's privacy policy [here](https://duckduckgo.com/privacy) for information on what data they collect & how they handle it.

**In addition to DuckDuckGo & Firefox's built-in search engines, Phoenix also adds the following for you to choose from**:

* DuckDuckGo (HTML) - [Privacy Policy](https://duckduckgo.com/privacy)
* DuckDuckGo (Lite) - [Privacy Policy](https://duckduckgo.com/privacy)
* Mojeek - [Privacy Policy](https://www.mojeek.com/about/privacy/)
* Startpage - [Privacy Policy](https://www.startpage.com/en/privacy-policy/)

Phoenix even gives you the option to use no search engine at all!

It should also be noted that Phoenix disables "search suggestions" by default, meaning that **the only data sent to your search engine of choice is explicitly what you choose to send it.**

### Google Safe Browsing

By default, Firefox (& Phoenix) make use of Google's Safe Browsing technology to provide real-time protection against malicious domains & downloaded files. You can see [here](https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/) and [here](https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work) to better understand how this works, as well as what specific data is shared and to whom.

Out of the box, if Firefox can't determine the safety of a file you download, it may send metadata of the downloaded file to Google. Phoenix disables this functionality, meaning that downloaded files are **only** checked locally.

It should also be noted that unlike standard installations of Firefox, Phoenix **proxies** connections to Google Safe Browsing (`safebrowsing.googleapis.com`) via our own endpoint (`safebrowsing.ironfoxoss.org`). This is similar to the approach of [Brave](https://support.brave.com/hc/articles/15222663599629-Safe-Browsing-in-Brave) and [Safari](https://www.zdnet.com/article/apple-will-proxy-safe-browsing-traffic-on-ios-14-5-to-hide-user-ips-from-google/). **This means that your IP address is never exposed to Google Servers.** This proxy is hosted on [Cloudflare R2 Storage](https://developers.cloudflare.com/r2/) under the [European Union jurisdiction](https://developers.cloudflare.com/r2/reference/data-location/#available-jurisdictions). Additionally, Cloudflare's [Observability/Worker Logs](https://developers.cloudflare.com/workers/observability/logs/workers-logs/) are explicitly disabled. As the name suggests, this same proxy/instance is used by IronFox, and you can see the proxy's implementation [here](https://gitlab.com/ironfox-oss/safebrowsing-proxy).

You can see Google's privacy policy [here](https://policies.google.com/privacy) and Cloudflare's privacy policy [here](https://www.cloudflare.com/privacypolicy/).

### Mullvad

Phoenix enables DNS over HTTPS (without Fallback), with [Mullvad *(Base)*](https://mullvad.net/help/dns-over-https-and-dns-over-tls) as the default resolver.

DNS over HTTPS provides a substantial improvement to privacy and security over standard DNS resolution *(especially when compared to the default DNS servers operated by ISPs...)*, so we believe that it's in the best interest of our users to enable in this manner.

Mullvad *(Base)* was chosen as our default resolver due to their strict privacy policy, strong track record, support for DNSSEC validation, and protection under Swedish jurisdiction. You can check out their privacy policy for more details [here](https://mullvad.net/help/privacy-policy).

Additionally, **Mullvad *(Base)* provides protection against domains used for advertising, tracking, and malware.** This provides our users with enhanced protection and online safety.

**In addition to Mullvad *(Base)***, we also include the following carefully considered DNS providers as built-in options to choose from:

* **Cloudflare** - [`Unfiltered` privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/cloudflare-resolver-firefox/), [`Malware Protection` privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/public-dns-resolver/)
* **DNS4EU** - [Privacy Policy](https://www.joindns4.eu/privacy-policy)

You can disable this functionality or change providers via the `DNS over HTTPS` section found at `about:preferences#privacy`.

### Geolocation

Some websites may request access to your geolocation for various functionality.

**Your geolocation is only shared with websites that you explicitly grant permission to access it**. Phoenix disables Geolocation access to all websites by default *(no annoying prompts!)*- meaning you are always in control & will explicitly determine who you want to share your location with, when, & even if at all.

We would generally recommend avoiding granting websites this permission if possible, as it's typically unnecessary & the functionality it provides can be accomplished through other means. If you do need this functionality, we would **highly** recommend you set it to **Always Ask** instead of **Allow**, so that you have more fine-grained control of when your location is used & by whom. **Please only grant this permission to websites you trust!**

When you grant a website the location permission, in order to determine your position, Standard installations of Firefox will currently use Microsoft's Location Services on Windows, Apple's Location Services on macOS, & Google's Location Services on Linux & as a fallback for Windows & macOS.

Phoenix takes a different approach:

**We completely disable Microsoft Location Services & Google Location Services functionality**.

Geolocation for Windows and GNU/Linux users is currently provided by [BeaconDB](https://beacondb.net/). BeaconDB is a privacy-focused free & open location service, created as the spiritual successor to [Mozilla Location Services](https://wikipedia.org/wiki/Mozilla_Location_Service). It should be noted that this support (as well as BeaconDB itself) is **experimental**. Additionally, as BeaconDB is a new service, it may not have coverage for your area. While this is not ideal, we don't have many options unfortunately due to the closure of MLS. I'm not comfortable exposing the location or any sensitive data about my users to Google or Microsoft... so BeaconDB is better than no support at all. Feel free to submit your own data to improve it! See BeaconDB's privacy policy [here](https://beacondb.net/privacy/). Data sent may include nearby access points, cell towers, & the srength of those signals.

On macOS, by default, if enabled on the system, we use Apple's Location Services for geolocation, with BeaconDB acting as a fallback if Apple's services are unavailable. This provides macOS users with a more reliable & accurate geolocation service, but without compromising their privacy to ex. Google or Microsoft. See Apple's privacy policy [here](https://www.apple.com/legal/privacy/data/en/location-services/) to learn more about what data is shared & how this data is processed. You can also check out [Apple's Whitepaper](https://www.apple.com/privacy/docs/Location_Services_White_Paper_Nov_2019.pdf) for more details on how their Location Services are designed.

### uBlock Origin

Out of the box, Phoenix includes the [uBlock Origin](https://github.com/gorhill/uBlock) browser extension for strong content blocking. See uBlock Origin's privacy policy [here](https://github.com/gorhill/uBlock/wiki/Privacy-policy). By default, assets may be fetched from (but not limited to) the following:

* AdGuard - [Privacy Policy](https://adguard.com/privacy.html)
* Cloudflare - [Privacy Policy](https://www.cloudflare.com/privacypolicy/)
* [Fanboy](https://fanboy.co.nz)
* GitHub - [Privacy Policy](https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement)
* GitLab - [Privacy Policy](https://about.gitlab.com/privacy/)
* jsDelivr - [Privacy Policy](https://www.jsdelivr.com/terms/privacy-policy)
* Mozilla - [Privacy Policy](https://www.mozilla.org/privacy)
* Statically - [Privacy Policy](https://statically.io/policies/privacy/)
* [Yoyo Internet Services](https://yoyo.org/)

**No sensitive information is sent to any of these providers besides your IP address!**

Note that all of this also applies to any standard installation of uBlock Origin.

### Misc.

Phoenix currently receives updates via your operating system's package manager. On macOS, this is via [our own Homebrew Tap Repository](https://gitlab.com/celenityy/tap). On Arch Linux, this is via the [AUR](https://aur.archlinux.org/packages/phoenix-arch). On Debian/Ubuntu & derivatives, this is via [our OBS repository](https://build.opensuse.org/project/show/home:celenity). On Fedora Linux, this is done via [our COPR repository](https://copr.fedorainfracloud.org/coprs/celenity/copr).

No sensitive data is shared with GitLab, Arch Linux, makedeb, or the Fedora Project besides your IP address. See GitLab's privacy policy [here](https://about.gitlab.com/privacy/), Arch Linux's privacy policy [here](https://terms.archlinux.org/docs/privacy-policy/), and Fedora's privacy policy [here](https://docs.fedoraproject.org/en-US/legal/privacy/).

To disable this functionality, you may install Phoenix [manually](https://phoenix.celenity.dev/#manual-mode-not-recommended).

#### OCSP Checks

Phoenix may additionally connect to various 3rd party OCSP servers for revocation checks when a domain doesn't support CRLite and doesn't enable stapling. No sensitive information is shared in these cases besides your IP address. This is similar behavior to Standard Firefox *(though connections are made even less in our case due to our use of CRLite)*, and can be disabled from the `Security` section in `about:preferences#privacy`, **though disabling this is NOT recommended**.
