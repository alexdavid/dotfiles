c.editor.command = ['popup-term', 'nvim "{file}" -c "normal {line}G{column0}l"']
c.editor.encoding = 'utf-8'

config.set('downloads.location.directory', '~/Downloads')
config.set('downloads.location.prompt', False)
config.set('downloads.remove_finished', 5000)
config.set('fonts.default_family', 'SF Pro Display')
config.set('fonts.default_size', '14pt')
config.set('tabs.background', True)
config.set('tabs.show', 'multiple')

# Make :q work more like vim:
config.set('tabs.last_close', 'close')
config.set('aliases', {
    "q": "tab-close",
    "qa": "quit",
})

# Privacy
config.set('content.webrtc_ip_handling_policy', 'default-public-interface-only')

# Key bindings
config.unbind('d')
config.bind('m', 'hint links spawn --detach mpvsingleton {hint-url}')
config.bind('o', 'set-cmd-text -s :open -s')
config.bind('O', 'set-cmd-text -s :open -st')
config.bind('we', 'edit-url')


from os.path import expanduser
try:
    open(expanduser("~/.config/isdark")).close()
    config.set('colors.webpage.prefers_color_scheme_dark', True)
    config.set('colors.webpage.darkmode.enabled', True)
except FileNotFoundError:
    config.set('colors.webpage.darkmode.enabled', False)
    config.set('colors.webpage.prefers_color_scheme_dark', False)
