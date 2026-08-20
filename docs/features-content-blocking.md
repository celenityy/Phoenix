# 🛑 Content Blocking

Everything to do with Content Blocking in Phoenix

Phoenix includes the [uBlock Origin](github.com/gorhill/uBlock) extension for strong protection against advertising, tracking, phishing, scams, annoyances, malicious activity, & more.

We include our own custom configuration, which is set up as follows:

> [!TIP]
> ✅ means the list is enabled by default.
>
> [ ] means the list is included, but not enabled by default.
>
> 😇 means that the list is enabled out of the box on standard installs of uBlock Origin.
>
> 🚀 means that that the list is added or enabled by Phoenix's custom config.



* <details><summary>Built-in</summary>

    * <details><summary>✅ uBlock filters 😇</summary>

        * [x] [uBlock filters – Ads](https://ublockorigin.github.io/uAssets/filters/filters.txt) 😇
        * [x] [uBlock filters – Badware risks](https://ublockorigin.github.io/uAssets/filters/badware.txt) 😇
        * [x] [uBlock filters – Privacy](https://ublockorigin.github.io/uAssets/filters/privacy.txt) 😇
        * [x] [uBlock filters – Quick fixes](https://ublockorigin.github.io/uAssets/filters/quick-fixes.txt) 😇
        * [x] [uBlock filters – Unbreak](https://ublockorigin.github.io/uAssets/filters/unbreak.txt) 😇

        </details>
</details>

* <details><summary>Ads</summary>

    * [x] [EasyList](https://ublockorigin.github.io/uAssets/thirdparties/easylist.txt) 😇
    * [ ] [AdGuard – Ads](https://filters.adtidy.org/extension/ublock/filters/2_without_easylist.txt)
    * [x] [AdGuard - Mobile Ads](https://filters.adtidy.org/extension/ublock/filters/11.txt) 🚀

</details>

* <details><summary>Privacy</summary>

    * [x] [EasyPrivacy](https://ublockorigin.github.io/uAssets/thirdparties/easyprivacy.txt) 😇
    * [x] [➗ Actually Legitimate URL Shortener Tool](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt) 🚀
    * [x] [🖱️ BadBlock - Click Tracking](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/click-tracking.txt) 🚀
    * [x] [🔍 Block third party fonts](https://raw.githubusercontent.com/yokoffing/filterlists/main/block_third_party_fonts.txt) 🚀
    * [x] [⛔ yokoffing's click2load filters](https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt) 🚀
    * [ ] [AdGuard Tracking Protection](https://filters.adtidy.org/extension/ublock/filters/3.txt)
    * [x] [AdGuard URL Tracking Protection](https://filters.adtidy.org/extension/ublock/filters/17.txt) 🚀
    * [x] [Block Outsider Intrusion into LAN](https://ublockorigin.github.io/uAssets/filters/lan-block.txt) 🚀

</details>

* <details><summary>Malware protection, security</summary>

    * [x] [⚠️ BadBlock - Unsafe](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/unsafe.txt) 🚀
    * [x] [💊 Dandelion Sprout's Anti-Malware List](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt) 🚀
    * [x] [🔏 HaGeZi - Dynamic DNS](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/dyndns.txt) 🚀
    * [ ] [🔮 HaGeZi - Most Abused TLDs](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/spam-tlds-ublock.txt) 🚀
    * [ ] [🔐 HaGeZi - Threat Intelligence Feeds](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/tif.txt) 🚀
    * [ ] [🔐 HaGeZi - Threat Intelligence Feeds - Medium](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/tif.medium.txt) 🚀
    * [x] [🔐 HaGeZi - Threat Intelligence Feeds - Mini](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/tif.mini.txt) 🚀
    * [x] [FMHY Unsafe sites filterlist](https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist-basic.txt) 🚀
    * [x] [Online Malicious URL Blocklist](https://malware-filter.gitlab.io/urlhaus-filter/urlhaus-filter-ag-online.txt) 😇
    * [ ] [Phishing URL Blocklist](https://malware-filter.gitlab.io/phishing-filter/phishing-filter.txt)

</details>

* <details><summary>Multipurpose</summary>

    * [x] [Peter Lowe’s Ad and tracking server list](https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext) 😇
    * [ ] [🔇 BadBlock](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/badblock.txt) 🚀
    * [ ] [⚡️ BadBlock Lite](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/badblock_lite.txt) 🚀
    * [x] [🔥 BadBlock+](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/badblock_plus.txt) 🚀
    * [ ] [📗 HaGeZi - Multi LIGHT](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/light.txt) 🚀
    * [ ] [📘 HaGeZi - Multi NORMAL](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/multi.txt) 🚀
    * [ ] [📒 HaGeZi - Multi PRO](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.txt) 🚀
    * [ ] [📒 HaGeZi - Multi PRO mini](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.mini.txt) 🚀
    * [ ] [📙 HaGeZi - Multi PRO++](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.plus.txt) 🚀
    * [ ] [📙 HaGeZi - Multi PRO++ mini](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.plus.mini.txt) 🚀
    * [ ] [📕 HaGeZi - Multi ULTIMATE](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/ultimate.txt) 🚀
    * [x] [📕 HaGeZi - Multi ULTIMATE mini](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/ultimate.mini.txt) 🚀
    * [x] [Dan Pollock’s hosts file](https://someonewhocares.org/hosts/hosts) 🚀
    * [ ] [Divested Combined Blocklist](https://divested.dev/hosts-domains-wildcards) 🚀
    * [ ] [oisd](https://big.oisd.nl/) 🚀
    * [ ] [Steven Black (Unified)](https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts) 🚀

</details>

* <details><summary>Cookie notices</summary>

* [x] [EasyList - Cookie Notices](https://ublockorigin.github.io/uAssets/thirdparties/easylist-cookies.txt) 🚀

* [ ] [AdGuard - Cookie Notices](https://filters.adtidy.org/extension/ublock/filters/18.txt)

</details>

* <details><summary>Social widgets</summary>

    * [x] [EasyList - Social Widgets](https://ublockorigin.github.io/uAssets/thirdparties/easylist-social.txt) 🚀
    * [ ] [AdGuard - Social Widgets](https://filters.adtidy.org/extension/ublock/filters/4.txt)

</details>

* <details><summary>Annoyances</summary>

    * <details><summary>✅ EasyList - Annoyances 🚀</summary>

        * [x] [EasyList - Chat Widgets](https://ublockorigin.github.io/uAssets/thirdparties/easylist-chat.txt) 🚀
        * [x] [EasyList – Newsletter Notices](https://ublockorigin.github.io/uAssets/thirdparties/easylist-newsletters.txt) 🚀
        * [x] [EasyList - Notifications](https://ublockorigin.github.io/uAssets/thirdparties/easylist-notifications.txt) 🚀
        * [x] [EasyList - Other Annoyances](https://ublockorigin.github.io/uAssets/thirdparties/easylist-annoyances.txt) 🚀

        </details>
    * [ ] [😇 BadBlock - Ethical Whitelist](https://gitlab.com/celenityy/BadBlock/-/raw/pages/abp/ethical_whitelist.txt) 🚀
    * [ ] [⚙️ Dandelion Sprout's Annoyances List](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AnnoyancesList) 🚀
    * [ ] [🎰 HaGeZi - Gambling](https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/gambling.txt) 🚀
    * [ ] [🔞 oisd nsfw](https://nsfw.oisd.nl/) 🚀

    * <details><summary>AdGuard - Annoyances</summary>

        * [ ] [AdGuard - Mobile App Banners](https://filters.adtidy.org/extension/ublock/filters/20.txt)
        * [ ] [AdGuard – Other Annoyances](https://filters.adtidy.org/extension/ublock/filters/21.txt)
        * [ ] [AdGuard – Popup Overlays](https://filters.adtidy.org/extension/ublock/filters/19.txt)
        * [ ] [AdGuard – Widgets](https://filters.adtidy.org/extension/ublock/filters/22.txt)

        </details>
    * [ ] [Bypass Paywalls Clean filters](https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt) 🚀
    * [x] [uBlock filters – Annoyances](https://ublockorigin.github.io/uAssets/filters/annoyances.txt) 🚀
    * [ ] [YouTube Neuter](https://raw.githubusercontent.com/mchangrh/yt-neuter/main/yt-neuter.txt) 🚀
    * [ ] [YouTube Neuter - SponsorBlock Supplement](https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/sponsorblock.txt) 🚀

</details>


> [!NOTE]
> Do not unnecessarily combine lists. For instance, if you use `HaGeZi - Multi ULTIMATE`, you should disable `HaGeZi - Multi LIGHT, NORMAL, PRO, & PRO++`. Same for the `BadBlock` lists. This will unnecessarily increase your attack surface and degrade your performance, while not providing any gain or actual benefit, since all rules covered by lower tiers are also covered by the higher tiers.

We would generally recommend users stick to our default selection of lists - as they are carefully considered and of the highest quality possible. The other lists we build in can be desirable though depending on you, your device, and your personal preference.

If you have any suggestions for lists we should add - or feel that any should be removed, please reach out and/or file an issue!
