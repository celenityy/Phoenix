# Website Compatibility

This page serves to document websites *(and extensions)* that have issues with Phoenix and why, as well as fixes if applicable.

Please [report breakage](https://codeberg.org/celenity/bugs/issues/new?template=.github%2fISSUE_TEMPLATE%2f5-web-compat-phoenix.yaml) as you encounter it!

**Note for users of Android 10 and lower**:

In order to fix display of emojis *(See [here](https://tmh.conlang.org/emoji-language/all-emoji.html) for a testing page)*, you may
need to add `-FontVisibilityBaseSystem,-FontVisibilityLangPack` to `browser.phoenix.fingerprintingProtection.global.userOverrides`
*(or `privacy.fingerprintingProtection.overrides`, depending on your platform/Phoenix installation)*.

## Table of Contents

- [Extensions](#extensions)
  - [Native Messaging](#native-messaging)
  - [WebAssembly](#webassembly-csp)
- [Websites](#websites)
  - [DRM](#drm)
  - [JIT](#jit)
  - [Media Autoplay Blocking Policy](#media-autoplay-blocking-policy)
  - [SharedArrayBuffer](#sharedarraybuffer)
  - [WebGPU](#webgpu)
- [Extended](#extended)
  - [Cross-origin Referer Policy](#cross-origin-referer-policy)
  - [Timezone Spoofing](#timezone-spoofing)
  - [WebAssembly](#webassembly)
- [Additional](#additional)
  - [Tracker Referer Policy](#tracker-referer-policy)

## Extensions

This section covers extensions known to have issues as a result of Phoenix's configuration.

### Native Messaging

The following extensions require native messaging:

- [Bitwarden](https://addons.mozilla.org/addon/{446900e4-71c2-419f-a6a7-df9c091e268b}): Required for biometrics
- [KDE Plasma Integration](https://addons.mozilla.org/addon/plasma-browser-integration@kde.org): [Required for core functionality](https://codeberg.org/celenity/bugs/issues/419)
- [KeePassXC-Browser](https://addons.mozilla.org/addon/keepassxc-browser@keepassxc.org): [Required for core functionality](https://codeberg.org/celenity/bugs/issues/419)

To re-enable native messaging, **at the cost of privacy and security**, set the following preferences at [`about:config`](about:config):

- `webextensions.native-messaging.max-input-message-bytes` -> `1048576`
- `webextensions.native-messaging.max-output-message-bytes` -> `2147483647`

### WebAssembly CSP

The following extensions require WebAssembly (WASM) *(which Phoenix blocks with its hardened extension CSP policies)*:

- [Proton Pass](https://addons.mozilla.org/addon/78272b6fa58f4a1abaac99321d503a20@proton.me): [Required for password generation and buttons to work properly](https://codeberg.org/celenity/bugs/issues/493)

- [Yomitan](https://addons.mozilla.org/addon/{6b733b82-9261-47ee-a595-2dda294a4d08}): Required to download dictionaries *([1](https://codeberg.org/celenity/bugs/issues/146), [2](https://github.com/yomidevs/yomitan/issues/2122))*

To re-enable WebAssembly for extensions, **at the cost of security**, set the following preference at [`about:config`](about:config):

- `extensions.webextensions.base-content-security-policy.v3` -> `script-src 'self' 'wasm-unsafe-eval'; upgrade-insecure-requests;`

## Websites

This section covers websites known to have issues as a result of Phoenix's **base** configuration.

### DRM

The following websites are known to require DRM for media playback:

- `www.amazon.com`: Required for Prime Video
- `www.netflix.com`
- `app.plex.tv`: Required for content provided by Plex, does not impact local media
- `open.spotify.com` *([Details](https://codeberg.org/celenity/bugs/issues/498))*

### JIT

The following websites require Baseline JavaScript Just-in-time Compilation *(JIT)*:

- Discourse instances: [Fixes performance issues when entering text](https://codeberg.org/celenity/bugs/issues/441)
  - ex.
    - `coop.pavilion.tech`
    - `discourse.gnome.org`
    - `discuss.privacyguides.net`
    - `discussion.dsausa.org`
    - `forums.mst3k.com`
    - `meta.discourse.org`

To re-enable Baseline JIT, **at the cost of security**, set the following preference at [`about:config`](about:config), and restart your
browser:

- `javascript.options.baselinejit` -> `true`

### Media autoplay blocking policy

The following websites require relaxing the media autoplay blocking policy:

**NOTE**: The value the media autoplay blocking policy should be set to is provided to the right of the site below.

If the value is `1`, the website **also** works when the value of the media autoplay blocking policy is set to `0`.

- `www.cnn.com`: Required for video playback *([Ex.](https://www.cnn.com/2025/03/11/europe/analysis-ukraine-russia-ceasefire-proposal-intl-latam/index.html))* - **`0`**

- `www.instagram.com`: [Required to play stories and reels](https://codeberg.org/ironfox-oss/bugs/issues/53) - **`1`** *(This is currently Phoenix's default value, this is just documented mainly for reference)*

To relax the cross-origin referer policy, set the following preference at [`about:config`](about:config) to the value provided above:

- `media.autoplay.blocking_policy`

### SharedArrayBuffer

The following websites require `SharedArrayBuffer` via `window.postMessage`:

- `demo.actualbudget.org`: [Required for core functionality](https://codeberg.org/celenity/bugs/issues/488)
- `eden.net.nz`: [Required for](https://codeberg.org/celenity/bugs/issues/488) [the `SharedArrayBuffer` test](https://eden.net.nz/test/sab.html)
- `typst.app`: Required for core functionality

To re-enable `SharedArrayBuffer ` via `window.postMessage`, **at the cost of security**, set the following preference
at [`about:config`](about:config), and restart your browser:

- `dom.postMessage.sharedArrayBuffer.withCOOP_COEP` -> `true`

### WebGPU

The following websites require WebGPU:

- `toji.github.io`: Required for core functionality
- `webgpu.github.io`: Required for core functionality
- `threejs.org`: Required for core functionality

To re-enable WebGPU, **at the cost of privacy and security**, set the following preference at [`about:config`](about:config):

- `dom.webgpu.enabled` -> `true`

## Extended

This section covers websites known to have issues as a result of Phoenix's **extended** configuration.

### Cross-origin Referer Policy

The following websites require relaxing the cross-origin referer policy:

**NOTE**: The value the cross-origin referer policy should be set to is provided to the right of the site below.

If the value is `1`, the website **also** works when the value of the cross-origin referer policy is set to `0`.

- `anicrush.to`: Required for video playback - **`0`**
- `animepahe.ru`: [Required for video playback](https://codeberg.org/celenity/bugs/issues/144) - **`0`**
- `aniwatchtv.to`: Required for video playback - **`0`**
- `appleid.apple.com`: Required for display of certain icons *(such as the "X" in the top left corner of the box when adding a payment method)* - **`1`**
- `arc018.to`: Required for video playback - **`0`**
- `batcave.biz`: [Required for core functionality](https://codeberg.org/celenity/bugs/issues/512) - **`1`**
- `www.chipotle.com`: Required for order checkout/payment - **`0`**
- `www.cineby.app`: [Required for video playback](https://codeberg.org/celenity/bugs/issues/472) - **`0`**
- `cloutgist.com`: [Required for URL shortening](https://codeberg.org/celenity/bugs/issues/511) - **`1`**
- `comick.io`: [Required for display of `Updates`/certain content](https://codeberg.org/celenity/bugs/issues/491) - **`1`**
- `www.crazygames.com`: Required for [various games](https://www.crazygames.com/game/tag-2-3-4-players) - **`1`**
- `www.eenadu.net`: [Required for core functionality](https://github.com/webcompat/web-bugs/issues/149964) - **`1`**
- `www.epicgames.com`: Required for account sign-in - **`1`**
- `m.fanfox.net`: Required for [display of images/manga](https://m.fanfox.net/manga/spy_x_family/c070/1.html) - **`0`**
- `www.farming-simulator.com`: [Required for `ModHub` images to display](https://github.com/webcompat/web-bugs/issues/151669) - **`0`**
- `drive.google.com`: Required for video playback - **`0`**
- `photos.google.com`: Required for video playback - **`0`**
- `amazon-web.grubhub.com`: Required for core functionality - **`1`**
- `hianimez.to`: Required for video playback - **`0`**
- `hitomi.la`: [Required for display of images](https://codeberg.org/celenity/bugs/issues/480) - **`0`**
- `webapp.hongkongpost.hk`: [Required for entering tracking numbers](https://github.com/webcompat/web-bugs/issues/150611) - **`1`**
- `hoyolab.com`: [Required for log-in](https://codeberg.org/celenity/bugs/issues/489) - **`1`**
- `hoyoverse.com`: [Required for log-in](https://codeberg.org/celenity/bugs/issues/489) - **`1`**
- `www.instagram.com`: [Required for display of external embeds](https://codeberg.org/ironfox-oss/bugs/issues/55) *([Ex.](https://www.ndtv.com/entertainment/bharti-singh-and-husband-haarsh-limbachiyaa-announce-pregnancy-see-trending-post-2646359))* - **`0`**
- `www.ivpn.net`: Required for payment - **`1`**
- `www.jasonhealth.com`: [Required for search](https://codeberg.org/celenity/bugs/issues/145) - **`0`**
- `www.jerseymikes.com`: Required for order checkout/payment - **`0`**
- `www.kraken.com`: Required for account log-in/sign-up - **`1`**
- `www.oretibole.xyz`: Required for video playback from `xhamster.com` - **`0`**
- `www.panerabread.com`: Required for placing orders - **`1`**
- `www.pixiv.net`: Required for display of images - **`0`**
- `www.pogo.com`: Required for playing games - **`0`**
- `poki.com`: Required for [playing games](https://poki.com/en/g/subway-surfers) - **`0`**
- `www.quranbookk.com`: [Required for core functionality](https://codeberg.org/ironfox-oss/bugs/issues/28) - **`1`**
- `app.raindrop.io`: [Required for web previews](https://codeberg.org/celenity/phoenix-codeberg-issues/issues/106) - **`0`**
- `sportal.bg`: [Required for display of comments](https://codeberg.org/ironfox-oss/bugs/issues/92) *([Ex.](https://sportal.bg/news-2025050418545143780))* - **`0`**
- `twitter.com`/`x.com`: Required for display of images in DMs - **`1`**
- `uflix.cc`: Required for video playback - **`0`**
- `vimm.net`: Required to download games and display screenshots - **`1`**
- `login.yahoo.com`: Required for core functionality - **`0`**

To relax the cross-origin referer policy, **at the cost of privacy**, set the following preference at [`about:config`](about:config)
to the value provided above:

- `network.http.referer.XOriginPolicy`

### Timezone Spoofing

The following websites require timezone spoofing for certain functionality, depending on your use case:

- `www.nytimes.com`: Required for Wordle

To disable timezone spoofing on a per-website basis, add the following to the value of
`browser.phoenix.fingerprintingProtection.granular.userOverrides`
*(or `privacy.fingerprintingProtection.granularOverrides`, depending on your platform/Phoenix installation)*:

**NOTE**: Replace `example.com` below with the **base** domain of the website you would like to override this protection for.

*(Ex. if I wanted to disable a protection for `www.example.com`, I would use `example.com` instead below)*

- `{"firstPartyDomain": "example.com", "overrides": "-JSDateTimeUTC"}`

### WebAssembly

The following websites require WebAssembly *(WASM)*:

- `agar.io`: Required for core functionality
- `anicrush.to`: Required for video playback
- `aniwatchtv.to`: Required for video playback
- `arc018.to`: Required for video playback
- `search.brave.com`: Required for CAPTCHAs
- `www.chess.com`: Required for core functionality
- `www.cineby.app`: Required for video playback
- `www.coolmathgames.com`: Required for various games
- `www.crazygames.com`: Required for various games
- `discord.com`: Required for `DAVE` *(E2EE calling)*
- `www.duolingo.com`: Required for core functionality
- `www.emulatrix.com`: Required for core functionality
- `auth.ente.io`: Required for core functionality
- `play.fancade.com`: [Required for core functionality](https://github.com/webcompat/web-bugs/issues/149972)
- `www.fandango.com`: Required for various functionality *(ex. `Sign-in` and `FanRewards Points`)*
- `binbashbanana.github.io`: Required for core functionality
- `binji.github.io`: Required for core functionality
- `grubbyplaya.github.io`: Required for core functionality
- `rb44a.github.io`: Required for core functionality
- `udbsite.github.io`: Required for core functionality
- `vinmannie.github.io`: Required for core functionality
- `earth.google.com`: Required for core functionality
- `hianimez.to`: Required for video playback
- `keyoxide.org`: Required to verify [certain account proofs](https://keyoxide.org/1bbdc23d1853255d6415d2ec814edf851aab370e)
- `kick.com`: Required for core functionality
- `www.jamesfmackenzie.com`: Required for [Commander Keen](https://www.jamesfmackenzie.com/chocolatekeen/)
- `krunker.io`: Required for core functionality
- `leptos.dev`: [Required for the counter button](https://github.com/webcompat/web-bugs/issues/150255)
- `web.libretro.com`: Required for core functionality
- `mathplayzone.com`: Required for core functionality
- `moviezapiya.fun`: [Required for core functionality](https://codeberg.org/celenity/bugs/issues/507)
- `p-bandai.com`: Required for selecting items on the front page
- `www.photopea.com`: Required for core functionality
- `poki.com`: Required for [various games](https://poki.com/en/g/red-ball-4)
- `pass.proton.me`: Required for core functionality
- `wallet.proton.me`: Required for core functionality
- `twitter.com`/`x.com`: Required for E2EE messaging
- `reg.usps.com`: Required for account sign-in
- `tools.usps.com`: [Required for core functionality](https://github.com/webcompat/web-bugs/issues/149837)
- `vimm.net`: Required for playing games
- `vizzy.io`: Required for core functionality
- `zombs.io`: Required for core functionality

- Cinny instances: Required for core functionality
  - ex.
    - `app.cinny.in`
    - `cinny.norge.chat`
    - `cinny.pendora.io`
    - `cinny.rollenspiel.chat`
    - `cinny.the-apothecary.club`
    - `cinny.we2.ee`
- Element instances: Required for core functionality
  - ex.
    - `element.4d2.org`
    - `chat.archaeo.social`
    - `element.arcticfoxes.net`
    - `aria.im`
    - `chat.bark.lgbt`
    - `element.bitcoinist.org`
    - `element.catgirl.cloud`
    - `element.chagai.website`
    - `element.chatwave.org`
    - `riot.club1.fr`
    - `talk.comm.cx`
    - `element.data.coop`
    - `element.debian.social`
    - `chat.digitalprivacy.diy`
    - `element.duesen.chat`
    - `app.element.io`
    - `gnome.element.io`
    - `element.envs.net`
    - `chat.fedoraproject.org`
    - `element.flieger.chat`
    - `chat.fox.yt`
    - `element.frei.chat`
    - `element.freiburg.social`
    - `chat.fsfe.org`
    - `element.g24.at`
    - `element.gemeinsam.jetzt`
    - `matrix.glasgow.social`
    - `element.gnulinux.club`
    - `element.grapheneos.org`
    - `riot.grin.hu`
    - `conversation.hadoly.fr`
    - `element.hot-chilli.im`
    - `matrix.hyteck.de`
    - `element.imagisphe.re`
    - `webchat.kde.org`
    - `element.kosmikdog.eu`
    - `matrix.libreon.fr`
    - `chat.magdeburg.jetzt`
    - `chat.mozilla.org`
    - `mtrx.nz`
    - `element.neat.chat`
    - `matrix.nichi.co`
    - `app.nitro.chat`
    - `element.nope.chat`
    - `element.norge.chat`
    - `chat.oblak.be`
    - `chat.pcriot.org`
    - `element.private.coffee`
    - `chat.pub.solar`
    - `rollenspiel.chat`
    - `chat.socialnetwork24.com`
    - `chat.soziale.cloud`
    - `chat.studichat.de`
    - `web.synod.im`
    - `chat.tchncs.de`
    - `element.tedomum.net`
    - `element.unredacted.org`
    - `chat.utwente.io`
    - `we2.ee`
    - `element.yatrix.org`
- FluffyChat instances: Required for core functionality
  - ex.
    - `fluffychat.norge.chat`
- Hydrogen instances: Required for core functionality
  - ex.
    - `hydrogen.norge.chat`
    - `hydrogen.private.coffee`
- SchildiChat instances: Required for core functionality
  - ex.
    - `schildichat.the-apothecary.club`
- Vercel Security: Required for core functionality
  - ex.
    - [`cakepay.com`](https://codeberg.org/celenity/bugs/issues/484)

To re-enable WebAssembly, **at the cost of security**, set the following preference at [`about:config`](about:config):

- `javascript.options.wasm` -> `true`

### WebRTC

The following websites require relaxing WebRTC handling:

- `discord.com`: Required for calling
  - **In addition to the preferences** below, Discord *also* requires setting `media.peerconnection.ice.default_address_only` to `false`
- `twitter.com`/`x.com`: Required for speaking in spaces

To relax WebRTC handling, **at the cost of privacy**, set the following preferences at [`about:config`](about:config):

- `media.peerconnection.ice.no_host` -> `false`
- `media.peerconnection.ice.relay_only` -> `false`

## Additional

This section covers additional notable instances of breakages that are **not** caused by Phoenix's default preferences.

These are primarily just documented for reference.

### Tracker Referer Policy

The following websites require relaxing the referer policy for trackers:

- `www.instagram.com`: [Required for external embeds to display properly](https://codeberg.org/ironfox-oss/bugs/issues/55) *([Ex.](https://www.ndtv.com/entertainment/bharti-singh-and-husband-haarsh-limbachiyaa-announce-pregnancy-see-trending-post-2646359))*

- YouTube embeds: Required for core functionality
  - ex.
    - [`itch.io`](https://codeberg.org/celenity/Phoenix/pulls/228#issuecomment-10051167)

To relax the referer policy for trackers, **at the cost of privacy**, set the following preference at [`about:config`](about:config):

- `network.http.referer.defaultPolicy.trackers` -> `2`
