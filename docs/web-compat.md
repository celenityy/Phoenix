Documenting websites that have issues with Phoenix & why, as well as fixes if applicable

Please report any breakage as you encounter it!

`www.amazon.com` (Prime Video) - Requires DRM for video playback

`www.netflix.com` - Requires DRM for video playback

`app.plex.tv` - Movies & Shows provided by Plex may stream at a lower quality or complain due to lack of DRM. Does not impact local media

HARDENED:

`appleid.apple.com` - Certain icons (such as the "X" in the top left corner of the box when adding a payment method) won't display unless `network.http.referer.XOriginPolicy` is set to `1` (or `0`)

`search.brave.com` - Requires `javascript.options.wasm` set to `true` for Maps functionality

`www.chipotle.com` - Requires `network.http.referer.XOriginPolicy` set to `0` for Order Checkout/Payment

`fandango.com` - Requires `javascript.options.wasm` set to `true` for various functionality (ex. Sign-in & "FanRewards Points")

`drive.google.com` - Requires `network.http.referer.XOriginPolicy` set to `0` for video playback

`amazon-web.grubhub.com` - Requires `network.http.referer.XOriginPolicy` set to `1` (or `0`)

`www.photopea.com` - Requires `javascript.options.wasm` set to `true`

`wallet.proton.me` - Requires `javascript.options.wasm` set to `true`

`twitter.com`/`x.com` - Requires `network.http.referer.XOriginPolicy` set to `1` (or `0`) for images to appear in DMs