# Phoenix

Phoenix is a suite of configurations & advanced modifications for Mozilla Firefox, designed to put the user first.

Phoenix strives to create the best browsing experience possible, and does so through enhancing user privacy, security, and freedom. We also include various other QOL tweaks & nice-to-have features where possible.

# Install

Phoenix offers easy to use install scripts for various platforms. All you have to do is paste the command for your platform of choice in your terminal, and you should be good to go. :)

Fedora Linux:

`bash -c "$(curl -fsSL https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/fedora_install.sh)"`

# Features

See [here](https://codeberg.org/Magnesium1062/Phoenix/src/branch/main/docs/features.md) for a non-exhaustive list of features & enhancements Phoenix provides. 

# Limitations

Phoenix can not protect against all forms of advanced fingerprinting (unique identification of you & your device). Only [Tor Browser](https://www.torproject.org/) & [Mullvad Browser](https://mullvad.net/browser) can do that. If you are a journalist, political dissident, or an individual with an otherwise extreme [threat model](https://www.privacyguides.org/en/basics/threat-modeling/), please use one of those two browsers!!!

However, Phoenix:

* Blocks known fingerprinters through Firefox's Strict Tracking Protection & our configuration of uBlock Origin

* Enables Firefox's built-in [Fingerprinting Randomization](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting)

* Additionally, our 'Hardened' configuration enables Firefox's ["Resist Fingerprinting"](https://wiki.mozilla.org/Security/Fingerprinting) functionality, which provides even stronger fingerprinting protection, at the cost of seldom breakage & inconvenience.

# To Note

* Phoenix enables [DNS over HTTPS](ttps://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/) without fallback & routes traffic through [Quad9](https://quad9.net/) by default, due to the major privacy & security benefits this provides. You can change providers or disable DNS over HTTPS entirely (not recommended) in `about:preferences#privacy`

* By default, Phoenix clears site data on exit, due to the major privacy benefit this provides. Rather than disable this protection, I would strongly recommend users stick with it & make exceptions for sites they wish to ex. stay logged in to. However, if you truly wish to disable this sanitization, you can toggle it from `about:preferences#privacy` or set `privacy.clearOnShutdown.cookies`, `privacy.clearOnShutdown.offlineApps`, & `privacy.clearOnShutdown_v2.cookiesAndStorage` to `false` in your `about:config`.

* Phoenix completely removes & disables all DRM technology [due to the extreme privacy, security, & freedom concerns it poses](https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next). This means that certain proprietary streaming services won't play content or will only play content at a lower quality than anticipated. I would strongly recommend avoiding these types of streaming services entirely & instead consuming content by other means... but if you do insist on using them (not recommended), I would recommend either streaming this type of content from the provider's app or a separate device.

# Motivation

Believe it or not, in the not so distant past, browsers were designed to put the user first. There's a reason that another word to refer to them is [**user agent**](https://wikipedia.org/wiki/User_agent).

Sadly, this time has passed. The majority of browser marketshare is now controlled by Google, an ad surveillance company. In all fairness to Google, they **do** put their customers first - it's just that their customers are the advertisers they siphon data to, not users like you and me. And this is the company behind the engine powering nearly every modern web browser in the world. Talk about a conflict of interest...

But it doesn't have to be this way.

# Why Mozilla Firefox?

Firefox is one of the last engines standing in the way of Google's Chromium monopoly. The browser is also free, open source, & highly customizable. **There is simply no other browser out there that allows for the level of configuration that Phoenix provides.**

**Mozilla is far from perfect, but we believe Firefox is still the best browser on the market in terms of privacy & user freedom.**

# Why not just fork Firefox and create your own browser like LibreWolf?

**One Major reason: Security updates**. I am the only person working on this project, and I am not currently in a position to guarantee consistent & timely browser security updates. Things happen. The majority of browser forks are simply hobbyist & do not take matters like this seriously, but Phoenix is different: We put privacy & security at the forefront of everything we do. I am not willing to put my users at risk, now or ever.

**The fact of the matter is that due to Firefox's strong support for customization & advanced configuration, there's next to nothing that a browser fork can offer over just sticking to it as a base.**

# Attribution

Huge thank you to the following projects & individuals for making Phoenix possible. Please show them support!

- [Arkenfox](https://github.com/arkenfox/user.js)
	- [Thorin-Oakenpants](https://github.com/thorin-oakenpants) + [earthlng](https://github.com/earthlng) + [claustromaniac](https://github.com/claustromaniac)
	- [MIT](https://github.com/arkenfox/user.js/blob/master/LICENSE.txt)
<br>
- [Betterfox](https://github.com/yokoffing/Betterfox)
	- [yokoffing](https://github.com/yokoffing)
	- [MIT](https://github.com/yokoffing/Betterfox/blob/main/LICENSE)
    - [Donate](https://github.com/sponsors/yokoffing)
<br>
- [Narsil's mozilla.cfg](https://codeberg.org/Narsil/mozilla.cfg)
	- [Narsil](https://codeberg.org/Narsil)
	- [GPLv3](https://codeberg.org/Narsil/mozilla.cfg/src/branch/master/LICENSE.txt)
<br>
- [Brace](https://codeberg.org/divested/brace)
	- [Divested Computing Group](https://divested.dev/)
	- [GPLv3](https://codeberg.org/divested/brace/src/branch/master/LICENSE)
	- [Donate](https://divested.dev/pages/donate)
<br>
- [LibreWolf](https://librewolf.net/)
	- [bgstack15](https://codeberg.org/bgstack15) + [fxbrit](https://codeberg.org/fxbrit) + [Malte Jürgens](https://codeberg.org/maltejur) + [ohfp](https://codeberg.org/ohfp) + [James McClain](https://codeberg.org/TheGreatMcPain) + [threadpanic](https://codeberg.org/threadpanic) + [Guillaume](https://codeberg.org/ltguillaume)
	- [MPL-2.0](https://codeberg.org/librewolf/settings/src/branch/master/LICENSE.txt)
<br>
- [firefox-config](https://codeberg.org/rusty-snake/firefox-config)
	- [rusty-snake](https://codeberg.org/rusty-snake)
	- [CC0](https://codeberg.org/rusty-snake/firefox-config#license-cc0)
<br>
- [mobile-config-firefox](https://gitlab.com/postmarketOS/mobile-config-firefox)
	- [postmarketOS](https://postmarketos.org/)
	- [MPL-2.0](https://gitlab.com/postmarketOS/mobile-config-firefox/-/blob/master/LICENSE)
	- [Donate](https://opencollective.com/postmarketOS)
<br>
- [uBlock Origin](https://github.com/gorhill/uBlock)
	- [Raymond Hill](https://github.com/gorhill) + [ItsProfesssional](https://github.com/ItsProfessional) + [MasterKia](https://github.com/MasterKia) + [peace2000](https://github.com/peace2000) + [Peter Lowe](https://pgl.yoyo.org/) + [PiQuark6046](https://github.com/piquark6046) + [stephenhawk8054](https://github.com/stephenhawk8054)
	- [GPLv3](https://github.com/gorhill/uBlock/blob/master/LICENSE.txt)
<br>

And of course...

- [Firefox](https://mozilla.org/firefox)
	- [Mozilla](https://www.mozilla.org/)
	- [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- [Donate](https://foundation.mozilla.org/donate/)