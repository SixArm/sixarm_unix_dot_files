// Firefox config settings to optimize browsing speed.
// From http://www.ubuntugeek.com/speed-up-firefox-web-browser.html
// See the comment from SergioJP
//
// Put this file in your Firefox profile directory, typically:
//   ~/.mozilla/firefox/*.default/

user_pref(”network.http.pipelining”, true);
user_pref(”network.http.proxy.pipelining”, true);
user_pref(”network.http.pipelining.maxrequests”, 20);
user_pref(”content.notify.backoffcount”, 5);
user_pref(”plugin.expose_full_path”, true);
user_pref(”ui.submenuDelay”, 0);
user_pref(”content.interrupt.parsing”, true);
user_pref(”content.max.tokenizing.time”, 2250000);
user_pref(”content.notify.interval”, 750000);
user_pref(”content.notify.ontimer”, true);
user_pref(”content.switch.threshold”, 750000);
user_pref(”content.notify.backoffcount”, 5);
user_pref(”nglayout.initialpaint.delay”, 0);
user_pref(”network.http.max-connections”, 48);
user_pref(”network.http.max-connections-per-server”, 16);
user_pref(”network.http.max-persistent-connections-per-proxy”, 16);
user_pref(”network.http.max-persistent-connections-per-server”, 8);
user_pref(”browser.cache.memory.capacity”, 32768);
user_pref(”browser.cache.disk.capacity”, 15000);
user_pref(”browser.turbo.enabled”, true);
user_pref(”network.dns.disableIPv6″, true);
user_pref(”browser.urlbar.clickSelectsAll”, true);
user_pref(”browser.urlbar.autoFill”, true);
user_pref(”layout.spellcheckDefault”, 2);
user_pref(”network.protocol-handler.app.lastfm”, "amarok");
user_pref(”network.protocol-handler.external.lastfm”, true);

