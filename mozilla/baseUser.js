// General
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("extensions.pocket.enabled", false);
user_pref("general.warnOnAboutConfig", false);
user_pref("signon.rememberSignons", false);

// New tab page
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.migrationExpired", true);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.showSearch", true);
user_pref("browser.newtabpage.activity-stream.showTopSites", false);

// Prevent first run
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("startup.homepage_welcome_url", "about:blank");

// Clean up nav bar
user_pref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":[],"PersonalToolbar":[],"nav-bar":[],"TabsToolbar":[],"toolbar-menubar":[]}}');

// Use dark theme for most profiles
user_pref("lightweightThemes.selectedThemeID", "firefox-compact-dark@mozilla.org");

// Fix screen tearing while scrolling
user_pref("layers.acceleration.force-enabled", true);

// Opt out of firefox studies/sharing
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
