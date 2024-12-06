//
// Define the network paths (direct, proxy and deny)
//

// Default connection
var direct = "DIRECT";

// Default localhost for denied connections
var deny = "PROXY 127.0.0.1:65535";

//
// Proxy Logic
//

function FindProxyForURL(url, host) {

    // Anti-ads and Anti-porn
    if (dnsDomainIs(host, ".wikipedia.org")
        //|| dnsDomainIs(host, ".example.com")
        || dnsDomainIs(host, ".google.com")) { return deny; }
    else { return direct; }

    // Default DENY
    { return deny; }

}