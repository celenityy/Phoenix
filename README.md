# ⚠️ **IMPORTANT UPDATE** - SEE [HERE](https://codeberg.org/celenity/Phoenix/issues/2)

# Phoenix

Phoenix is a suite of configurations & advanced modifications for Mozilla Firefox, designed to put the user first. It is not a simple user.js like you might expect - but it is not a fork either.

Phoenix strives to create the best browsing experience possible, and does so through significantly improving user privacy, security, and freedom. We also include various other QOL tweaks, performance enhancements, & nice-to-have features where possible.

**It is highly recommended for all users to read our Wiki [here](https://phoenix.celenity.dev/wiki)**

# Motivation

Believe it or not, in the not so distant past, browsers were designed to put the user first. There's a reason that another word to refer to them is [**user agent**](https://wikipedia.org/wiki/User_agent).

Sadly, this time has passed. The majority of browser marketshare is now controlled by Google, an ad surveillance company. In all fairness to Google, they **do** put their customers first - it's just that their customers are the advertisers they siphon data to, not users like you and me. And this is the company behind the engine powering nearly every modern web browser in the world. Talk about a conflict of interest...

Unfortunately, most ot the competition is no better - Just take a look at [Microsoft & the 800 ad companies they share your data with](https://proton.me/blog/outlook-is-microsofts-new-data-collection-service)...

But it doesn't have to be this way.

# Features

See [here](https://codeberg.org/celenity/Phoenix/wiki/Features) for a non-exhaustive list of features & enhancements Phoenix provides.

You should also check out our [Comparison table](https://codeberg.org/celenity/Phoenix/wiki/Comparison), so that you can see what Phoenix offers and how it compares to similar projects in the space.

# Install

Phoenix offers easy to use install scripts for various platforms. All you have to do is have Firefox installed & ready, paste the command that corresponds to your platform of choice in your terminal, and you should be good to go. :)

**(Note: The Firefox Flatpak is currently **not** supported for Linux distributions)**

### Arch Linux *(yay)*:

`sudo bash -c "$(curl -fsSL https://phoenix.celenity.dev/arch_install_yay.sh)"`

### Arch Linux *(paru)*:

`sudo bash -c "$(curl -fsSL https://phoenix.celenity.dev/arch_install_paru.sh)"`

### Fedora Linux:

`sudo bash -c "$(curl -fsSL https://phoenix.celenity.dev/fedora_install.sh)"`

### macOS:
***(Note: You must have [Homebrew](https://brew.sh/) installed)***

`bash -c "$(curl -fsSL https://phoenix.celenity.dev/macos_install.sh)"`

### Windows:

In the future, I'd like to support Windows - however I'm currently unable to do so, primarily because of the fact that I don't use Windows, and I'm not aware of any way to package our policies through a package manager like Chocolatey without using the platform. **If anyone can help with this, or has any ideas in general, it would be very much appreciated!!**

___

# Complete Coverage

Out of the box, [Phoenix in its 'base' configuration is already substantially hardened compared to vanilla Firefox & most of its derivatives](https://codeberg.org/celenity/Phoenix/wiki/Comparison).

However, we make it a point to balance privacy, security, & usability. We try to avoid breakage where possible.

If you're an advanced user, and would like to go the extra mile, at the cost of mild breakage & a little headache, you can install our **Hardened** config.

**Unlike our base config, Hardened is profile specific.** This means that you can use our hardened config as needed when you desire the extra protection, & revert back to our base through another profile for everything else. 

Personally, if you're up for it, I would highly recommend trying out the Hardened config, and setting overrides as needed *(Phoenix makes this very easy to do through the `about:config`)*. You can see [here](https://codeberg.org/celenity/Phoenix/wiki/Web-Compat#hardened) for a list of known sites with issues & what you need to toggle to fix them. 

**This is not for everyone though, and if you want a 'just works' set-up with no issues or tweaking, just stick to the base config.**

To install **Hardened**

**1:** Install **Base** through the script for your platform of choice above.

**2:** Download the user.js file from [here](https://phoenix.celenity.dev/configs/Hardened/user.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

`wget https://phoenix.celenity.dev/configs/Hardened/user.js`

If you use any of the [Firefox-Fix-UI](https://github.com/black7375/Firefox-UI-Fix) CSS skins, you should instead download your user.js file from [here](https://phoenix.celenity.dev/configs/Hardened/Firefox-UI-Fix/user.js), or run the following command in your terminal:

`wget https://phoenix.celenity.dev/configs/Hardened/Firefox-UI-Fix/user.js`

**3:** Find your profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will probably be different, and you should replace this path on the next step with your actual profile directory's path.**

**4:** Simply move your user.js to your profile's directory! You can either drag and drop it manually, or run the following command:

`mv user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js`

Congratulations, you're done. Similar to the rest of the Phoenix project, your prefs will auto-update, and you can set any overrides you wish through the about:config. You can just sit back, relax, & enjoy.

# Manual Mode *(Not recommended)*

By default, Phoenix leverages Mozilla's [Centralized Management](https://support.mozilla.org/kb/customizing-firefox-using-autoconfig#w_centralized-management) feature to automatically update its configurations. This allows fast, easy updates & fixes as needed, regardless of your platform. Phoenix's Policies are updated separately, through [COPR](https://copr.fedorainfracloud.org/coprs/retold3202/Phoenix-Policies/) on Fedora & our [Homebrew](https://brew.sh/) [Tap](https://codeberg.org/celenity/Dove-Policies-macOS) on macOS. **This is typically set-up & handled through our install scripts, and this is the set-up we would recommend most users stick to.**

However, if this is not desirable for you & your situation, you can manually install Phoenix with the following steps:

**1:** Download our `base.cfg` file [here](https://phoenix.celenity.dev/base.cfg). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

`wget https://phoenix.celenity.dev/base.cfg`

**2:** Download `local-settings.js` from [here](https://phoenix.celenity.dev/manual/defaults/pref/local-settings.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

`wget https://phoenix.celenity.dev/manual/defaults/pref/local-settings.js`

**3:** Download `policies.json` from [here](https://phoenix.celenity.dev/policies/Policies/policies.json) if you're on macOS/Windows, or [here](https://phoenix.celenity.dev/policies/Linux/Policies/policies.json) if you're on Linux. You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

If on macOS/Windows:

`wget https://phoenix.celenity.dev/policies/Policies/policies.json`

If on Linux:

`wget https://phoenix.celenity.dev/policies/Linux/Policies/policies.json`

**4:** Locate your Firefox installation directory. This will vary depending on your platform, you can generally find it by navigating to `about:support` & checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/firefox/firefox` next to `Application Binary`. This means our installation directory is `/usr/lib64/firefox`, **Unless you're on Fedora Linux, your directory will probably be different, and you should replace this path on the following steps with your actual installation directory's path.**

**5:** Move `base.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command, assuming `/usr/lib64/firefox` is your installation directory:

`sudo mv base.cfg /usr/lib64/firefox/base.cfg`

**6:** If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults`, create another folder titled `pref`. You can do this manually through your file explorer, or assuming `/usr/lib64/firefox` is your installation directory, you can run the following command:

`sudo mkdir -p /usr/lib64/firefox/defaults/pref`

On macOS & Linux, you'll also want to ensure that the folder you created has proper permissions:

`sudo chmod 755 /usr/lib64/firefox/defaults/pref`

**7:** Move `local-settings.js` to the `pref` folder that you just created. Assuming your installation directory is `/usr/lib64/firefox`, you can run the following command:

`sudo mv local-settings.js /usr/lib64/firefox/defaults/pref/local-settings.js`

**8:** In the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or assuming `/usr/lib64/firefox` is your installation directory, you can run the following command:

`sudo mkdir -p /usr/lib64/firefox/distribution`

On macOS & Linux, you'll also want to ensure that the folder you created has proper permissions:

`sudo chmod 755 /usr/lib64/firefox/distribution`

**9:** Finally, move `policies.json` to the `distribution` folder that you just created. Assuming your installation directory is `/usr/lib64/firefox`, you can run the following command:

`sudo mv policies.json /usr/lib64/firefox/distribution/policies.json`

Congratulations, you're done. Enjoy Phoenix, and be sure to keep up with updates!

___


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
- [Quad9](https://quad9.net/)
	- [Quad9 Team](https://quad9.net/about/team/)
	- [Donate](https://www.quad9.net/donate/)
<br>

And of course...

- [Firefox](https://mozilla.org/firefox)
	- [Mozilla](https://www.mozilla.org/)
	- [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- [Donate](https://foundation.mozilla.org/donate/)