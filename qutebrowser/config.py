c.content.private_browsing = True
c.content.javascript.enabled = False

config.set('content.javascript.enabled', True, '*://github.com/*')
config.set('content.javascript.enabled', True, '*://localhost/*')
config.set('content.javascript.enabled', True, '*://*.duckduckgo.com/*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.bind('m', 'hint links spawn --detach mpv {hint-url}')
