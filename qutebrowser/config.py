c.content.javascript.enabled = False

c.editor.command = ['popup-term', 'nvim {file} -c "normal {line}G{column0}l"']
c.editor.encoding = 'utf-8'

config.set('tabs.max_width', 250)

config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'http://localhost/*')
config.set('content.javascript.enabled', True, 'https://*.duckduckgo.com/*')
config.set('content.javascript.enabled', True, 'https://github.com/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Make :q work more like vim:
config.set('tabs.last_close', 'close')
config.set('aliases', {"q": "tab-close"})

# Privacy
config.set('content.webrtc_ip_handling_policy', 'default-public-interface-only')

# Key bindings
config.bind('d', None)
config.bind('m', 'hint links spawn --detach mpv {hint-url}')
config.bind('o', 'set-cmd-text -s :open -s')
config.bind('O', 'set-cmd-text -s :open -st')
config.bind('we', 'edit-url')
