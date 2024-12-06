//////////////////////////////////////////////////////////////////////////////
// Phoenix's built-in PAC filter to block built-in Mozilla telemetry domains & other trash
// Hacky but actually seems to work fairly well
//
// Based on John's No-ADS proxy auto configuration script: http://www.schooner.com/~loverso/no-ads/
//
// Original copyright notice:
// Copyright 1996-2004, John LoVerso.  All Rights Reserved.
//
//	Permission is given to use and distribute this file, as long as this
//	copyright message and author notice are not removed.
//
//	No responsibility is taken for any errors on inaccuracies inherent
//	either to the comments or the code of this program, but if reported
//	to me, then an attempt will be made to fix them.
//
// ("no monies exchanged" in Copyright clause removed 11/2001)
//
var noadsver = "$Id: no-ads.pac,v 6.10 2021/03/26 13:43:28 loverso Exp loverso $";

// ****
// **** If you do not use a proxy to access the Internet, then the following
// **** line is already fine.
// ****
// **** If you use an a proxy to access the Internet, as required by your
// **** ISP or firewall, then change the line below, replacing
// **** "DIRECT" with "PROXY hostname:port", using the correct hostname:port
// **** for your proxy server.
// ****
var normal = "DIRECT";

// ***
// *** If you are not using a blackhold proxy, then you can leave this
// *** setting as is.
// ***
// *** Otherwise, update the next line with the correct hostname:port
// *** of your blackhole proxy server.  If you are using Larry Wang's
// *** BHP for Windows, you need to change the "0.0.0.0" to "127.0.0.1"
// ***
//var blackhole = "PROXY 0.0.0.0:3421";
var blackhole = "PROXY 255.255.255.0:3421";
// Safari/MacOS needs the old value
if (typeof (navigator) != "undefined"
    && navigator.appVersion.indexOf("Mac") != -1) {
    blackhole = "PROXY 0.0.0.0:3421";
}


// ***
// *** If you need a different proxy to access local/internal hosts vs.
// *** the rest of the Internet, set 'localproxy' to that value.  Otherwise,
// *** 'localproxy' defaults to the same value as 'normal', so you do
// *** not need to change anything in the normal case.
// ***
// *** Some typical cases:
// ***	- 'normal' might be one proxy, and 'localproxy' might be another
// ***	- 'normal' might be a proxy, and 'localproxy' might be "DIRECT"
// ***
// *** You will also need to change the LOCAL section below by adding
// *** rules to match your local/internal hosts.
// ***
var localproxy = normal;

// ***
// *** If you need a socks proxy for some hosts, set it here.
// *** You will need to change the SOCKS section below.
var socksproxy = normal;

// ***
// *** 'bypass' is the preferred proxy setting for when no-ads is inactive.
// *** Either use '= normal' or '= localproxy' (or perhaps just "DIRECT").
// *** This only matters when you need to use a localproxy.
// *** (You probably don't need to care about this)
// ***
var bypass = normal;

///////////////////////////////////////////////////////////////////////////////
//
// This simple kludge uses a mechanism built into most browsers (IE, Netscape,
// Mozilla, Firefox, and Opera) on most platforms to block connections to
// banner ad servers.
//
// This mechanism uses the "proxy auto configuration" to blackhole requests
// to load ad images without forcing all your traffic through an ad-blocking
// proxy server.  Of course, unlike ad-blocking proxy servers, this does not
// otherwise not strip cookies.
//
// "Proxy auto configuration" invokes the JavaScript FindProxyForURL function
// below each time your browser requests a URL.  This works even if you have
// JavaScript otherwise disabled in your browser!  (Which you should!)
//

//
// Send me your additions or comments.  I'll credit you in the file.
// (But I've removed all email addresses to stop spam harvesters).
//


///////////////////////////////////////////////////////////////////////////////
//
// These are the basic steps needed to use "no-ads.pac".
// Detailed instructions follow below!
//
// 1. Save this as a file (no-ads.pac) on your local disk
//    (or, add it to your home page, if you have one)
// 2. Select a no-ads "blackhole".
// 3. Configure your browser to use this file as it's auto proxy configuration.
// 4. Clear your browser's cache
//    (or else it may still show you ads it has saved on your disk).
//


///////////////////////////////////////////////////////////////////////////////
//
// 1. SAVE THIS FILE
//
// Copy this file to your local machine; use your home directory (UNIX)
// or your Desktop or C:\ directory (Windows).
//



///////////////////////////////////////////////////////////////////////////////
//
// 2. SELECT A NO-ADS BLACKHOLE
//
// You can skip this section if you are using any version of Internet Explorer.
// You can also skip this section for Netscape 7.1, Mozilla 1.4, or
// Firefox 1.0 (or later), as they include PAC failover support (but do
// read the note in section "2a" below).
//
//
// The basic trick of no-ads is to match the site or URL of annoying web content
// and tell your browser to use a proxy that will deny loading of that resource
// (image, page, etc).
//
// A "black-hole" proxy server is one that always denies loading a web page.
// ("send it off to a blackhole").
//
// When you initially get "no-ads.pac", it is using this as the blackhole:
//
//	"PROXY 0.0.0.0:3421"
//
// This says to use the local host at a port which nothing should be listening
// on.  Thus, this is "a server that doesn't repond."
//
// This is a good default for all systems, and especially Windows.
// However, if you are using the Blackhole Proxy Server on Windows, 
// be sure to change it to "PROXY 127.0.0.1:3421"
//
//
// Some possibilities for the blackhole:
//
//	a. A server that doesn't respond.
//
//		*** This works for all versions of Internet Explorer.
//		*** This mostly works for Mozilla, Firefox, and Netscape.
//
//		If you do nothing, then this is configured to direct annoying
//		content to the proxy running on your own host at port 3421.
//		Since you shouldn't have anything running on that port, that
//		connection will timeout and the annoying content will never be
//		loaded.
//
//		Older versions of Netscape wait to connect to the proxy server
//		(usually it needs to load part of the image to layout the web
//		page), and then asks if you want to disable the proxy that
//		doesn't answer.
//
//		Older versions of Mozilla will give an alert saying it couldn't
//		connect to the proxy server.
//
//		Mozilla 1.4+, Firefox 1.0+ and Netscape 7.1 will only give
//		you this alert if the whole page being display is blocked,
//		rather than just an image on that page.  Thus, I still
//		recommend a blackhole proxy even though it isn't needed.
//
//		Opera will disable your auto proxy config if the proxy server
//		doesn't respond.
//
//		IE doesn't care that the proxy server isn't responding.  As
//		this avoids a connection for annoying content, it is fastest.
//
//	b. A simple, blackhole server
//
//		When needed, I run a simple "server" at port 3421 that denies
//		all requests.  Some options you can use for this:
//
//		- On Windows, you can try Larry Wang's black-hole proxy program:
//
//			http://leisuresuit10.tripod.com/BlackHoleProxy/
//
//		  I can not vouch that his binaries are virus free, but he does
//		  offer the source code.
//
//		- I use this shell script on UNIX; it is invoked via inetd.
//		  /usr/local/lib/noproxy:
//
//			#!/bin/sh
//			read a
//			read b
//			echo HTTP/1.0 501 No Ads Accepted
//			echo ""
//			exit
//
//		  Add this line to inetd.conf ('kill -HUP' inetd afterwards):
//
//		    3421 stream tcp nowait nobody /usr/local/lib/noproxy noproxy
//
//		  This simple script doesn't work on Linux because of the
//		  (IMHO) broken way it's TCP stack works.  See the bottom of
//		  http://www.schooner.com/~loverso/no-ads/ for a complete copy
//		  of the `noproxy' shell script.
//
//		  If always exec'ing a shell was expensive on your computer
//		  (it isn't on mine), then you could use a "wait"-style Perl
//		  script that would accept() incoming connections.
//
//		- Sean Burke has a black-hole proxy written in Perl script:
//
//		  http://www.speech.cs.cmu.edu/~sburke/pub/black_hole_http_server.pl
//		  (This is a standalone server, not run from inetd).
//
//	e. A trick: use an HTTP/1.0 non-proxy server
//
//		An HTTP/1.0 non-proxy server will return a 501 error when
//		given a proxy request.  Thus, just use the address of your
//		local intranet web server as your blackhole PROXY.
//		The downside of this is that it will probably also log an
//		error, which wastes a small amount of resources.
//
//	***
//	*** Be sure to update the "blackhole" variable above with a setting of
//	*** "PROXY hostname:port" that matches your blackhole server!!
//	***
//
//	***
//	*** If you already use a proxy server to access the WWW,
//	*** change the "normal" variable above from "DIRECT" to
//	*** be "PROXY proxy:port" to match your proxy server.
//	***


///////////////////////////////////////////////////////////////////////////////
//
// 3. TO CONFIGURE YOUR BROWSER
//
// The Proxy Auto Configuration file can be either on the local disk or
// accessed from a web server, with the following constraints:
//
//	a. IE4 can only load the PAC from a web server (http:// URL)
//	b. Netscape, Mozilla, Firefox and IE (5 or later) can load the
//	   PAC from anywhere.
//	c. Netscape, Mozilla, Firefox and (probably) Opera require the correct
//	   MIME type when loading the PAC from a web server.
//
//
// To set the Proxy Auto Configuration with Netscape, Mozilla, or Firefox:
//
//   1. Enable Proxy Auto Config:
//
//	For Netsacpe/Mozilla:
//
//		Open "Edit->Preferences"
//		Select "Advanced"
//		Select "Proxies"
//
//	For Firefox (1.0):
//
//		Open "Tools->Options"
//		Select "Coonection Settings" on the General tab:
//
//	Select the "Auto proxy configuration URL" option.
//	Enter URL or path of where you've saved this file, such as:
//
//		http://yourserver/no-ads.pac
//
//	If you place this on your local disk, you should use a
//	file: URL such as:
//
//		file:/home/loverso/no-ads.pac			(UNIX)
//		file:///c:/windows/desktop/no-ads.pac		(Windows)
//
//	(file:/ and file:// will work in Mozilla, but file:/// is correct
//	required for Firefox)
//
//   2. If you are serving this from a web server, these browsers require
//      the correct MIME type on the file before using it.  You must configure
//      your web server to provide a "application/x-ns-proxy-autoconfig"
//	MIME type.
//
//      a. For Apache, name the file with a ".pac" extension and add this
//	   line to the http.conf (or the .htaccess file in the same directory):
//
//		AddType application/x-ns-proxy-autoconfig .pac
//
//      b. For IIS (instructions from Kevin Roth)
//
//	   Open Internet Services Manager
//	   Right click on the web site (or directory) you wish to change.
//	   Choose Properties
//	   Click the "HTTP Headers" tab
//	   Click the "File Types" button in the "MIME Map" section
//	   Click the "New Type..." button
//	   Enter "pac" for "Associated Extension"
//	   Enter "application/x-ns-proxy-autoconfig" for "Content Type (MIME)"
//	   Click OK to close the Add type dialog, the MIME types dialog,
//		and the main properties dialog.
//
//      (This is definately needed for NS, but not for IE)
//
//
// To set the Proxy Auto Configuration with IE:
//
//   1. Enable Proxy Auto Config:
//
//	Open "Tools->Internet Options"
//	Select "Connections" tab
//	Click "LAN Settings"
//		or Choose an entry from "Dial-up settings" and click "Settings"
//
//	On the settings dialog, select "Use automatic configuration script"
//	Enter the URL of this file in Address field.
//
//		http://yourserver/no-ads.pac
//		file:///c:/windows/desktop/no-ads.pac		(Windows)
//
//	You can only use a file: URL with IE5 (or later).
//	("file:///" with with IE versions after 5.0 SP2)
//
//   2. Fix Security Settings (IMPORTANT):
//
//	Select "Security" tab
//	Select "Local intranet"
//	Click "Sites" box
//	Unselect "include all sites that bypass the proxy server" option
//
//   3. Disable "Auto Proxy Caching" (IMPORTANT):
//      (thanks to Kevin Roth for alerting me of this!)
//
//	IE contains a proxy result caching mechanism that will defeat the
//	ability to block servers that server both ad and non-ad content.
//	To prevent this, add the registry key described in this MS KB article:
//
//		http://support.microsoft.com/?kbid=271361
//
//	You can do so by downloading this file and clicking on it to load
//	it into the registry.  This must be done on a per-user basis.
//	http://www.schooner.com/~loverso/no-ads/IE-no-auto-proxy-cache.reg
//
//   IE doesn't currently check the MIME type of the PAC file.
//
//   To see some notes from MS on PAC in IE, see
//	http://msdn.microsoft.com/library/periodic/period99/faq0599.htm
//	(they seem to have removed this URL)
//
//
// To set the Proxy Auto Configuration with Opera 6 (6.04 on Windows tested):
//
//   1. Enable Proxy Auto Config:
//	Open the Preferences (Alt-P)
//	Select "Network"
//	Click the "Proxy servers" box
//	Select "Use automatic proxy configuration"
//	Enter the URL of this file as
//
//		http://yourserver/no-ads.pac
//		file://c:/windows/desktop/no-ads.pac
//
//	(file:/// might be needed; I've not tested Opera lately)
//
//   2. You must use a blackhole proxy for Opera (it will not work with an
//	address of a server that does not respond).
//
//   3. Be sure to clear the cache and exit/restart Opera.
//


///////////////////////////////////////////////////////////////////////////////
//
// 4. CLEAR YOUR BROWSER'S CACHE
//
// For Internet Explorer:
//
//	Open "Tools->Internet Options"
//	Select "Delete Files" under "Temporary Internet Files"
//	Click "OK"
//
// For Mozilla/Netscape Navigator:
//
//	Open "Edit->Preferences"
//	Select "Advanced"
//	Select "Proxies"
//	Click "Clear Disk Cache"
//	Click "Clear Memory Cache"
//
// For Firefox:
//
//	Open "Tools->Options"
//	Select the "Privay" tab
//	Scroll down or go to the "Cache" section
//	Click "Clear"
//
// For Opera:
//
//	Open "File->Preferences"
//	Select "History and cache"
//	Click "Empty now"
//


///////////////////////////////////////////////////////////////////////////////
//
// To see the definition of this page's JavaScript contents, see
//
//	http://home.netscape.com/eng/mozilla/2.0/relnotes/demo/proxy-live.html
//
// Microsoft includes this in their KB article:
//
//	http://support.microsoft.com/support/kb/articles/Q209/2/66.ASP
//
// Special PAC functions:
// Hostname:
//	isPlainHostName(host)
//	dnsDomainIs(host, domain)
//	localHostOrDomainIs(host, hostdom)
//	isResolvable(host)
//	isInNet(host, pattern, mask)
// Utility:
//	dnsResolve(host)
//	myIpAddress()
//	dnsDomainLevels(host)
// URL:
//	shExpMatch(str, shexp)
// Time:
//	weekdayRange(wd1, wd2, gmt)
//	dateRange(...)
//	timeRange(...)
//
// Other functions and methods that may work:
//	http://developer.netscape.com/docs/manuals/communicator/jsref/win1.htm
//	Note that "alert()" only works with Netscape4 and IE, and Mozilla 1.4+.
//
// NOTE:
//	isInNet() will resolve a hostname to an IP address, and cause
//	hangs on Mozilla/Firefox.  Currently, these are stubbed out and replaced
//	with shExpMatch(host, "a.b.c.*"), which doesn't do the same thing,
//	but is sufficient for these purposes.
//
// Additional Mozilla/Firefox comments:
//
//	All the above PAC functions are implemented in JavaScript,
//	and are added to the body of your PAC file when it is loaded.
//	See the "components/nsProxyAutoConfig.js" browser install
//	directory.
//
//	- shExpMatch() is implemented as three pattern.replaces()
//		 followed by a call to RegExp()  (SLOW)
//	- isPlainHostname() just checks for lack of "." in the string
//	- dnsDomainIs() just matches strings exactly
//	- alert() is bound to this.proxyAlert(), which displays a message
//		in the JavaScript console window

///////////////////////////////////////////////////////////////////////////////
//
// Regular Expressions
//
// Angus Turnbull pointed out the JavaScript 1.2 RE operators to me.
// These should work in NS4 and IE4 (or later), but I have only tested on
// Mozilla (1.3), IE5.5, and IE6.  PLEASE TELL ME IF IT WORKS FOR YOU!
//
// A good introduction is at:
//	http://www.evolt.org/article/Regular_Expressions_in_JavaScript/17/36435/
// Some references:
//	(old Netscape documentation is gone)
//	http://devedge.netscape.com/library/manuals/2000/javascript/1.5/reference/regexp.html
//	http://developer.netscape.com/docs/manuals/js/client/jsref/regexp.htm
//	http://www.webreference.com/js/column5/
//	http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/js56jsobjRegExpression.asp
//	http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/js56jsgrpRegExpSyntax.asp
// Real-time evaluator:
//	http://www.cuneytyilmaz.com/prog/jrx/
//
// I'm slowly replacing multiple glob patterns with regexps.
// By using RE literals of /.../ rather than the constructor 'new RegExp()',
// the regexps should be compiled as no-ads.pac is loaded.
// 
// Important notes:
// -	if using the constructor, \ needs to be quoted; thus "\\." is used
//	to match a literal '.'.  In the RE literal form, I need to end up
//	quoting any / for a URL path.
// -    Avoid these for now; they are broken or not supported in "older"
//	browsers such as NS4 and IE4:
//	- look-aheads (?=pat)
//	- non-greedy ? - a ? that follows *,+,?, and {}; (s)? is NOT non-greedy
//

///////////////////////////////////////////////////////////////////////////////

var isActive = 1;

function FindProxyForURL(url, host) {
    //DEBUG alert("checking: url=" + url);

    // Excellent kludge from Sean M. Burke:
    // Enable or disable no-ads for the current browser session.
    //
    // To disable, visit this URL:		http://no-ads.int/off
    // To re-enable, visit this URL:		http://no-ads.int/on
    //
    // (this will not work with Mozilla or Opera if the alert()s are present)
    //
    // This happens before lowercasing the URL, so make sure you use lowercase!
    //
    if (shExpMatch(host, "no-ads.int")) {
        if (shExpMatch(url, "*/on*")) {
            isActive = 1;
            //LOG alert("no-ads has been enabled.\n" + url);
        } else if (shExpMatch(url, "*/off*")) {
            isActive = 0;
            //LOG alert("no-ads has been disabled.\n" + url);
        } else if (shExpMatch(url, "*no-ads.int/")) {
            alert("no-ads is " + (isActive ? "enabled" : "disabled") + ".\n" + url);
        } else {
            alert("no-ads unknown option.\n" + url);
        }

        return blackhole;
    }

    if (!isActive) {
        //LOG3 alert("no-ads inactive bypass: " + url);
        return bypass;
    }

    // Suggestion from Quinten Martens
    // Make everything lower case.
    // WARNING: all shExpMatch rules following MUST be lowercase!
    url = url.toLowerCase();
    host = host.toLowerCase();

    //
    // Local/Internal rule
    // matches to this rule get the 'local' proxy.
    // Adding rules here enables the use of 'local'
    //
    if (0
        //LOCAL-RULES
        // add rules such as:
        //	|| dnsDomainIs(host, "schooner.com")
        //	|| isPlainHostName(host)
        // or for a single host
        //	|| (host == "some-local-host")
    ) {
        //LOG3 alert("no-ads local: " + url);
        return localproxy;
    }

    //hosts to push out to a SOCKS proxy
    if (0
        //SOCKS-RULES
    ) {
        //LOG3 alert("no-ads socks: " + url);
        return socksproxy;
    }

    //
    // Whitelist section (originally from InvisiBill)
    //
    // Include sites here that should never be matched for ads.
    //
    if (0

    ) {
        //LOG3 alert("no-ads whitelist: " + url);
        return normal;
    }

    // Remove the "//DEBUG2" to enable debug messages
    if (0
        //BLOCK-RULES
        //DEBUG2 || alert("start")

        //////

        || _dnsDomainIs(host, "ads.allizom.org")
        || _dnsDomainIs(host, "ads.mozilla.org")
        || _dnsDomainIs(host, "ads.nonprod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "ads.prod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "contile.services.mozilla.com")
        || _dnsDomainIs(host, "contile-images.services.mozilla.com")
        || _dnsDomainIs(host, "firefox-android-home-recommendations.getpocket.com")
        || _dnsDomainIs(host, "spocs.getpocket.com")
        || _dnsDomainIs(host, "spocs.getpocket.dev")
        || _dnsDomainIs(host, "spocs.mozilla.net")
        || _dnsDomainIs(host, "snippets.allizom.org")
        || _dnsDomainIs(host, "snippets.cdn.mozilla.net")
        || _dnsDomainIs(host, "snippets.mozilla.com")
        || _dnsDomainIs(host, "snippets-prod.moz.works")
        || _dnsDomainIs(host, "snippets-prod.frankfurt.moz.works")
        || _dnsDomainIs(host, "snippets-prod.oregon-b.moz.works")
        || _dnsDomainIs(host, "snippets-stage.moz.works")
        || _dnsDomainIs(host, "snippets-stage.oregon-b.moz.works")
        || _dnsDomainIs(host, "anonymco.com")
        || _dnsDomainIs(host, "asan-nightly-frontend-elb-1348905149.us-east-2.elb.amazonaws.com")
        || _dnsDomainIs(host, "anf1.fuzzing.mozilla.org")
        || _dnsDomainIs(host, "crash-reports.allizom.org")
        || _dnsDomainIs(host, "crash-reports.mozilla.com")
        || _dnsDomainIs(host, "crash-reports-xpsp2.mozilla.com")
        || _dnsDomainIs(host, "crash-stacks.mozilla.com")
        || _dnsDomainIs(host, "crash-stats.allizom.org")
        || _dnsDomainIs(host, "crash-stats.mozilla.com")
        || _dnsDomainIs(host, "crash-stats.mozilla.org")
        || _dnsDomainIs(host, "socorro.nonprod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "socorro.prod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "socorro-collector.services.mozilla.com")
        || _dnsDomainIs(host, "socorro-webapp-allizom.stage.mozaws.net")
        || _dnsDomainIs(host, "socorro-webapp.services.mozilla.com")
        || _dnsDomainIs(host, "talkback.mozilla.org")
        || _dnsDomainIs(host, "talkback-public.mozilla.org")
        || _dnsDomainIs(host, "talkback-reports.mozilla.org")
        || _dnsDomainIs(host, "experimenter.services.mozilla.com")
        || _dnsDomainIs(host, "experimenter.nonprod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "experimenter.prod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "normandy.cdn.mozilla.net")
        || _dnsDomainIs(host, "normandy.nonprod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "normandy.prod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "normandy-cdn.services.mozilla.com")
        || _dnsDomainIs(host, "download-stats.mozilla.org")
        || _dnsDomainIs(host, "download-stats.r53-2.services.mozilla.com")
        || _dnsDomainIs(host, "dap.services.mozilla.com")
        || _dnsDomainIs(host, "dap.nonprod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "dap.prod.webservices.mozgcp.net")
        || _dnsDomainIs(host, "divviup.org")
        || _dnsDomainIs(host, "data.mozilla.com")
        || _dnsDomainIs(host, "dataops.mozgcp.net")
        || _dnsDomainIs(host, "dataservices.mozgcp.net")
        || _dnsDomainIs(host, "fuzzing.mozilla.org")
        || _dnsDomainIs(host, "incoming-telemetry.thunderbird.net")
        || _dnsDomainIs(host, "pipeline-incoming-prod-elb-149169523.us-west-2.elb.amazonaws.com")
        || _dnsDomainIs(host, "incoming.telemetry.mozilla.org")
        || _dnsDomainIs(host, "telemetry.mozilla.org")
        || _dnsDomainIs(host, "telemetry-data.r53-2.services.mozilla.com")
        || _dnsDomainIs(host, "telemetry-incoming.r53-2.services.mozilla.com")
        || _dnsDomainIs(host, "telemetry-prod-1054754349.us-east-1.elb.amazonaws.com")
        || _dnsDomainIs(host, "analytics.getpocket.com")
        || _dnsDomainIs(host, "sentry.nonprod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "sentry.prod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "telemetry-coverage.mozilla.org")
        || _dnsDomainIs(host, "telemetry-coverage.r53-2.services.mozilla.com")
        || _dnsDomainIs(host, "discovery.addons.allizom.org")
        || _dnsDomainIs(host, "discovery.addons.mozilla.org")
        || _dnsDomainIs(host, "discovery.addons-dev.allizom.org")
        || _dnsDomainIs(host, "merino.nonprod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "merino.prod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "merino.services.mozilla.com")
        || _dnsDomainIs(host, "fakespot.com")
        || _dnsDomainIs(host, "fakespot.io")
        || _dnsDomainIs(host, "mozilla-ohttp-fakespot.fastly-edge.com")
        || _dnsDomainIs(host, "getpocket.cdn.mozilla.net")
        || _dnsDomainIs(host, "getpocket.com")
        || _dnsDomainIs(host, "getpocket.dev")
        || _dnsDomainIs(host, "getpocket-cdn.prod.mozaws.net")
        || _dnsDomainIs(host, "img-getpocket.cdn.mozilla.net")
        || _dnsDomainIs(host, "pocket.prod.cloudops.mozgcp.net")
        || _dnsDomainIs(host, "pocket-image-cache.com")
        || _dnsDomainIs(host, "widgets.getpocket.com")
        || _dnsDomainIs(host, "google-analytics.com")
        || _dnsDomainIs(host, "googlesyndication.com")
        || _dnsDomainIs(host, "googletagmanager.com")
        || _dnsDomainIs(host, "analytics.google.com")
        || _dnsDomainIs(host, "googletagmanager.com")
        || _dnsDomainIs(host, "googletagservices.com")
        || _dnsDomainIs(host, "braze.com")
        || _dnsDomainIs(host, "sentry.io")
        || _dnsDomainIs(host, "omappapi.com")
        || _dnsDomainIs(host, "250analytics.com")
        || _dnsDomainIs(host, "dap-09-3.api.divviup.org")

        //EXTRA-BLOCK-RULES
    ) {
        //LOG2 alert("no-ads blocking: " + url);

        // deny this request
        return blackhole;

    } else {
        //LOG3 alert("no-ads allowing: " + url);

        // all other requests go direct and avoid any overhead
        return normal;
    }
}

///////////////////////////////////////////////////////////////////////////////
//
// This line is just for testing; you can ignore it.  But, if you are having
// problems where you think this PAC file isn't being loaded, then change this
// to read "if (1)" and the alert box should appear when the browser loads this
// file.
//
// This works for IE4, IE5, IE5.5, IE6 and Netscape 2.x, 3.x, and 4.x.
// (For IE6, tested on Win2K)
// This does not work for Mozilla before 1.4 (and not for Netscape 6.x).
// In Mozilla 1.4+ and Fireox, this will write to the JavaScript console.
//
if (0) {
    alert("no-ads.pac: LOADED:\n" +
        "	version:	" + noadsver + "\n" +
        "	blackhole:	" + blackhole + "\n" +
        "	normal:		" + normal + "\n" +
        "	localproxy:	" + localproxy + "\n" +
        "	bypass:		" + bypass + "\n"
        //MSG
    );
}

// an alert that returns true (normally it returns void)
function alertmatch(str) {
    alert(str);
    return 1;
}

///////////////////////////////////////////////////////////////////////////////
//
// Replacement function for dnsDomainIs().  This is to replace the
// prefix problem, which a leading '.' used to be used for.
//
//	dnsDomainIs("bar.com", "bar.com") => true
//	dnsDomainIs("www.bar.com", "bar.com") => true
//	dnsDomainIs("www.foobar.com", "bar.com") => true	<<< incorrect
//
//	_dnsDomainIs("bar.com", "bar.com") => true
//	_dnsDomainIs("www.bar.com", "bar.com") => true
//	_dnsDomainIs("www.foobar.com", "bar.com") => false	<<< correct
//
// 2016 update: Firefox 47 is broken:
//
//	dnsDomainIs("bar.com", ".bar.com") => false		<<< incorrect
//
function _dnsDomainIs(host, domain) {
    if (host.length > domain.length) {
        return (host.substring(host.length - domain.length - 1) == "." + domain);
    }
    return (host == domain);
}

///////////////////////////////////////////////////////////////////////////////

// eof
