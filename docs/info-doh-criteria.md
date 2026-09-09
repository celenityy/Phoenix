# 🛡️ DNS over HTTPS Provider Inclusion Criteria

The following page outlines requirements that **must** be met for a DNS over HTTPS provider to be included in Phoenix and Dove.

## Requirements

* The provider **SHOULD** not collect, log, or store user data.
* If user data is collected:
  * The data **MUST** not be used to track or profile users.
  * The data **MUST** not be "sold" or shared with third-parties without user content.
  * The data **MUST** not be able to de-anonymize or uniquely identify users.
  * The data **MUST** be used for the exclusive purpose of operating the DNS provider.
  * The data **MUST** have adequate protection against data/security breaches.
  * The data **MUST** be kept to a minimum, and retained for the minimum amount of time necessary.
* The provider **SHOULD** be part of [Mozilla's Trusted Recursive Resolver Program](https://wiki.mozilla.org/Security/DOH-resolver-policy).
* The provider **MUST** support [DNS Query Name Minimisation](https://datatracker.ietf.org/doc/html/rfc9156).
* The provider **MUST** not support [EDNS Client Subnet *(ECS)*](https://wikipedia.org/wiki/EDNS_Client_Subnet).
* The provider **MUST** enforce [DNSSEC](https://wikipedia.org/wiki/Domain_Name_System_Security_Extensions) for supported domains.
* The provider's domain(s) **MUST** be signed with [DNSSEC](https://wikipedia.org/wiki/Domain_Name_System_Security_Extensions).
* The provider **MUST** not block/filter domains for reasons that fall outside of the following categories:
  * Advertising
  * CSAM
  * Data collection
  * Malware
  * Phishing
  * Scam
  * Spam
  * Tracking
* The provider **SHOULD** be based out of a region with strong privacy laws.
* The provider **MUST** have a decent, upstanding reputation.
* The provider **MUST** have high availability/reliability.
* The provider **SHOULD** be reasonably fast/performant.

## Current Providers

Phoenix and Dove currently include the following providers, as they meet the above criteria:

* **Cloudflare** 
  * [Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/cloudflare-resolver-firefox/)
* **Cloudflare - `Malware Protection`**
  * [Privacy policy](https://developers.cloudflare.com/1.1.1.1/privacy/public-dns-resolver/)
* **DNS4EU - `Ad Blocking`**
  * [Privacy Policy](https://www.joindns4.eu/privacy-policy)
* **DNS4EU - `Protective`**
  * [Privacy Policy](https://www.joindns4.eu/privacy-policy)
* **DNS4EU - `Unfiltered`**
  * [Privacy Policy](https://www.joindns4.eu/privacy-policy)
* **DNSBunker**
  * [Privacy Policy](https://dnsbunker.org/privacy.html)
* **dnsforge.de - `Blank`**
  * [Privacy Policy](https://adminforge.de/datenschutz/)
* **dnsforge.de - `Hard`**
  * [Privacy Policy](https://adminforge.de/datenschutz/)
* **dnsforge.de - `Normal`**
  * [Privacy Policy](https://adminforge.de/datenschutz/)
* **Mullvad - `Base`**
  * [Privacy Policy](https://mullvad.net/help/privacy-policy)
* **Mullvad - `Unfiltered`**
  * [Privacy Policy](https://mullvad.net/help/privacy-policy)
