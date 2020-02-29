let g:lsc_server_commands = {
\  'go': {
\    'command': 'gopls serve',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  },
\  'rust': {
\    'command': 'rls',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  },
\  'typescript': {
\    'command': 'docker run --rm -i -v $PWD:$PWD alexdavid/ts-lsp',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  },
\  'typescript.tsx': {
\    'command': 'docker run --rm -i -v $PWD:$PWD alexdavid/ts-lsp',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  },
\}

let g:lsc_auto_map = {
\  'GoToDefinition': '<C-]>',
\  'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
\  'ShowHover': v:true,
\}
