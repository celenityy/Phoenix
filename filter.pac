//
// PAC (Proxy Auto Configuration) Filter
// Available at:
//
//	http://www.hostsfile.org/pac.html
//
// Primary Code Author:
//	Danny R. Johnston
//	(REGEXP GURU)
// Pattern, Tracker, and Malware Analyzer
//	David Alexander Harvey
//	alias  Henry Hertz Hobbit
//      hhhobbit GNAT securemecca.net
// Original List:
//	Eric Phelps
//	http://www.ericphelps.com/security/pac.htm
//
// Version:		7.3.2
// Release Date:	Tuesday  17 April 2018
//
// (C) Copyright 2006-2018
// David Alexander Harvey  alias  Henry Hertz Hobbit
// Danny R Johnston
// With contributions by Eric Phelps
// With contributions by Rodney  alias  DomainAnalysis
// With contributions by Elric Scott
// With contributions by Stefan Welch
//
// http://www.gnu.org/licenses/lgpl.txt
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE.  See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with this program; if not, write to the Free
// Software Foundation, Inc., 59 Temple Place, Suite 330,
// Boston, MA  02111-1307  USA
//
// If you normally use a proxy, replace "DIRECT" below with
// "PROXY MACHINE:PORT"
// where MACHINE is the IP address or host name of your proxy
// server and PORT is the port number of your proxy server.
var normal = "DIRECT";
var blackhole = "PROXY 0.0.0.0:80";

// WARNING:  Opera, Konqueror, AND Safari USERS MUST NEVER SET DEBUG TO
// ANYTHING OTHER THAN debugNone.  THE alert() CALL CAUSES THEM TO FAIL!

var fullParse = 0;	// Parse the whole thing.
var pathParse = 0;	// Parse the host & path but no CGI args or anchors.
var parseURL = pathParse;

// WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
// The arrays below are for words to disallow or allow host or URLS. Be
// very carefull about adding things if you don't understand regular
// expressions.  They can be very tricky. Danny has set up a function to
// escape periods so you don't have to worry about their special
// meanings in regular expressions but all the other stuff works.  One
// handy regular expression you may need to use is the brackets [] and
// the caret ^. When used in an expression like "[^c]lips" it will match
// lips but not clips. Please note that you do not use something like
// that in any of the following ways:
//
// GoodDomains		at the end
// BadDomains		at the end
//
// BadURL_Parts		okay anywhere
// BadHostParts		okay anywhere
//
// BadURL_WordStarts	at the begining
// BadHostWordStarts	at the begining
//
// BadURL_WordEnds	at the end
// BadHostWordEnds	at the end
//
// You MUST do it this way due to anchors in the regular expressions
// that are generated from them.  If you do use a character that is
// used in regular expressions you must double backslash them to
// escape them due to the way the regular expressions are generated
// from the strings. One escape will be eaten by the string generation
// and escape the second one that will be passed to the regular
// expression parser.
//
// http://www.webreference.com/js/column5/ is a good site for learning
// about regular expressions

// Please also note that some words you may think are bad may be
// embedded.  For example "cheapornothing" has the word "porn" in it.
// Likewise "stockmansexchange" has "sex" in it. Buried inside a phrase
// like that, it might be okay.  However, it's harder to imagine a
// "good" phrase that starts or finishes with the word "sex" or "porn",
// so you would not want to put it in the BadURL_Parts array but probably
// would want it in one or both of the BadURL_WordStart or BadURL_WordEnd
// arrays.  Nevertheless, until a false positive shows up, the word
// "porn" is not allowed anywhere in a URL.  As soon as that rule elicits
// a false positive, it will be downgraded to HOST, and the start and end
// rules will be uncommented and activated for the URL.

// Here are what the arrays do:
//
// GoodDomains		Regular expressions that must match the end of
//			a host name to force a URL to pass.
// GoodNetworks		Network number followed by a netmask for ranges
//			of good networks
// BadNetworks		Network number followed by a netmask for ranges
//			of bad networks
// BadDomains		Regular expressions that must match the end of
//			a host name to force a URL to fail.
//
// BadURL_Parts		Words that will cause blocking if they show up
//			anywhere in a URL.
// BadHostParts		Regular expressions the will cause a URL to fail
//			if found anywhere in the HOST name.
//
// BadURL_WordStarts	Regular expressions that will cause a URL to
//			fail if they have a non alpha character before
//			them anywhere in a URL.
// BadHostWordStarts	Regular expressions that will cause a HOST to
//			fail if they have a non alpha character before
//			them in a HOST name or start the host name.
//
// BadURL_WordEnds	Regular expressions that will cause a URL to
//			fail if they have a non alpha character following
//			them or are at the very end of a URL.
// BadHostWordEnds	Regular expressions that will cause a HOST to
//			fail if they have a non alpha character following
//			them or are at the very end of a HOST name.
//
// NOTE: Even if a URL fails it may still be passed if the IP is in RFC
//	reserved nets.  This is because any thing that is behind your
//	firewall using these addresses are considered safe and should
//	never exist in the internet. These are defined at the very
//	bottom of the function FindProxyForURL and if you want to
//	modify them you must do it there.

// Counter Variable to initalize the arrays.
var i = 0;

// If the host name ends in any of the following domains it will be passed
// WARNING - DO NOT PUT REGEXPs AT THE *END* OF THIS ARRAY
var GoodDomains = new Array();
i = 0;
//GoodDomains[i++] = "aax-eu.amazon-adsystem.com"; // amazon.fr - 2018-03-31

// Add any good networks here. Format is network folowed by a comma and
// optional white space, and then the netmask.
var GoodNetworks = new Array();
i = 0;
//GoodNetworks[i++] = "10.0.0.0,		255.0.0.0";	// NRIP

// Add any bad networks here. Format is network folowed by a comma and
// optional white space, and then the netmask.
var BadNetworks = new Array();
i = 0;
//BadNetworks[i++] = "66.150.161.32,	255.255.255.224"; // PARKFUNNEL - 2010-04-20


// If the host name ends with any of the following domains the
// FindProxyForURL function will reject it unless it was previously
// matched by any of the GoodDomains or the IP is in a safe range.
// WARNING - DO NOT PUT REGEXPs AT THE *END* OF THIS ARRAY
var BadDomains = new Array();
i = 0;
BadDomains[i++] = "wikipedia.org";			// Tracker - 2010-03-12


// If any of the following BadURL_Parts show up anywhere in the URL
// the FindProxyForURL will reject it unless the resulting IP is
// in a safe range.  You can put REGEXPs anywhere you want here.
var BadURL_Parts = new Array();
i = 0;
//BadURL_Parts[i++] = "3rabnaar";			// Malware - 2010-05-07

// If the HOST name has any of the following words in it the
// FindProxyForURL function will reject it unless it matched any
// of the GoodDomains or the IP is in a safe range.
// You can put REGEXPs anywhere you want here.
var BadHostParts = new Array();
i = 0;
//BadHostParts[i++] = "-----";			// illegal name - 2013-10-09

// If any of the following BadURL_WordStarts show up at the start of a
// word in the URL the FindProxyForURL will reject it unless the
// resulting IP is in a safe range.
// WARNING - DO NOT PUT REGEXPs AT THE *START* OF THIS ARRAY
var BadURL_WordStarts = new Array();
i = 0;
//BadURL_WordStarts[i++] = "activexsetup";	// Malware - 2011-01-26

// If any of the following BadHostWordStarts show up at the start of a
// word in the HOST the FindProxyForURL will reject it unless the
// resulting IP is in a safe range.
// WARNING - DO NOT PUT REGEXPs AT THE *START* OF THIS ARRAY
var BadHostWordStarts = new Array();
i = 0;
//BadHostWordStarts[i++] = "adserver";		// YOUR CHOICE AdServer - 2009-10-06

// If any of the following BadURL_WordEnds show up at the end of a
// word in the URL the FindProxyForURL will reject it unless the
// resulting IP is in a safe range.
// WARNING - DO NOT PUT REGEXPs AT THE *END* OF THIS ARRAY
var BadURL_WordEnds = new Array();
i = 0;
//BadURL_WordEnds[i++] = "-ad-manager";		// AdServer - 2011-05-16

// If any of the following BadHostWordEnds show up at the end of a
// word in the HOST the FindProxyForURL will reject it unless the
// resulting IP is in a safe range.
// WARNING - DO NOT PUT REGEXPs AT THE *END* OF THIS ARRAY
var BadHostWordEnds = new Array();
i = 0;
//BadHostWordEnds[i++] = "analytics\.live\.com";	// Tracker - 2011-02-26

///////////////////////////
// Set up GoodDomainRegx //
///////////////////////////

for (i in GoodDomains) {
    GoodDomains[i] = GoodDomains[i].split(/\./).join("\\.");
}

var GoodDomainRegx = new RegExp("(" + GoodDomains.join("|") + ")$", "i");

//////////////////////////
// Set up BadDomainRegx //
//////////////////////////

for (i in BadDomains) {
    BadDomains[i] = BadDomains[i].split(/\./).join("\\.");
}

var BadDomainRegx = new RegExp("(" + BadDomains.join("|") + ")$", "i");

///////////////////////////
// Set up BadHostPartRegx //
///////////////////////////

for (i in BadHostParts) {
    BadHostParts[i] = BadHostParts[i].split(/\./).join("\\.");
}

var BadHostPartRegx = new RegExp(BadHostParts.join("|"), "i");

/////////////////////////////////
// Set up BadHostWordStartRegx //
/////////////////////////////////

for (i in BadHostWordStarts) {
    BadHostWordStarts[i] = BadHostWordStarts[i].split(/\./).join("\\.");
}

var BadHostWordStartRegx = new RegExp("(^|[^a-z0-9])(" +
    BadHostWordStarts.join("|") + ")", "i");

///////////////////////////////
// Set up BadHostWordEndRegx //
///////////////////////////////

for (i in BadHostWordEnds) {
    BadHostWordEnds[i] = BadHostWordEnds[i].split(/\./).join("\\.");
}

var BadHostWordEndRegx = new RegExp("(" + BadHostWordEnds.join("|") +
    ")([^a-z0-9]|$)", "i");

////////////////////////////
// SET UP BadURL_PartRegx //
////////////////////////////

for (i in BadURL_Parts) {
    BadURL_Parts[i] = BadURL_Parts[i].split(/\./).join("\\.");
}

var BadURL_PartRegx = new RegExp(BadURL_Parts.join("|"), "i");

/////////////////////////////////
// SET UP BadURL_WordStartRegx //
/////////////////////////////////

for (i in BadURL_WordStarts) {
    BadURL_WordStarts[i] = BadURL_WordStarts[i].split(/\./).join("\\.");
}
var BadURL_WordStartRegx = new RegExp("[^a-z0-9](" +
    BadURL_WordStarts.join("|") + ")", "i");

///////////////////////////////
// SET UP BadURL_WordEndRegx //
///////////////////////////////

for (i in BadURL_WordEnds) {
    BadURL_WordEnds[i] = BadURL_WordEnds[i].split(/\./).join("\\.");
}

var BadURL_WordEndRegx = new RegExp("(" + BadURL_WordEnds.join("|") +
    ")([^a-z0-9]|$)", "i");

///////////////////////////////////////////
// Define the IsIPAddr function and vars //
///////////////////////////////////////////

var IpAddrRegx = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;

function IsNumIpAddr(host) {
    var ipAry = host.match(IpAddrRegx);
    var isIPValid = false;

    if (ipAry) {
        isIPValid = true;
        for (i = 1; i <= 4; i++) {
            if (ipAry[i] >= 256) {
                isIPValid = false;
            }
        }
    }
    return isIPValid;
}

/////////////////////
// Done Setting Up //
/////////////////////


//////////////////////////////////
// Define the FindProxyFunction //
//////////////////////////////////

function FindProxyForURL(url, host) {
    var TestResult;
    var FuncResult = normal;
    var str = "";
    var i = "";
    var tmpNet;
    var IsNumIP = IsNumIpAddr(host);
    var HasIPv4Address = true;
    var IPv4Address;

    ///////////////////////////////////////////////////////////////////////
    // FTP patch for privoxy - Elric Scott schemalogic.com               //
    // At one time I recommended privoxy.  Since this is a security hole //
    // I recommend using Firefox + NoScript instead. See WARNING.txt    //
    ///////////////////////////////////////////////////////////////////////

    //	if (url.substr(0,4) == "ftp:") {
    //		return "DIRECT";
    //	}

    ///////////////////////////////////////////////////////////////////////
    // Remove any anchors and arguments from the url if we are only      //
    // looking at the path part                                          //
    ///////////////////////////////////////////////////////////////////////

    if (parseURL == pathParse) {
        str = url.match(/^[^\?#]*/);
        if (str != url) {
            url = str;
        }
    }

    ///////////////////////////////////////////////////////////////////////
    // PASS LIST:   domains matched here will always be allowed.         //
    ///////////////////////////////////////////////////////////////////////

    if (!IsNumIP && (TestResult = GoodDomainRegx.exec(host))) {
        return normal;
    }

    ///////////////////////////////////////////////////////////////////////
    // Check to make sure we can get an IPv4 address from the given host //
    // name.  If we cannot do that then skip the Networks tests.         //
    ///////////////////////////////////////////////////////////////////////

    if (IsNumIP) {
        IPv4Address = host;
    }
    else {
        if (isResolvable(host)) {
            IPv4Address = dnsResolve(host);
        }
        else {
            HasIPv4Address = false;
        }
    }

    if (HasIPv4Address) {
        ///////////////////////////////////////////////////////////////////////
        // If the IP translates to one of the GoodNetworks we pass it        //
        // since it is considered to be safe.                                //
        ///////////////////////////////////////////////////////////////////////

        for (i in GoodNetworks) {
            tmpNet = GoodNetworks[i].split(/,\s*/);
            if (isInNet(IPv4Address, tmpNet[0], tmpNet[1])) {
                return normal;
            }
        }

        ///////////////////////////////////////////////////////////////////////
        // If the IP translates to one of the BadNetworks we fail it         //
        // since it is not considered to be safe.                            //
        ///////////////////////////////////////////////////////////////////////

        for (i in BadNetworks) {
            tmpNet = BadNetworks[i].split(/,\s*/);
            if (isInNet(IPv4Address, tmpNet[0], tmpNet[1])) {
                return blackhole;
            }
        }
    }

    //////////////////////////////////////////////////////////
    // BLOCK LIST:	stuff matched here here will be blocked //
    //////////////////////////////////////////////////////////

    if (!IsNumIP && (TestResult = BadDomainRegx.exec(host))) {
        return blackhole;
    }
    if (!IsNumIP && (TestResult = BadHostPartRegx.exec(host))) {
        return blackhole;
    }
    if (TestResult = BadHostWordStartRegx.exec(host)) {
        return blackhole;
    }
    if (TestResult = BadHostWordEndRegx.exec(host)) {
        return blackhole;
    }
    if (TestResult = BadURL_PartRegx.exec(url)) {
        return blackhole;
    }
    if (TestResult = BadURL_WordStartRegx.exec(url)) {
        return blackhole;
    }
    if (TestResult = BadURL_WordEndRegx.exec(url)) {
        return blackhole;
    }

    return normal;
}
