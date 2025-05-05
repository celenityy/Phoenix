
//

//
// Copyright (C) 2024-2025 celenity
//
// This file is part of Phoenix.
//
// Phoenix is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// Phoenix is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Phoenix. If not, see https://www.gnu.org/licenses/.
//

// This file contains preferences specific to Phoenix on Android.

/* INDEX 

001: MOZILLA CRAP™
002: FINGERPRINTING PROTECTION
003: DNS
004: MEDIA
005: PASSWORDS & AUTHENTICATION
006: EXTENSIONS
007: DEBUGGING
008: MISC. SECURITY
009: PERFORMANCE

*/

/*** 001 MOZILLA CRAP™ ***/

/// Remove tracking parameters from Mozilla URLs
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/android/search?q=%TERMS%");

pref("browser.phoenix.status.android", "001");

/*** 002 FINGERPRINTING PROTECTION ***/

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Android#fingerprinting
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC,-JSLocale");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Bluesky (bsky.app) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Brave Search (brave.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny (pendora.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/Element (transfem.dev) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/SchildiChat (the-apothecary.club) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// DoorDash (doordash.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (bitcoinist.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (chatwave.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (duesen.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (flieger.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (g24.at) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (gemeinsam.jetzt) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (gnulinux.club) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (hot-chilli.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (kosmikdog.eu) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mtrx.nz) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (neat.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (nitro.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (nope.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (oblak.be) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (pcriot.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (rollenspiel.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (socialnetwork24.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (studichat.de) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (synod.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (utwente.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (we2.ee) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (yatrix.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Favicon.io (favicon.io)  - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks downloading converted files
// GitLab (gitlab.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// GSI Maps (gsi.go.jp) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage (ex. https://maps.gsi.go.jp/index_3d.html?z=16&lat=35.653225&lon=139.73539700000003&pxsize=1024&ls=std#&cpx=-54.107&cpy=162.515&cpz=99.300&cux=-0.518&cuy=0.245&cuz=0.820&ctx=1.324&cty=20.508&ctz=33.599&a=1&b=0&dd=0)
// Harkins Theatres (harkins.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks seat selection (https://github.com/brave/brave-browser/issues/35750)
// Jersey Mike's (jerseymikes.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Letterboxd (letterboxd.com) - Disables spoofing screen coordinates (-ScreenRect) to properly display the mobile page instead of desktop (https://github.com/webcompat/web-bugs/issues/150661)
// Megacloud megacloud.blog - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks video playback
// Megacloud (megacloud.store) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks video playback
// miniPaint (viliusle.github.io) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks extracting/saving projects (https://codeberg.org/celenity/Phoenix/issues/68)
// nPerf (nperf.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pogo (pogospike.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks games
// Photopea (photopea.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pornhub (pornhub.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks thumbnail seeking
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// PSA Bypass Link (moviezapiya.fun) - Disables spoofing WebGL renderer info (-WebGLRenderInfo) - https://codeberg.org/celenity/Phoenix/issues/95
// Watch Duty (watchduty.org) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues
// X/Twitter (x.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"brave.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"bsky.app","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"favicon.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gitlab.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gsi.go.jp","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"harkins.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"jerseymikes.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"letterboxd.com","overrides":"-ScreenRect"},{"firstPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"megacloud.store","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"moviezapiya.fun","overrides":"-WebGLRenderInfo"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nperf.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"photopea.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pogospike.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pornhub.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"transfem.dev","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"viliusle.github.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"watchduty.org","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"x.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"}]');

pref("browser.phoenix.status.android", "002");

/*** 003 DNS ***/

/// Temporarily exclude certain captive portal domains from DNS over HTTPS by default
// Android unfortunately doesn't currently prompt users to fallback from DNS over HTTPS when a site can't be found (like desktop does), which causes unexpected breakage for users, as it leaves them without a clear explanation of the issue and a way to add the exceptions.
// I don't love the idea of doing this... so again, to clarify: these are temporary will be removed once Firefox adds the fallback UI.
// Domains taken from: https://badblock.celenity.dev/#captive-whitelist
pref("network.trr.excluded-domains", "aainflight.com,acwifi.com,aircanadawifi.com,airtime.geemedia.com,alaskawifi.com,amtrakconnect.com,amtrakwifi.com,ana-inflight-wifi.com,app-yoda.arubathena.com,aruba.odyssys.net,arubanetworks.com,arubanetworks.com.cn,asset-acms.anuvu.cloud,auth.hpe.com,bap.aws.opennetworkexchange.net,btwifi.com,captive.o2wifi.co.uk,captive-2020.aio.cloudauth.net,captive-2022.aio.cloudauth.net,captivemgr.o2wifi.net.uk,captiveportal-login.belex.com,carnivalwifi.com,cbp-guest.cbp.dhs.gov,cdnhotspot.afd.azureedge.net,cdnhotspot.azureedge.net,central.access.network,cfr-mprtuam-01.cops.us1.pr.anuvu.cloud,checkout.aa.com,cloud.imedia.ie,connect.edge.ihg.com,connect-edge.ihg.com,connected.xfinity.com,controller.access.network,cust.blueprintrf.com,deltawifi.com,device-yoda2.arubadev.cloud.hpe.com,dlrguest-captive.disney.com,ee-wifi.ee.co.uk,etihadwi-fly.com,fedsso.yum.com,flyfi.com,freewlan.sbb.ch,gogoinair.com,gogoinflight.com,gp1.wendys.com,guestinternet.com,guestinternet.com.s3-website-us-east-1.amazonaws.com,hiltonwifi.com,hotspotportals.com,hs.imedia.ie,httpforever.com,iceportal.de,inflight.pacwisp.net,inflight-wifi.com,inflightinternet.com,internal2-public-device-nc-nlb-b71ba3c951b09682.elb.us-west-2.amazonaws.com,internal2-public-device-nlb-2e2273d4267c0682.elb.us-west-2.amazonaws.com,internetupgrade.marriott.com,kong-gtw-portal-apse2prod5-lb-1386339370.ap-southeast-2.elb.amazonaws.com,kong-gtw-portal-eu-lb-1104785228.eu-central-1.elb.amazonaws.com,kong-gtw-portal-mec1prod6-lb-2104849938.me-central-1.elb.amazonaws.com,kong-gtw-portal-production-lb-686216184.us-west-1.elb.amazonaws.com,kong-gtw-portal-use1prod2-lb-291057632.us-east-1.elb.amazonaws.com,krisworld.singaporeair.com,kw.sq.com,landing.sbb.ch,loggedin.wifigem.it,login.attwifi.com,login.cloud5.com,login.cloudi-fi.net,login.innflux.com,login.wifigem.com,login.windstream.com,login-awe-cluster.attwifi.com,login-federated.windstream.com,lounge.aa.com,lpv.attwifi.com,lufthansa-flynet.com,managedwifi.xfinity.com,massportwifi.com,marriottwifi.com,medallionclass.com,mscwifi.com,msftguest-virtual.partners.extranet.microsoft.com,mt1.datavalet.io,network-auth.com,neverssl.com,nossl.com,ofc-yoda2.arubadev.cloud.hpe.com,onboard.eurostar.com,onboard.sbb.ch,onboardicafe.com,portal.ac2.mist.com,portal.ac5.mist.com,portal.ac6.mist.com,portal.eu.mist.com,portal.gc1.mist.com,portal.gc2.mist.com,portal.gc3.mist.com,portal.mist.com,portal.moovmanage.com,qa-connect-edge.ihg.com,rcs.arubathena.com,rcs-m.arubathena.com,rcs-ng-yoda2.arubadev.cloud.hpe.com,regio-guide.de,rsc.att.com,rsc.wayport.net,rougewifi.com,sbux-j3.datavalet.io,sbux-portal.globalreachtech.com,sbux-portal.odyssys.net,secure.11os.com,secure.datavalet.io,secure.wayport.net,secure-login.attwifi.com,service.thecloud.net,shop.ba.com,singaporeair-krisworld.com,sso.wendys.com,stage.connect.edge.ihg.com,starbucks-east.datavalet.io,stay.marriottbonvoy.com,southwestwifi.com,thalysnet.com,thd.cloudauth.net,timhortonswifi.com,tvgreyhound.com,unitedprivatescreening.com,unitedwifi.com,universal-orlando.ampthink.com,viasat.com,virginwifi.com,wanderingwifi.com,we.windstream.com,weconnect.wendys.com,wifi.airasia.com,wifi.bahn.de,wifi.cathaypacific.com,wifi.delta.com,wifi.esa.com,wifi.kfc.com,wifi1.kfc.com,wifi2.kfc.com,wifi.panerabread.com,wifi.singaporeair.com,wifi.sncf,wifi.starbucks.com,wifi.tgv-lyria.com,wifi.tgvlyria.com,wifi.united.com,wifi.united.com.edgekey.net,wifi.we.co,wifi.xfinity.com,wifi-viarail.ca,wifi-xdb.boingohotspot.net,wifihotspot.io,wifilauncher.com,wifilauncher.com.s3-website.us-east-1.amazonaws.com,wifilrn-ch2-1p.xfinity.com,wifionboard.com,wirelessportal.americanexpress.com,wirelessportal.americanexpress.com.akadns.net,wirelessportal2.americanexpress.com.akadns.net,wlb1-1579773356.us-east-1.elb.amazonaws.com,yoda-cgqa.arubathena.com,yoda-cgqa-elb.arubathena.com,yoda2-ofc-nlb-f4f923213a2189c7.elb.us-west-2.amazonaws.com,yoda2-public-device-nlb-8343995ce4714f6f.elb.us-west-2.amazonaws.com,yoda2-rcs-nlb-0c9df3882f3f7416.elb.us-west-2.amazonaws.com,zugportal.de");

pref("browser.phoenix.status.android", "003");

/*** 004 MEDIA ***/

/// Disable Widevine MediaDrm/MediaKeySystem
// https://developer.android.com/reference/android/media/MediaDrm
// https://bugzilla.mozilla.org/show_bug.cgi?id=1306219
pref("media.mediadrm-widevinecdm.visible", false);

pref("browser.phoenix.status.android", "004");

/*** 005 PASSWORDS & AUTHENTICATION ***/

/// Re-enable formless capture in standard windows
// See `015` at `Phoenix-Core` for details
// We still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/11
pref("signon.formlessCapture.enabled", true); // [DEFAULT]

pref("browser.phoenix.status.android", "005");

/*** 006 EXTENSIONS ***/

/// Block extensions signed with weak signature algorithms
pref("xpinstall.signatures.weakSignaturesTemporarilyAllowed", false); // [DEFAULT, HIDDEN]

/// Enable installation of add-ons by default
// Note that this does NOT apply to `Recommended` extensions (collecitons) found at `Settings` -> `Advanced` -> `Extensions`.
// Unfortunately doesn't have a prompt when disabled like Desktop :(
// Setting here to expose via the `about:config`...
pref("xpinstall.enabled", true); // [DEFAULT, HIDDEN]

/// Enable mozAddonManager
// mozAddonManager prevents extensions from working on `addons.mozilla.org`/the specified domains
// This API also exposes a list of the user's installed add-ons to `addons.mozilla.org`/the specified domains...
// But it's required for the installation of extensions from `addons.mozilla.org`, so let's ensure it's enabled by default to prevent issues
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.enabled", true);
pref("privacy.resistFingerprinting.block_mozAddonManager", false); // [DEFAULT]

/// Only allow installation of signed extensions by default
pref("extensions.langpacks.signatures.required", true); // [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.android", "006");

/*** 007 DEBUGGING ***/

/// Disable sending console output to logcat by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1415318
pref("consoleservice.logcat", false);
pref("geckoview.console.enabled", false);

/// Limit GeckoView's log level to "Warn" by default
pref("geckoview.logging", "Warn"); // [DEFAULT - non-Debug]

pref("browser.phoenix.status.android", "007");

/*** 008 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.status.android", "008");

/*** 009 PERFORMANCE ***/

pref("browser.sessionstore.max_tabs_undo", 7);
pref("network.http.max-connections", 256); // [Default = 128]

pref("browser.phoenix.status.android", "009");

pref("browser.phoenix.status.android", "successfully applied :D", locked);

