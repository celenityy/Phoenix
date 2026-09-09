# 🌐 Website Compatibility

Documenting websites (and extensions) that have issues with Phoenix & why, as well as fixes if applicable

Please report any breakage as you encounter it!

**Note for users of Android 10 and lower**:

In order to fix display of emojis *(See [here](https://tmh.conlang.org/emoji-language/all-emoji.html) for a testing page)*, you may need to add `-FontVisibilityBaseSystem,-FontVisibilityLangPack` to `privacy.fingerprintingProtection.overrides`

**Extensions**:

**[Bitwarden](https://addons.mozilla.org/addon/{446900e4-71c2-419f-a6a7-df9c091e268b})** - Requires `webextensions.native-messaging.max-input-message-bytes` set to `1048576` and `webextensions.native-messaging.max-output-message-bytes` set to `2147483647` for biometrics

**[KDE Plasma Integration](https://addons.mozilla.org/addon/plasma-browser-integration@kde.org)** - Requires `webextensions.native-messaging.max-input-message-bytes` set to `1048576` and `webextensions.native-messaging.max-output-message-bytes` set to `2147483647` *([https://codeberg.org/celenity/Phoenix/issues/219](https://codeberg.org/celenity/Phoenix/issues/219))*

**[KeePassXC-Browser](https://addons.mozilla.org/addon/keepassxc-browser@keepassxc.org)** - Requires `webextensions.native-messaging.max-input-message-bytes` set to `1048576` and `webextensions.native-messaging.max-output-message-bytes` set to `2147483647` *([https://codeberg.org/celenity/Phoenix/issues/219](https://codeberg.org/celenity/Phoenix/issues/219))*

**[Proton Pass](https://addons.mozilla.org/addon/78272b6fa58f4a1abaac99321d503a20@proton.me)** - Requires `extensions.webextensions.base-content-security-policy.v3` set to `script-src 'self' 'wasm-unsafe-eval'; upgrade-insecure-requests;` for password generation and buttons to work properly *([https://codeberg.org/celenity/Phoenix/issues/133](https://codeberg.org/celenity/Phoenix/issues/133))*

**[Yomitan](https://addons.mozilla.org/addon/{6b733b82-9261-47ee-a595-2dda294a4d08})** - Requires `extensions.webextensions.base-content-security-policy.v3` set to `script-src 'self' 'wasm-unsafe-eval'; upgrade-insecure-requests;` to download dictionaries *([https://gitlab.com/celenityy/Phoenix/-/issues/4](https://gitlab.com/celenityy/Phoenix/-/issues/4) + [https://github.com/yomidevs/yomitan/issues/2122](https://github.com/yomidevs/yomitan/issues/2122))*

**Websites**:

demo.**actualbudget.org** - Requires `dom.postMessage.sharedArrayBuffer.withCOOP_COEP` set to `true` for core functionality - *https://codeberg.org/celenity/Phoenix/issues/139*

www.**amazon.com** *(Prime Video)* - Requires DRM for video playback

search.**brave.com** - Requires permission granted to extract *(randomized)* canvas data for Maps functionality

**bsky.app** - Requires permission granted to extract *(randomized)* canvas data to add a profile picture

www.**coolmathgames.com** - Some games may require permission granted to extract *(randomized)* canvas data

**Discourse** instances *(ex. `coop.pavilion.tech`, `discourse.gnome.org`, `discuss.privacyguides.net`, `discussion.dsausa.org`, `forums.mst3k.com`, `meta.discourse.org`)* - Requires `javascript.options.baselinejit` set to `true` to fix performance issues when entering text - *[https://codeberg.org/celenity/Phoenix/issues/189](https://codeberg.org/celenity/Phoenix/issues/189)*

**eden.net.nz** - The `SharedArrayBuffer` test *(`https://eden.net.nz/test/sab.html`)* requires `dom.postMessage.sharedArrayBuffer.withCOOP_COEP` set to `true` - *https://codeberg.org/celenity/Phoenix/issues/139*

**favicon.io** - Requires permission granted to extract *(randomized)* canvas data

toji.**github.io** - Requires `dom.webgpu.enabled` set to `true` for core functionality

**gitlab.com** - Requires permission granted to extract *(randomized)* canvas data to add a public avatar

www.**instagram.com** - Requires `network.http.referer.defaultPolicy.trackers` set to `2` for external embeds to display properly *([Ex.](https://www.ndtv.com/entertainment/bharti-singh-and-husband-haarsh-limbachiyaa-announce-pregnancy-see-trending-post-2646359))* - *https://gitlab.com/ironfox-oss/IronFox/-/issues/55*

www.**jerseymikes.com** - Requires permission granted to extract *(randomized)* canvas data for the map to display properly

www.**netflix.com** - Requires DRM for video playback

www.**photopea.com** - Requires permission granted to extract *(randomized)* canvas data

app.**plex.tv** - Requires DRM for playback of certain movies & TV shows provided by Plex. Other movies & TV shows provided by Plex may still play, but only at a lower quality. These issues do **not** impact local media

www.**pornhub.com** - Requires permission granted to extract *(randomized)* canvas data for thumbnail seeking

**typst.app** - Requires `dom.postMessage.sharedArrayBuffer.withCOOP_COEP` set to `true` - *https://codeberg.org/celenity/Phoenix/issues/181*

open.**spotify.com** - Requires DRM for audio playback *(https://codeberg.org/celenity/Phoenix/issues/108)*

**threejs.org** - Requires `dom.webgpu.enabled` set to `true` for core functionality

**twitter.com**/**x.com** - Requires permission granted to extract *(randomized)* canvas data to add a profile picture

**viliusle.github.io** - Requires permission granted to extract *(randomized)* canvas data for extracting/saving projects *(https://codeberg.org/celenity/Phoenix/issues/68)*

app.**watchduty.org** - Requires permission granted to extract *(randomized)* canvas data for certain display issues

**webgpu.github.io** - Requires `dom.webgpu.enabled` set to `true` for core functionality

studio.**youtube.com** - Requires permission granted to extract *(randomized)* canvas data to display/add a channel banner under `Customization`

## Extended:

The following are **only** problems on Phoenix's **Extended** config.

element.**4d2.org** - Requires `javascript.options.wasm` set to `true` for core functionality

**agar.io** - Requires `javascript.options.wasm` set to `true` for core functionality

**anicrush.to** - Requires `javascript.options.wasm` set to `true` & `network.http.referer.XOriginPolicy` set to `0` for video playback

**animepahe.ru** - Requires `network.http.referer.XOriginPolicy` set to `0` for video playback *(https://gitlab.com/celenityy/Phoenix/-/issues/2)*

**aniwatchtv.to** - Requires `javascript.options.wasm` set to `true` & `network.http.referer.XOriginPolicy` set to `0` for video playback

appleid.**apple.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for certain icons to display *(such as the "X" in the top left corner of the box when adding a payment method)*

**arc018.to** - Requires `javascript.options.wasm` set to `true` & `network.http.referer.XOriginPolicy` set to `0` for video playback

chat.**archaeo.social** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**arcticfoxes.net** - Requires `javascript.options.wasm` set to `true` for core functionality

**aria.im** - Requires `javascript.options.wasm` set to `true` for core functionality

**batcave.biz** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for core functionality *(https://codeberg.org/celenity/Phoenix/issues/90)*

**cakepay.com** *(Vercel Security)* - Requires `javascript.options.wasm` set to `true` for core functionality *https://codeberg.org/celenity/Phoenix/issues/143*

chat.**bark.lgbt** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**bitcoinist.org** - Requires `javascript.options.wasm` set to `true` for core functionality

search.**brave.com** - Requires `javascript.options.wasm` set to `true` for CAPTCHAs

element.**catgirl.cloud** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**chagai.website** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**chatwave.org** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**chess.com** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**chipotle.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for Order Checkout/Payment

www.**cineby.app** - Requires `javascript.options.wasm` set to `true` and `network.http.referer.XOriginPolicy` set to `0` for video playback *(https://codeberg.org/celenity/Phoenix/issues/156)*

app.**cinny.in** - Requires `javascript.options.wasm` set to `true` for core functionality

**cloutgist.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for URL shortening *(https://codeberg.org/celenity/Phoenix/issues/91)*

riot.**club1.fr** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**cnn.com** - Requires `media.autoplay.blocking_policy` set to `0` for video playback - *([Ex.](https://www.cnn.com/2025/03/11/europe/analysis-ukraine-russia-ceasefire-proposal-intl-latam/index.html))* - *https://gitlab.com/ironfox-oss/IronFox/-/issues/57*

**comick.io** -  Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* to display `Updates`/certain content *(https://codeberg.org/celenity/Phoenix/issues/135)*

talk.**comm.cx** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**coolmathgames.com** - Certain games require `javascript.options.wasm` set to `true` & permission granted to autoplay media

www.**crazygames.com** - Requires `javascript.options.wasm` set to `true` for games. Some games *(Ex. [https://www.crazygames.com/game/tag-2-3-4-players](https://www.crazygames.com/game/tag-2-3-4-players))* may also require `network.http.referer.XOriginPolicy` set to `1` *(or `0`)*

element.**data.coop** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**debian.social** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**digitalprivacy.diy** - Requires `javascript.options.wasm` set to `true` for core functionality

**discord.com** - Requires `media.peerconnection.ice.default_address_only`, `media.peerconnection.ice.no_host`, & `media.peerconnection.ice.relay_only` set to **`false`** for calling

element.**duesen.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**duolingo.com** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**eenadu.net** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for core functionality - *(https://github.com/webcompat/web-bugs/issues/149964)*

app.**element.io** - Requires `javascript.options.wasm` set to `true` for core functionality

gnome.**element.io** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**emulatrix.com** - Requires `javascript.options.wasm` set to `true` for core functionality

auth.**ente.io** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**envs.net** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**epicgames.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for account sign-in

play.**fancade.com** - Requires `javascript.options.wasm` set to `true` for core functionality *(https://github.com/webcompat/web-bugs/issues/149972)*

www.**fandango.com** - Requires `javascript.options.wasm` set to `true` for various functionality *(ex. `Sign-in` & `FanRewards Points`)*

m.**fanfox.net** - Requires `network.http.referer.XOriginPolicy` set to `0` for images/manga to display *([Ex.](https://m.fanfox.net/manga/spy_x_family/c070/1.html))*

www.**farming-simulator.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for images to display in the `ModHub` *(https://github.com/webcompat/web-bugs/issues/151669)*

chat.**fedoraproject.org** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**flieger.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**fox.yt** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**frei.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**freiburg.social** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**fsfe.org** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**g24.at** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**gemeinsam.jetzt** - Requires `javascript.options.wasm` set to `true` for core functionality

binbashbanana.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

binji.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

grubbyplaya.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

rb44a.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

udbsite.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

vinmannie.**github.io** - Requires `javascript.options.wasm` set to `true` for core functionality

matrix.**glasgow.social** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**gnulinux.club** - Requires `javascript.options.wasm` set to `true` for core functionality

drive.**google.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for video playback

earth.**google.com** - Requires `javascript.options.wasm` set to `true` for core functionality

photos.**google.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for video playback

element.**grapheneos.org** - Requires `javascript.options.wasm` set to `true` for core functionality

riot.**grin.hu** - Requires `javascript.options.wasm` set to `true` for core functionality

amazon-web.**grubhub.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for core functionality

conversation.**hadoly.fr** - Requires `javascript.options.wasm` set to `true` for core functionality

**hianimez.to** - Requires `javascript.options.wasm` set to `true` & `network.http.referer.XOriginPolicy` set to `0` for video playback

**hitomi.la** - Requires `network.http.referer.XOriginPolicy` set to `0` for images to display - *(https://codeberg.org/celenity/Phoenix/issues/148)*

webapp.**hongkongpost.hk** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* to [enter a tracking number](https://webapp.hongkongpost.hk/en/mail_tracking/index.html) - *(https://github.com/webcompat/web-bugs/issues/150611)*

element.**hot-chilli.im** - Requires `javascript.options.wasm` set to `true` for core functionality

**hoyolab.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for log-in - *(https://codeberg.org/celenity/Phoenix/issues/138)*

**hoyoverse.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for log-in - *(https://codeberg.org/celenity/Phoenix/issues/138)*

matrix.**hyteck.de** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**imagisphe.re** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**instagram.com** - Requires `media.autoplay.blocking_policy` set to `1` or `0` **or** permission granted to autoplay media for reels, and requires `network.http.referer.XOriginPolicy` set to `0` for external embeds to display properly *([Ex.](https://www.ndtv.com/entertainment/bharti-singh-and-husband-haarsh-limbachiyaa-announce-pregnancy-see-trending-post-2646359))* - *https://gitlab.com/ironfox-oss/IronFox/-/issues/55*

www.**ivpn.net** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for payment

www.**jamesfmackenzie.com** - Requires `javascript.options.wasm` set to `true` for **[Commander Keen](https://www.jamesfmackenzie.com/chocolatekeen/)**

www.**jasonhealth.com**- Requires `network.http.referer.XOriginPolicy` set to `0` for search - *(https://gitlab.com/celenityy/Phoenix/-/issues/3)*

www.**jerseymikes.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for Order Checkout/Payment

webchat.**kde.org** - Requires `javascript.options.wasm` set to `true` for core functionality

**keyoxide.org** - Requires `javascript.options.wasm` set to `true` for verifying certain account proofs - *([ex.](https://keyoxide.org/1bbdc23d1853255d6415d2ec814edf851aab370e))*

**kick.com** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**kosmikdog.eu** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**kraken.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for account log-in/sign-up

**krunker.io** - Requires `javascript.options.wasm` set to `true` for core functionality

**leptos.dev** - Requires `javascript.options.wasm` set to `true` for the counter button - *(https://github.com/webcompat/web-bugs/issues/150255)*

matrix.**libreon.fr** - Requires `javascript.options.wasm` set to `true` for core functionality

web.**libretro.com** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**magdeburg.jetzt** - Requires `javascript.options.wasm` set to `true` for core functionality

**mathplayzone.com** - Requires `javascript.options.wasm` set to `true` for core functionality

**moviezapiya.fun** - Requires `javascript.options.wasm` set to `true` for core functionality - *https://codeberg.org/celenity/Phoenix/issues/95*

chat.**mozilla.org** - Requires `javascript.options.wasm` set to `true` for core functionality

**mtrx.nz** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**neat.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

matrix.**nichi.co** - Requires `javascript.options.wasm` set to `true` for core functionality

app.**nitro.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**nope.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

cinny.**norge.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**norge.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

fluffychat.**norge.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

hydrogen.**norge.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**nytimes.com** - Requires adding `{"firstPartyDomain": "nytimes.com", "overrides": "-JSDateTimeUTC"}` to `privacy.fingerprintingProtection.granularOverrides` for **Wordle**

chat.**oblak.be** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**oretibole.xyz** - Requires `network.http.referer.XOriginPolicy` set to `0` for videos from `xhamster.com` to play

**p-bandai.com** - Requires `javascript.options.wasm` set to `true` for selecting items on the front page

www.**panerabread.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* to place online orders

chat.**pcriot.org** - Requires `javascript.options.wasm` set to `true` for core functionality

cinny.**pendora.io** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**photopea.com** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**pixiv.net** - Requires `network.http.referer.XOriginPolicy` set to `0` for images to display

www.**pogo.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for games

**poki.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for games - *([ex.](https://poki.com/en/g/subway-surfers))* + some games may also require setting `javascript.options.wasm` to `true` - *([ex.](https://poki.com/en/g/red-ball-4))*

element.**private.coffee** - Requires `javascript.options.wasm` set to `true` for core functionality

hydrogen.**private.coffee** - Requires `javascript.options.wasm` set to `true` for core functionality

pass.**proton.me** - Requires `javascript.options.wasm` set to `true` for core functionality

wallet.**proton.me** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**pub.solar** - Requires `javascript.options.wasm` set to `true` for core functionality

www.**quranbookk.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* *(https://gitlab.com/ironfox-oss/IronFox/-/issues/28)*

app.**raindrop.io** - Requires `network.http.referer.XOriginPolicy` set to `0` for web previews *(https://codeberg.org/celenity/Phoenix/issues/106)*

**rollenspiel.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

cinny.**rollenspiel.chat** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**socialnetwork24.com** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**soziale.cloud** - Requires `javascript.options.wasm` set to `true` for core functionality

**sportal.bg** - Requires `network.http.referer.XOriginPolicy` set to `0` for comments *(https://gitlab.com/ironfox-oss/IronFox/-/issues/92)* - *([ex.](https://sportal.bg/news-2025050418545143780))*

chat.**studichat.de** - Requires `javascript.options.wasm` set to `true` for core functionality

web.**synod.im** - Requires `javascript.options.wasm` set to `true` for core functionality

chat.**tchncs.de** - Requires `javascript.options.wasm` set to `true` for core functionality

element.**tedomum.net** - Requires `javascript.options.wasm` set to `true` for core functionality

cinny.**the-apothecary.club** - Requires `javascript.options.wasm` set to `true` for core functionality

schildichat.**the-apothecary.club** - Requires `javascript.options.wasm` set to `true` for core functionality

**twitter.com**/**x.com** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* for images to appear in DMs, and requires `media.peerconnection.ice.no_host` & `media.peerconnection.ice.relay_only` set to `false` for speaking in Spaces

**uflix.cc** - Requires `network.http.referer.XOriginPolicy` set to `0` for video playback

element.**unredacted.org** - Requires `javascript.options.wasm` set to `true` for core functionality

reg.**usps.com** - Requires `javascript.options.wasm` set to `true` for account sign-in - *(https://gitlab.com/ironfox-oss/IronFox/-/issues/35)*

tools.**usps.com** - Requires `javascript.options.wasm` set to `true` for page to load - *(https://github.com/webcompat/web-bugs/issues/149837)*

chat.**utwente.io** - Requires `javascript.options.wasm` set to `true` for core functionality

**vimm.net** - Requires `network.http.referer.XOriginPolicy` set to `1` *(or `0`)* to download games and load screenshots, and requires `javascript.options.wasm` set to `true` for playing games online

**vizzy.io** - Requires `javascript.options.wasm` set to `true` for core functionality

**we2.ee** - Requires `javascript.options.wasm` set to `true` for core functionality

login.**yahoo.com** - Requires `network.http.referer.XOriginPolicy` set to `0` for core functionality

element.**yatrix.org** - Requires `javascript.options.wasm` set to `true` for core functionality

**zombs.io** - Requires `javascript.options.wasm` set to `true` for core functionality
