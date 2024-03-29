// In wayland firefox smoothscrolling is not really needed since scrolling is such high resolution
user_pref("general.smoothScroll", false);

// Enable encrypted SNI
user_pref("network.security.esni.enabled", true);

// Disable autofill of passwords/etc
user_pref("signon.rememberSignons", false);
user_pref("browser.formfill.enable", false);

// Enable ETP Strict mode
user_pref("browser.contentblocking.category", "strict");

// Resist Fingerprinting
// user_pref("privacy.resistFingerprinting", true);

// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Set toolbar
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\"],\"currentVersion\":16,\"newElementCount\":3}");
user_pref("browser.toolbars.bookmarks.visibility", "never");

// Enable userchrome
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Set theme
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
user_pref("devtools.theme", "auto");
user_pref("devtools.theme.show-auto-theme-info", false); // Hide notice about auto theme in dev-tools

// Disable new-tab page garbage
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "{\"enabled\":false}");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.rights.3.shown", true);

// Opt out of telemetry
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false); // Stop nagbar

// Disable captive portal detection
user_pref("network.captive-portal-service.enabled", false);

// Disable firefox suggest
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);

// Fixes rendering issues with transparent window elements
// user_pref("layers.acceleration.force-enabled", true);

// Disable privacy tab from opening on new profiles
user_pref("datareporting.policy.firstRunURL", "");

// Allow custom extension to be used
user_pref("xpinstall.signatures.required", false); // Disable checking signature
user_pref("extensions.autoDisableScopes", 14); // Allow use of extensions without user intervention

// Disable pocket
user_pref("extensions.pocket.enabled", false);

// Open devtools in separate window
user_pref("devtools.toolbox.host", "window");

// Set Highlight All when finding
user_pref("findbar.highlightAll", true);

// Make picture in picture button less obnoxious
user_pref("media.videocontrols.picture-in-picture.video-toggle.has-used", true);

// Enable spellcheck even on single line inputs
user_pref("layout.spellcheckDefault", 2);

// Disable webrtc indicator
user_pref("privacy.webrtc.hideGlobalIndicator", true);
user_pref("privacy.webrtc.legacyGlobalIndicator", false);

// Disable hiding toolbar on fullscreen
user_pref("browser.fullscreen.autohide", false);

// Remove topsites
user_pref("browser.topsites.useRemoteSetting", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");

// Disable firefox view
user_pref("browser.tabs.firefox-view", false);

// Use system font for emoji instead of firefox's fallback font
user_pref("font.name-list.emoji", "JoyPixels");

// Disable hiding url for search
user_pref("browser.urlbar.showSearchTerms.enabled", false);
