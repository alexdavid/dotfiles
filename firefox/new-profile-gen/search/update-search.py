import base64
import json
import lz4.block as lz4
import os

def engines():
    return [
        # Primary
        builtin_engine('DuckDuckGo', '!ddg'),
        builtin_engine('Wikipedia (en)', '!w'),
        custom_engine('OpenStreetMap', '!osm', 'https://www.openstreetmap.org/search?query={searchTerms}', 'osm.ico'),
        custom_engine('HackerNews', '!hn', 'https://hn.algolia.com/?q={searchTerms}', 'hn.ico'),

        # Development
        custom_engine('Go', '!go', 'https://pkg.go.dev/search?q={searchTerms}', 'go.ico'),
        custom_engine('NPM', '!npm', 'https://www.npmjs.com/search?q={searchTerms}', 'npm.png'),
        custom_engine('Node', '!node', 'https://nodejs.org/api/{searchTerms}.html', 'node.ico'),
        custom_engine('Rust Crates', '!crates', 'https://crates.io/search?q={searchTerms}', 'crates.ico'),
        custom_engine('Rust Docs', '!rust', 'https://docs.rs/releases/search?query={searchTerms}', 'rust.ico'),

        # Linux
        custom_engine('Archlinux Packages', '!pkg', 'https://archlinux.org/packages/?q={searchTerms}', 'archlinux.ico'),
        custom_engine('Archlinux AUR', '!aur', 'https://aur.archlinux.org/packages?O=0&K={searchTerms}', 'archlinux.ico'),
        custom_engine('ArchWiki', '!aw', 'https://wiki.archlinux.org/index.php?search={searchTerms}', 'archlinux.ico'),
        custom_engine('Alpine Packages', '!apk', 'https://pkgs.alpinelinux.org/packages?name={searchTerms}', 'alpine.ico'),

        # Last resort
        builtin_engine('Google', '!g'),
        custom_engine('Google Maps', '!gm', 'https://www.google.com/maps/search/{searchTerms}'),
        custom_engine('Apple Maps (via DDG)', '!am', 'https://duckduckgo.com/?q={searchTerms}&t=ffab&ia=web&iaxm=about'),

        # I don't use any of these search engines, but Firefox will auto-add these
        # again if they aren't specified so defining them with hidden = true is the
        # only way to make them go away:
        builtin_engine('Amazon.com', hidden=True),
        builtin_engine('Bing', hidden=True),
        builtin_engine('eBay', hidden=True),
    ]

def icon_to_base64(icon_file_name):
    iconf = open(os.path.join('icons', icon_file_name), 'rb')
    b64 = base64.b64encode(iconf.read()).decode('utf-8')
    iconf.close()
    return 'data:image;base64,' + b64

# For some reason despite engines being listed in an array which implies order,
# firefox relies on _metaData.order to determine the search engine order:
order = 0

def builtin_engine(name, alias=None, hidden=False):
    global order
    order += 1
    return {
      '_name': name,
      '_isAppProvided': True,
      '_metaData': {
          'alias': alias,
          'hidden': hidden,
          'order': order,
      },
    }

def custom_engine(name, alias, url_template, icon_file_name=None):
    global order
    order += 1
    return {
      '_name': name,
      '_isAppProvided': False,
      '_urls': [{ 'template': url_template }],
      '_iconURL': icon_to_base64(icon_file_name) if icon_file_name else None,
      '_metaData': {
          'alias': alias,
          'order': order,
      },
    }

search = {
  'version': 6,
  'engines': engines(),
  'metaData': {
    'current': 'DuckDuckGo',
    'useSavedOrder': True,
    'locale': 'en-US',
    'region': 'US'
  }
}

searchjson = bytes(json.dumps(search, separators=(',', ':')), 'utf-8')
searchlz4 = lz4.compress(searchjson)
f = open('search.json.mozlz4', 'wb')
f.write(b'mozLz40\0' + searchlz4)
f.close()
