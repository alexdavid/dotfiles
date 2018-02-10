let NERDTreeIgnore=['\~$']
let NERDTreeChDirMode=2
let g:nerdtree_tabs_open_on_gui_startup=0

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

call NERDTreeAddMenuItem({'text': '(+) chmod +x the current node', 'shortcut': '+', 'callback': 'NERDTreeChmodAddXFile'})
call NERDTreeAddMenuItem({'text': '(-) chmod -x the current node', 'shortcut': '-', 'callback': 'NERDTreeChmodRmXFile'})

function! NERDTreeChmodAddXFile()
  let node = g:NERDTreeFileNode.GetSelected()
  call system("chmod +x " . shellescape(node.path.str()))
endfunction

function! NERDTreeChmodRmXFile()
  let node = g:NERDTreeFileNode.GetSelected()
  call system("chmod -x " . shellescape(node.path.str()))
endfunction
