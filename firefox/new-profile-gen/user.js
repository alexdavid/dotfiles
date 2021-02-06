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
user_pref("browser.toolbars.bookmarks.visibility", "never");

// Enable userchrome
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Set theme
user_pref("extensions.activeThemeID", "firefox-compact-light@mozilla.org");
user_pref("devtools.theme", "light");
// user_pref("ui.systemUsesDarkTheme", 0);

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
user_pref("datareporting.policy.dataSubmissionEnabled", false); // Stop nagbar

// Fixes rendering issues with transparent window elements
user_pref("layers.acceleration.force-enabled", true);

// Disable privacy tab from opening on new profiles
user_pref("datareporting.policy.firstRunURL", "");

// Disable require extension signature
user_pref("xpinstall.signatures.required", false);
user_pref("extensions.langpacks.signatures.required", false);

// Disable pocket
user_pref("extensions.pocket.enabled", false);

// Open devtools in separate window
user_pref("devtools.toolbox.host", "window");

// Set Highlight All when finding
user_pref("findbar.highlightAll", true);

// Make picture in picture button less obnoxious
user_pref("media.videocontrols.picture-in-picture.video-toggle.has-used", true);
