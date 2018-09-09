c.content.private_browsing = True
c.content.javascript.enabled = False

c.editor.command = ['popup-term', 'vim {file} -c "normal {line}G{column0}l"']
c.editor.encoding = 'utf-8'

config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'http://localhost/*')
config.set('content.javascript.enabled', True, 'https://*.duckduckgo.com/*')
config.set('content.javascript.enabled', True, 'https://github.com/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Make :q work more like vim:
config.set('tabs.last_close', 'close')
config.set('aliases', {"q": "tab-close"})

config.bind('m', 'hint links spawn --detach mpv {hint-url}')
