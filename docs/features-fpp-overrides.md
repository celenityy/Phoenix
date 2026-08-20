# 🔍 Fingerprinting Protection Overrides

By default, Phoenix [provides strong fingerprinting protection](./Features#-fingerprinting) via a hardened configuration of Mozilla's [Suspected Fingerprinters Protection *(FPP)*](https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters).

These protections can sometimes cause breakage or undesired issues for users, so to mitigate/circumvent these problems, we set per-site overrides as needed. In other cases, we may enable additional targets to strengthen fingerprinting protection for certain websites if we're able to. **Note that some overrides may not apply unless a specific target is active**.

This page is meant to serve as a reference and document the FPP overrides we set.

## Shared

These overrides apply to **both** Android **and** Desktop.

### Harden

These overrides **strengthen** fingerprinting protection for the specified website(s):

- `aa.com`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.ae`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.ca`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.cn`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.co.jp`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.co.uk`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.co.za`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com.au`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com.be`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com.br`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com.tr`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.com.mx`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.de`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.eg`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.es`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.fr`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.ie`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.in`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.it`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.nl`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.pl`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.sa`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.se`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `amazon.sg`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `annas-archive.org`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `animepahe.ru`  ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `apple.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `apple.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `apple.com.cn` -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `apple.news` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `apple.news` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `bsky.app` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `cdn-apple.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
`- cdninstagram.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `cengage.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `cloudflare.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `cloudflare.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `cvs.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `discord.gg` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `discord.gg` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `dropbox.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `enza.fun` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `epicgames.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `favicon.io` ***(In first party contexts)*** -> `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access)
- `goo.gl` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `goo.gl` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `googlevideo.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs locale
- `gravatar.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `hoyoverse.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `imdb.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `instagram.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `klippy.pro` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `kroger.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `licdn.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
`- linkedin.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `loginwithamazon.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `medium.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `mega.nz` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `pinimg.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `pinterest.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `porkbun.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `recaptcha.net` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `recaptcha.net.cn` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `recaptcha-cn.net` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `redd.it` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `reddit.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `reddit.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `redditmedia.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `redditmedia.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `redditstatic.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `rezka-ua.in` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `riverside.fm` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `salespanel.io` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `southwest.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `stacksocial.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `starlink.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `svgrepo.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
`- t.co` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `t.co` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs frame rate
- `thunderbird.net` ***(In first party contexts)*** -> `+CSSPrefersColorScheme`: Spoofs CSS `prefers-color-scheme`
- `tiktok.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `tiktok.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `tileman.io` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `twimg.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, and spoofs locale
- `twitter.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `usnews.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `usps.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `vhlcentral.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `vimeo.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `vimeocdn.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `x.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `yahoo.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `youtu.be` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`, `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission, enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `youtu.be` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+FrameRate`, `+JSDateTimeUTC`, `+JSLocale`: Enables timezone spoofing (as it doesn't need access), spoofs CSS `prefers-color-scheme`, spoofs frame rate, and spoofs locale
- `youtube.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `youtube-nocookie.com` ***(In third party contexts)*** -> `+CSSPrefersColorScheme`, `+JSDateTimeUTC`: Enables timezone spoofing (as it doesn't need access), and spoofs CSS `prefers-color-scheme`
- `zoho.com` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `zoho.com.au` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `zoho.eu` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `zoho.in` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `zoho.jp` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission
- `zoho.sa` ***(In first party contexts)*** -> `+CanvasExtractionBeforeUserInputIsBlocked`, `+CanvasImageExtractionPrompt`: Blocks canvas data extraction before user input, to prevent it from prompting users despite not needing the permission

### Relax

These overrides **relax** fingerprinting protection for the specified website(s):

- `abeto.co` ***(In first party contexts)*** -> `-WebGLRenderCapability`: Disables spoofing WebGL Render Capability by default *(Required for text rendering, see [https://codeberg.org/celenity/Phoenix/issues/192](https://codeberg.org/celenity/Phoenix/issues/192))*
- `arcticfoxes.net` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `aria.im` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `bahn.expert` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(see [https://codeberg.org/celenity/Phoenix/issues/157](https://codeberg.org/celenity/Phoenix/issues/157))*
- `bitcoinist.org` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `calendly.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Ensures the proper timezone is set for scheduling appointments)*
- `chatwave.org` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `chipotle.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes estimated arrival times/order confirmation time)*
- `cinny.in` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `citybbq.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes estimated delivery times)*
- `cryptpad.fr` ***(In first party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows `cryptpad.info` to extract randomized canvas data *(Unbreaks display of certain elements)*
- `discord.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `doordash.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes estimated delivery times)*
- `duesen.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `element.io` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `figma.com` ***(In first party contexts)*** -> `-WebGLRenderCapability`: Disables spoofing WebGL Render Capability by default *(see [https://codeberg.org/celenity/Phoenix/issues/184](https://codeberg.org/celenity/Phoenix/issues/184))*
- `flieger.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `g24.at` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `gemeinsam.jetzt` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `gnulinux.club` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `hot-chilli.im` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `kosmikdog.eu` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `megacloud.blog` ***(In third party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows extracting randomized canvas data *(Required for video playback on various websites (ex. `anicrush.to`, `aniwatchtv.to`, & `hianimez.to`), see [https://codeberg.org/celenity/Phoenix/issues/96](https://codeberg.org/celenity/Phoenix/issues/96))*
- `megacloud.store` ***(In third party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows extracting randomized canvas data *(Required for video playback on various websites (ex. `anicrush.to`, `aniwatchtv.to`, & `hianimez.to`), see [https://codeberg.org/celenity/Phoenix/issues/96](https://codeberg.org/celenity/Phoenix/issues/96))*
- `mtrx.nz` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `neat.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `nitro.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `nope.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `oblak.be` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `pcriot.org` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `pendora.io` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `pogo.com` ***(In first party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows `pogospike.com` to extract randomized canvas data *(Fixes display issues on games, ex. [https://www.pogo.com/games/word-whomp/play](https://www.pogo.com/games/word-whomp/play))*
- `pornhub.com` ***(In third party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows extracting randomized canvas data *(Required for thumbnail seeking on various websites)*
- `proton.me` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time emails were sent for Proton Mail)*
- `rollenspiel.chat` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `socialnetwork24.com` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `studichat.de` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `synod.im` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `temoos.app` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes estimated delivery times for `delivery.temoos.app`)*
- `the-apothecary.club` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `unredacted.org` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `utwente.io` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `vcsynctester.com` ***(In first party contexts)*** -> `-ReduceTimerPrecision`: Disables reduced timer precision by default *(Fixes display issues, see [https://codeberg.org/celenity/Phoenix/issues/190](https://codeberg.org/celenity/Phoenix/issues/190))*
- `we2.ee` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `yatrix.org` ***(In first party contexts)*** -> `-JSDateTimeUTC`: Disables timezone spoofing by default *(Fixes display of time messages were sent)*
- `zennioptical.com` ***(In first party contexts)*** -> `-CanvasExtractionFromThirdPartiesIsBlocked`: Allows `fittingbox.com` to extract randomized canvas data *(Unbreaks the `Try on` feature)*

## Android

These overrides **only** apply to **Android**.

### Relax

These overrides **relax** fingerprinting protection for the specified website(s):

- `brave.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes display issues on Brave Search Maps)*
- `bsky.app` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for uploading profile pictures)*
- `cryptpad.fr` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows `cryptpad.info` to extract randomized canvas data *(Unbreaks display of certain elements)*
- `discord.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for uploading profile pictures)*
- `favicon.io` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for downloading converted files)*
- `figma.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for display of certain elements)*
- `fittingbox.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(ex. Unbreaks the `Try on` feature on `zennioptical.com`)*
- `gitlab.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for uploading profile pictures)*
- `gsi.go.jp` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Causes complete breakage, ex. [https://maps.gsi.go.jp/index_3d.html?z=16&lat=35.653225&lon=139.73539700000003&pxsize=1024&ls=std#&cpx=-54.107&cpy=162.515&cpz=99.300&cux=-0.518&cuy=0.245&cuz=0.820&ctx=1.324&cty=20.508&ctz=33.599&a=1&b=0&dd=0](https://maps.gsi.go.jp/index_3d.html?z=16&lat=35.653225&lon=139.73539700000003&pxsize=1024&ls=std#&cpx=-54.107&cpy=162.515&cpz=99.300&cux=-0.518&cuy=0.245&cuz=0.820&ctx=1.324&cty=20.508&ctz=33.599&a=1&b=0&dd=0))*
- `harkins.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for seat selection, see [https://github.com/brave/brave-browser/issues/35750](https://github.com/brave/brave-browser/issues/35750))*
- `icloud.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for certain icons/media to display)*
- `icloud.com.cn` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for certain icons/media to display)*
- `jerseymikes.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes map display issues)*
- `jspaint.app` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required to save images, see [https://codeberg.org/celenity/Phoenix/issues/200](https://codeberg.org/celenity/Phoenix/issues/200))*
- `letterboxd.com` ***(In first party contexts)*** -> `-ScreenRect`: Disables spoofing screen coordinates *(Required for the mobile (instead of desktop) page to display, see [https://github.com/webcompat/web-bugs/issues/150661](https://github.com/webcompat/web-bugs/issues/150661))*
- `namemc.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for skins to display)*
- `mapple.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes map display issues)*
- `megacloud.blog` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for video playback)*
- `megacloud.store` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for video playback)*
- `mit.edu` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Causes breakage for Scratch games - ex. https://scratch.mit.edu/projects/1291454525/)*
- `nperf.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Causes complete breakage)*
- `photopea.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Causes complete breakage)*
- `piskelapp.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes display issues, see [https://codeberg.org/celenity/Phoenix/issues/200](https://codeberg.org/celenity/Phoenix/issues/200))*
- `pogo.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows `pogospike.com` to extract randomized canvas data *(Fixes display issues on games, ex. [https://www.pogo.com/games/word-whomp/play](https://www.pogo.com/games/word-whomp/play))*
- `pogospike.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes display issues on games, ex. [https://www.pogo.com/games/word-whomp/play](https://www.pogo.com/games/word-whomp/play))*
- `pornhub.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for thumbnail seeking)*
- `siapre.pl` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for display of AR QR codes - [ex.](https://sklep.siapre.pl/produkt/spigola-pro-czarny-klamki-z-plaskim-kwadratowym-szyldem-qrpr.html) -> click `Zobacz na swoich drzwiach`)*
- `ttc.com.ge` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes map display issues)*
- `usgs.gov` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes display issues on for maps, [ex.](https://earthquake.usgs.gov/earthquakes/eventpage/us6000recq/region-info))*
- `viliusle.github.io` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for extracting/saving projects, see [https://codeberg.org/celenity/Phoenix/issues/68](https://codeberg.org/celenity/Phoenix/issues/68))*
- `watchduty.org` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Fixes display issues)*
- `x.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`: Allows randomized first party canvas data extraction *(Required for uploading profile pictures)*
- `zennioptical.com` ***(In first party contexts)*** -> `-CanvasExtractionBeforeUserInputIsBlocked`, `-CanvasImageExtractionPrompt`:  Allows `fittingbox.com` to extract randomized canvas data *(Unbreaks the `Try on` feature)*

## Desktop

These overrides **only** apply to **Desktop**.

### Relax

These overrides **relax** fingerprinting protection for the specified website(s):

- `barnesandnoble.com` ***(In first party contexts)*** -> `-ScreenRect`: Disables spoofing screen coordinates *(Required for account sign-in)*
