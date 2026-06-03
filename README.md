<div align="center">

[Homepage](https://phoenix.celenity.dev)
| [Wiki](https://codeberg.org/celenity/Phoenix/Wiki)
| [Contributing](#contributing)

![Phoenix](./assets/phoenix_wide.png)

# [Phoenix](https://phoenix.celenity.dev)

**Phoenix is a suite of configurations & advanced modifications for Mozilla
Firefox, designed to put the user first - with a focus on privacy, security,
freedom, functionality, & usability.** [Here a detailed list of Phoenix's
features & enhancements](https://phoenix.celenity.dev/features).

</div>

> [!NOTE]
> **Thunderbird users should consider taking a look at
> [Dove](https://dove.celenity.dev) - Phoenix's sister project.**

## 📖 Table of Contents

- [Phoenix](#phoenix)
  - [Table of Contents](#table-of-contents)
  - [About Phoenix](#about-phoenix)
    - [How Phoenix Works](#how-phoenix-works)
    - [Motivation](#motivation)
    - [Want to join Phoenix community?](#want-to-join-phoenix-community)
  - [Installation](#installation)
    - [Install](#install)
    - [Extended](#extended)
    - [Specialized configs](#specialized-configs)
    - [Manual installation](#manual-installation)
      - [Using extended or a specialized config manually](#using-extended-or-a-specialized-config-manually)
  - [Contributing](#contributing)
  - [Licensing](#licensing)
  - [Notices](#notices)
  - [Attribution](#attribution)

## About Phoenix

### How Phoenix works

Phoenix works by leveraging Firefox's
[AutoConfig](https://support.mozilla.org/kb/customizing-firefox-using-autoconfig)
& [Enterprise Policies](https://mozilla.github.io/policy-templates/)
functionality, and is installed on top of your standard, official Firefox
installation. **This allows us to go above and beyond what a simple `user.js`
file can offer, without the security risks a fork can introduce**. For example,
forks often fall behind on Firefox updates,
**which can leave users open to severe, detrimental vulnerabilities.** Phoenix's
approach allows users to continue receiving immediate updates, directly from
Mozilla.

Phoenix's approach also provides users with a seamless experience that is
accessible and easy to use. Gone are the days of creating `override` files,
manually keeping track of updates, resetting old preferences, & adding your
`user.js` file to each and every profile you make. **Not only is Phoenix the
most effective & comprehensive approach to configuring Firefox, it is also the
most accessible & easiest to use.**

Phoenix's changes to Firefox are carefully considered based on extensive
research & studying of Firefox's inner workings. **Phoenix is designed to
maintain website compatibility and to avoid breakage as much as possible, while
still substantially improving privacy & security compared to vanilla Firefox &
most other web browsers.** For users who **are** fine with breakage and want to
go even further in enhancing their privacy & security, Phoenix also offers an
**Extended** configuration. This is completely optional and primarily recommended
for advanced users. For more information on Phoenix's compatibility with websites
and known issues, please [see here](https://phoenix.celenity.dev/compat).

Additionally, **Phoenix disables various anti-features & strives to put the user
back in control of their browsing experience.** Phoenix also includes quality of
life enhancements, performance improvements, and other 'goodies' where possible
and where it doesn't compromise user privacy or security.

At the end of the day, above all else:

**Phoenix is designed from the ground up to always put the user first.**

> [!IMPORTANT]
> **⚠️ All users MUST read the [Wiki](https://phoenix.celenity.dev/wiki)
> before proceeding. The [Important](https://phoenix.celenity.dev/important) &
> [Limitations](https://phoenix.celenity.dev/limitations) pages are of extra importance!!**

### 💪 Motivation

Believe it or not, in the not so distant past, browsers were designed to put the
user first. There's a reason that another word to refer to them is
[**user agent**](https://wikipedia.org/wiki/User_agent)...

Sadly, this time has passed. The majority of browser marketshare is now
controlled by Google, an ad surveillance company. In all fairness to Google,
they **do** put their customers first - it's just that their customers are the
advertisers they siphon data to, not users like you and me. And this is the
company behind the engine powering nearly every modern web browser in the world.
Talk about a conflict of interest...

Unfortunately, most of the competition is no better - Just take a look at
[Microsoft & the 800 ad companies they share your data with](https://proton.me/blog/outlook-is-microsofts-new-data-collection-service)...

It doesn't have to be this way.

### Want to join Phoenix Community?

We'd love to see you over on [Matrix](https://matrix.to/#/#celenity:unredacted.org) *(Recommended)* and [Discord](https://discord.gg/TsADPVDerv)!

## 🚀 Installation

| Platform | Derivatives | Stable | ESR | Forks / Other                     | Support Status                                            |
| -------- | ----------- | ------ | --- | --------------------------------- | --------------------------------------------------------- |
| Android  | -           | ✅     | ❌  | [IronFox](https://ironfoxoss.org) | Official                                                  |
| Arch     | Partial     | ✅     | ❌  | -                                 | Official + Community                                      |
| Debian   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Fedora   | No          | ✅     | ❌  | -                                 | Official                                                  |
| Flatpak  | -           | ✅     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Gentoo   | Yes         | ✅     | ✅  | -                                 | Community                                                 |
| macOS    | -           | ✅     | ❌  | -                                 | Official                                                  |
| NixOS    | Yes         | ✅     | ❌  | -                                 | Official + Community                                      |
| Snap     | -           | ❌     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Ubuntu   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Windows  | -           | ✅     | ❌  | Zen Browser                       | [Partial](https://codeberg.org/celenity/Phoenix/issues/3) |

Also see: [Repology](https://repology.org/project/phoenix-firefox/versions).

1. *Flatpak targets `org.mozilla.firefox` package.*
2. *Gentoo GNU/Linux supports stable and ESR builds via both binary and source compilation.*

Other platforms have unfortunately proven difficult to support, though progress
is being made. Contributions are always welcome and appreciated.

### Install

> [!IMPORTANT]
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first
> run with Phoenix installed. **This ensures all of Phoenix's changes are applied...**

See: [docs/install](docs/install.md)

### 🔥 Extended

For advanced users who would like to go above & beyond when protecting their
privacy & security, at the cost of occasional breakage, Phoenix offers an
**Extended** configuration. **For a list of features specific to [Phoenix Extended,
please see here](https://phoenix.celenity.dev/extended)**.

See: [docs/extended](docs/extended.md)

### 💡 Specialized Configs

It should also be noted that Phoenix contains specialized configurations for
**Apple Maps**, **Discord**, **Element**, **Google Maps**, **Twitter**, and
**YouTube**. These configurations are designed to be used in their own, separate
Firefox profile, and provide means to safely and easily use these services, like
you would any other app on your device.

See: [docs/specialized-configs](docs/specialized-configs.md)

### 📛 Manual Installation

> [!CAUTION]
>**This is NOT recommended for most users.**

By default, Phoenix is installed & updated via your operating system's package
manager. This allows for fast, easy updates & fixes as needed, right with the
rest of your system!

However, if this is not desirable for you & your situation, or you would simply
like to use Phoenix on an unsupported operating system, you can follow this
tutorial:

See: [docs/install](docs/install.md)

#### 🤔 Using Extended or a Specialized Config Manually

With a manual installation of Phoenix, if you would like to use Phoenix's
[extended](#-extended) config, or one of our
[specialized configs](#-specialized-configs), you'll need to follow:

See: [docs/specialized-configs](docs/specialized-configs.md)

## Contributing

You can help by contributing code or by telling others about Phoenix. Reach out
to us and let us know how you want to help.

- Build instructions: [docs/build](docs/build.md)

## ⚖️ Licensing

Phoenix is licensed under the
[GNU General Public License v3.0 or later](https://spdx.org/licenses/GPL-3.0-or-later.html)
*(`GPL-3.0-or-later`)* where applicable.

## 🏛️ Notices

This is not an officially supported Mozilla product. Phoenix is in no way
affiliated with Mozilla.

Phoenix is not sponsored or endorsed by Mozilla.

## 💜 Attribution

Huge thank you to the following projects & individuals for making Phoenix
possible. Please show them support!

| Projects & Names                                                                                                                                                                                                                                                                                                                                                                       | Notes                                                                                                                                                                                                                                                                     | License                                                                          | Donate                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|-----------------------------------------------------|
| [Seyed Mohamad Amin Modaresi](https://codeberg.org/gnu1)                                                                                                                                                                                                                                                                                                                               | Designed Phoenix's icon *(derived from Xonotic, see below)*, created the install & uninstall scripts, helped with maintenance/packaging, assisted with README formatting, provided general advice & support, and responsible for various other significant contributions. | -                                                                                | -                                                   |
| [GW72](https://codeberg.org/GW72)                                                                                                                                                                                                                                                                                                                                                      | Invaluable feedback and support of the project.                                                                                                                                                                                                                           | -                                                                                | -                                                   |
| [Xonotic](https://xonotic.org): [Severin Meyer](https://sev.dev)                                                                                                                                                                                                                                                                                                                       | [Designed Phoenix's icon](https://gitlab.com/xonotic/xonotic/-/commit/9f43d6b9ffbed8b4e19b11e99afe98ea40df1814)                                                                                                                                                           | [GPLv3 or later](https://gitlab.com/xonotic/xonotic/-/blob/master/COPYING)       | -                                                   |
| [Arkenfox](https://github.com/arkenfox/user.js): [Thorin-Oakenpants](https://github.com/thorin-Oakenpants), [earthlng](https://github.com/earthlng), [claustromaniac](https://github.com/claustromaniac)                                                                                                                                                                               | -                                                                                                                                                                                                                                                                         | [MIT](https://github.com/arkenfox/user.js/blob/master/LICENSE.txt)               | -                                                   |
| [Betterfox](https://github.com/yokoffing/Betterfox): [yokoffing](https://github.com/yokoffing)                                                                                                                                                                                                                                                                                         | Certain preferences (Mostly performance-related)                                                                                                                                                                                                                          | [MIT](https://github.com/yokoffing/Betterfox/blob/main/LICENSE)                  | [Donate](https://github.com/sponsors/yokoffing)     |
| [Narsil's mozilla.cfg](https://codeberg.org/Narsil/mozilla.cfg): [Narsil](https://codeberg.org/Narsil)                                                                                                                                                                                                                                                                                 | Certain preferences + inspiration                                                                                                                                                                                                                                         | [GPLv3](https://codeberg.org/Narsil/mozilla.cfg/src/branch/master/LICENSE.txt)   | -                                                   |
| [Brace](https://codeberg.org/divested/brace): [Divested Computing Group](https://divested.dev)                                                                                                                                                                                                                                                                                         | Certain preferences + inspiration                                                                                                                                                                                                                                         | [AGPLv3](https://codeberg.org/divested/brace/src/branch/master/LICENSE)          | -                                                   |
| [LibreWolf](https://librewolf.net): [bgstack15](https://codeberg.org/bgstack15), [fxbrit](https://codeberg.org/fxbrit), [Malte Jürgens](https://codeberg.org/maltejur), [ohfp](https://codeberg.org/ohfp), [James McClain](https://codeberg.org/TheGreatMcPain), [threadpanic](https://codeberg.org/threadpanic), [Guillaume](https://codeberg.org/ltguillaume)                        | Inspiration + certain preferences & policies                                                                                                                                                                                                                              | [MPL-2.0](https://codeberg.org/librewolf/settings/src/branch/master/LICENSE.txt) | -                                                   |
| [firefox-config](https://codeberg.org/rusty-snake/firefox-config): [rusty-snake](https://codeberg.org/rusty-snake)                                                                                                                                                                                                                                                                     | Inspiration + certain preferences                                                                                                                                                                                                                                         | [CC0](https://codeberg.org/rusty-snake/firefox-config#license-cc0)               | -                                                   |
| [uBlock Origin](https://github.com/gorhill/uBlock): [Raymond Hill](https://github.com/gorhill), [ItsProfesssional](https://github.com/ItsProfessional), [MasterKia](https://github.com/MasterKia), [peace2000](https://github.com/peace2000), [Peter Lowe](https://pgl.yoyo.org), [PiQuark6046](https://github.com/piquark6046), [stephenhawk8054](https://github.com/stephenhawk8054) | Pre-installed extension - provides content blocking                                                                                                                                                                                                                       | [GPLv3](https://github.com/gorhill/uBlock/blob/master/LICENSE.txt)               | -                                                   |
| [Mullvad DNS](https://mullvad.net/help/dns-over-https-and-dns-over-tls): [Mullvad VPN AB](https://mullvad.net/about)                                                                                                                                                                                                                                                                   | Default DNS Over HTTPS Resolver                                                                                                                                                                                                                                           | [GPLv3](https://github.com/mullvad/dns-blocklists/blob/main/LICENSE.md)          | [Donate](https://opencollective.com/mullvad-vpn-ab) |
| And of course... [Firefox](hhttps://www.firefox.com/): [Mozilla](https://www.mozilla.org/)                                                                                                                                                                                                                                                                                             | -                                                                                                                                                                                                                                                                         | [MPL-2.0](https://www.mozilla.org/foundation/licensing)                          | [Donate](https://foundation.mozilla.org/donate)     |

⭐ If you like this project, please consider giving it a star!
