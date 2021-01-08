// In wayland firefox smoothscrolling is not really needed since scrolling is such high resolution
user_pref("general.smoothScroll", false);

// Enable encrypted SNI
user_pref("network.security.esni.enabled", true);

// Disable autofill of passwords/etc
user_pref("signon.rememberSignons", false);
user_pref("browser.formfill.enable", false);

// Enable first-party isolation
user_pref("privacy.firstparty.isolate", true);

// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Set toolbar
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\"],\"currentVersion\":16,\"newElementCount\":3}");

// Enable userchrome
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Set dark theme
// user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
// user_pref("ui.systemUsesDarkTheme", 1);
// user_pref("devtools.theme", "dark");

// Disable new-tab page garbage
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "{\"enabled\":false}");
user_pref("browser.startup.homepage_override.mstone","ignore");
user_pref("browser.rights.3.shown", true);

// Opt out of telemetry
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);

// Fixes rendering issues with transparent window elements
user_pref("layers.acceleration.force-enabled", true);

// Disable privacy tab from opening on new profiles
user_pref("datareporting.policy.firstRunURL", "");
