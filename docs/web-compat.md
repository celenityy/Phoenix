Documenting websites that have issues with Phoenix & why, as well as fixes if applicable

Please report any breakage as you encounter it!

`www.amazon.com` (Prime Video) - Requires DRM for video playback

`www.netflix.com` - Requires DRM for video playback

`app.plex.tv` - Movies & Shows provided by Plex may stream at a lower quality or complain due to lack of DRM. Does not impact local media

HARDENED:

`amazon-web.grubhub.com` - Requires `network.http.referer.XOriginPolicy` set to `1`

`search.brave.com` - Requires `javascript.options.wasm` set to `true` for Maps functionality

`fandango.com` - Requires `javascript.options.wasm` set to `true` for various functionality (ex. Sign-in & "FanRewards Points")

`www.photopea.com` - Requires `javascript.options.wasm` set to `true`

`twitter.com`/`x.com` - Requires `network.http.referer.XOriginPolicy` set to `1` for images to appear in DMs