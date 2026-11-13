# Privacy Notice

*See also: [Network Connections](./transparency-network-connections)*.

The bottom line is: Phoenix does not collect, store, or sell any personal data.

We ensure that all tracking features and telemetry included in Firefox are completely disabled on a best-effort basis.

Your browsing activity is entirely private, and we make no attempt to monitor or track your online behavior.

## Table of Contents

- [First Party](#first-party)
  - [Downloads](#downloads)
  - [uBlock Origin Assets](#ublock-origin-assets)
  - [Captive Portal Detection](#captive-portal-detection)
  - [Connectivity Checks](#connectivity-checks)
- [Third Party](#third-party)
  - [Mozilla](#mozilla)
  - [Search](#search)
  - [DNS over HTTPS](#dns-over-https)
  - [Google Safe Browsing](#google-safe-browsing)
  - [Geolocation](#geolocation)
  - [uBlock Origin](#ublock-origin)

## First Party

### Downloads

Phoenix is typically downloaded and installed from your operating system's package manager. Depending on your operating system,
these are delivered via:
- On macOS: [celenity's Homebrew Tap Repository](https://gitlab.com/celenityy/tap)
- On Arch Linux: [AUR](https://aur.archlinux.org/packages/phoenix-arch)
- On Debian/Ubuntu: [celenity's OBS repository](https://build.opensuse.org/project/show/home:celenity)
- On Fedora Linux/openSUSE: [celenity's COPR repository](https://copr.fedorainfracloud.org/coprs/celenity/copr)

No sensitive data is shared with these parties besides your IP address.

For details on how your data is processed and used, each provider and their privacy policy is listed below:
- macOS: [GitLab](https://about.gitlab.com/privacy/)
- Arch Linux: [Arch Linux](https://terms.archlinux.org/docs/privacy-policy/)
- Debian/Ubuntu: [openSUSE](https://en.opensuse.org/Privacy_Policy)
- Fedora Linux/openSUSE: [Fedora](https://docs.fedoraproject.org/en-US/legal/privacy/)

**At your own risk**, to disable this functionality, you may install Phoenix [manually](./install-manual).

### uBlock Origin Assets

Phoenix's [uBlock Origin configuration](./features-content-blocking) is downloaded and periodically updated from `assets.celenity.dev`.

[This configuration](https://assets.celenity.dev/ublock/phoenix/assets.json) is used for enabling and disabling filterlists in uBlock Origin,
and for adding non-standard filterlists to uBlock Origin.
It also includes [a blocklist](https://assets.celenity.dev/ublock/badlists.txt) of filterlists known to cause issues with uBlock Origin,
as well as lists that include overly generic whitelisting, and whitelists that some invasive services co-erce users to enable.

`assets.celenity.dev` is hosted on [Calibour](https://calibour.com/). With the exception of your IP address, no sensitive or identifying data
is shared with Calibour.

For details on how Calibour processes and uses data, see [their privacy policy](https://calibour.com/privacy.html).

See [the `uBlock Origin` section of the `Network Connections` page](./transparency-network-connections#ublock-origin)
for more information on this functionality and how you can control it.

uBlock Origin's use of third-party services is [also documented below](#ublock-origin).

### Captive Portal Detection

Phoenix does not enable captive portal detection by default, due to privacy and security concerns. However, if this functionality is enabled,
Phoenix uses the `captive.celenity.dev` endpoint.

`captive.celenity.dev` is hosted on [Calibour](https://calibour.com/). With the exception of your IP address, no sensitive or identifying data
is shared with Calibour.

See [the `Captive Portal Detection` section of the `Network Connections` page](./transparency-network-connections#captive-portal-detection)
for more information on this functionality and how you can control it.

### Connectivity Checks

Phoenix does not enable connectivity checks by default, due to privacy and security concerns. However, if this functionality is enabled,
Phoenix uses the `captive.celenity.dev` endpoint.

`captive.celenity.dev` is hosted on [Calibour](https://calibour.com/). With the exception of your IP address, no sensitive or identifying data
is shared with Calibour.

See [the `Connectivity Checks` section of the `Network Connections` page](./transparency-network-connections#connectivity-checks)
for more information on this functionality and how you can control it.

## Third Party

### Mozilla

While Phoenix disables Firefox's data collection mechanisms and other non-essential services, it still relies on Mozilla for infrastructure that
provides critical functionality.

For details on what this functionality entails and what specific data is shared, as well as how you can disable it if desired, please see
the [`Network Connections` page](./transparency-network-connections).

For details on how Mozilla processes and uses data, see [their privacy policy](https://www.mozilla.org/privacy/firefox/).

### Search

Phoenix's default search engine is [DuckDuckGo](https://duckduckgo.com/), due to its strong focus on privacy, high quality results, and upstanding reputation.

For details on how DuckDuckGo processes and uses data, see [their privacy policy](https://duckduckgo.com/privacy).

See [the `Search Engine Inclusion Criteria` page](./info-search-criteria) for
more details on how Phoenix considers search engines providers for inclusion, as well as
a list of Phoenix's other included providers and their privacy policies.

Phoenix even gives you the option to use no search engine at all!

It should also be noted that Phoenix disables "search suggestions" by default, meaning that **the only data sent to your search engine of choice is what you explicitly choose to send it**.

### DNS over HTTPS

Phoenix enables DNS over HTTPS (without Fallback), with [Quad9](https://quad9.net/) as the default resolver.

DNS over HTTPS provides a substantial improvement to privacy and security over standard DNS resolution, so it is in line with Phoenix's goals to
enable.

Quad9 specifically was chosen as Phoenix's default resolver due to their strict privacy policy, strong track record,
support for DNSSEC validation, and protection under Swiss jurisdiction, in addition
[to meeting our strong criteria](./info-doh-criteria#requirements).

Additionally, Quad9 provides real-time protection against malicious domains, further improving security for users.

For details on how Quad9 processes and uses data, see [their privacy policy](https://quad9.net/privacy/policy/).

See [the `DNS over HTTPS Provider Inclusion Criteria` page](./info-doh-criteria) for
more details on how Phoenix considers DNS over HTTPS providers for inclusion, as well as
a list of Phoenix's other included providers and their privacy policies.

Also see [the `DNS over HTTPS` section of the `Network Connections` page](./transparency-network-connections#dns-over-https) for more information on this functionality and how you can control it.

### Google Safe Browsing

By default, Phoenix uses Google's Safe Browsing technology to provide real-time protection against malicious domains and downloaded files.

You can see [here](https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/) and [here](https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work) to better understand how this works,
as well as what specific data is shared and to whom.

Note that Phoenix **only** performs checks for downloaded files locally.

Additionally, Phoenix **proxies** connections to Google Safe Browsing (`safebrowsing.googleapis.com`) via our
own endpoint (`safebrowsing.ironfoxoss.org`). This is similar to the approach of
[Brave](https://support.brave.com/hc/articles/15222663599629-Safe-Browsing-in-Brave) and
[Safari](https://www.zdnet.com/article/apple-will-proxy-safe-browsing-traffic-on-ios-14-5-to-hide-user-ips-from-google/).
**This means that your IP address is never exposed to Google Servers.**

This proxy is hosted on [Cloudflare R2 Storage](https://developers.cloudflare.com/r2/) under the
[European Union jurisdiction](https://developers.cloudflare.com/r2/reference/data-location/#available-jurisdictions).
Additionally, Cloudflare's [Observability/Worker Logs](https://developers.cloudflare.com/workers/observability/logs/workers-logs/) are
explicitly disabled.

As the name suggests, this same proxy/instance is used by IronFox, and you can see the
proxy's implementation [here](https://codeberg.org/ironfox-oss/safebrowsing-proxy).

See [Google's privacy policy](https://policies.google.com/privacy) and [Cloudflare's privacy policy](https://www.cloudflare.com/privacypolicy/) for
details on how your data is processed and used.

See [the `Safe Browsing` section of the `Network Connections` page](./transparency-network-connections#safe-browsing) for more information
on this functionality and how you can control it.

### Geolocation

Some websites may request access to your geolocation for various functionality.

**Your geolocation is only shared with websites that you explicitly allow to access it**.
Phoenix blocks websites from requesting access to geolocation by default, meaning that you are always in control.
As the user, you will explicitly determine who you want to share your location with, when, and even if at all.

We generally recommend avoiding granting websites the geolocation permission if possible, as it's typically unnecessary and
the functionality it provides can be accomplished through other means.
However, if you do need this functionality, we **highly** recommend you set it to **Always Ask** instead of **Allow**,
so that you have more fine-grained control of when your location is used and by whom.
**Please only grant this permission to websites you trust!**

When you grant a website the location permission, in order to determine your position, Phoenix uses:

- On macOS: Apple Location Services *(with [BeaconDB](https://beacondb.net/) as a fall-back)*
- On other platforms: [BeaconDB](https://beacondb.net/)

For background, BeaconDB is a free and open, privacy-focused location service. It was created as the
spiritual successor to [Mozilla Location Services](https://wikipedia.org/wiki/Mozilla_Location_Service).

It is important to note that BeaconDB is a new service, so its data is limited, and it may not have coverage for your area.
While this is not ideal, BeaconDB is one of the few privacy-respecting services available, so its better than no support at all.

For details on how BeaconDB processes and uses data, see [their privacy policy](https://beacondb.net/privacy/).

See [the `Geolocation` section of the `Network Connections` page](./transparency-network-connections#geolocation) for more details on
what data is shared and how you can control this functionality.

**On macOS**: Instead of using BeaconDB, Phoenix attempts to use Apple Location Services for geolocation by default, due to the increased accuracy of
Apple Location Services, as well as Apple's strong privacy policies *(unlike other platform providers, i.e. Google and Microsoft)*.
BeaconDB is only used as a fall-back if Apple Location Services are unavailable.

See [Apple's privacy policy](https://www.apple.com/legal/privacy/data/en/location-services/) to learn more about what data is shared
and how this data is processed. You can also check out
[Apple's Whitepaper](https://www.apple.com/privacy/docs/Location_Services_White_Paper_Nov_2019.pdf) for more details on how their
Location Services were designed.

### uBlock Origin

Out of the box, Phoenix includes the [uBlock Origin](https://github.com/gorhill/uBlock) browser extension to provide users with
strong content blocking.

For details on how uBlock Origin processes and uses data, see [their privacy policy](https://github.com/gorhill/uBlock/wiki/Privacy-policy).

uBlock Origin fetches assets and filterlists from various third-parties.
See [the `uBlock Origin` section of the `Network Connections` page](./transparency-network-connections#ublock-origin) for a
list of the specific connections made, as well as more information about the providers and their privacy policies.
