command! Gministatus :call g:Gministatus()
function! g:Gministatus()
  silent execute 'pedit ' . Get_git_top_level() . '/.git/mini-status'
  wincmd P
  silent execute 'lcd ' . Get_git_top_level()
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap modifiable
  normal! ggdG
  silent execute '$read !git status -b --porcelain'
  call Set_Height()
  normal! ggdd
  execute '%sort /\(^[^#]. \)\@<=.*/ r'
  setlocal nomodifiable
  call Set_syntax()
  call Map_keys()
endfunction


function! Set_Height()
  if line('$') / &lines > 0.5
    execute 'resize ' . (&lines / 2)
  else
    execute 'resize ' . line('$')
  endif
endfunction


function! Get_git_top_level()
  return substitute(system('git rev-parse --show-toplevel'), '\n', '', '')
endfunction


function! Refresh()
  let line_number = line('.')
  call g:Gministatus()
  execute 'normal! '. line_number . 'G03l'
endfunction


function! Get_file_path()
  if Current_line_is_comment()
    return ''
  endif
  let line = getline('.')[3:]
  if Current_line_has_staged_rename()
    return Unescape_file_name(split(line, ' -> ')[0])
  endif
  return Unescape_file_name(line)
endfunction


function! Get_file2_path()
  return Unescape_file_name(split(getline('.'), ' -> ')[1])
endfunction

function Unescape_file_name(n)
  if a:n[0] == '"'
    return a:n[1:-2]
  endif
  return a:n
endfunction

function! Open_file(cmd)
  let file_path = Current_line_has_staged_rename() ? Get_file2_path() : Get_file_path()
  wincmd w

  " Close an existing diff if open
  windo if &diff | quit | endif

  execute a:cmd
  execute 'edit ' . fnameescape(Get_git_top_level() . '/' . file_path)
endfunction


function! Run_git_command(cmd)
  call system('git -C ' . shellescape(Get_git_top_level()) . ' ' . a:cmd)
endfunction


function! Run_git_command_in_terminal(cmd)
  execute '!git -C ' . shellescape(Get_git_top_level()) . ' ' . a:cmd
endfunction


function! Stage_file()
  let file_path = Current_line_has_staged_rename() ? Get_file2_path() : Get_file_path()

  if Current_line_has_unstaged_modification() || Current_line_is_untracked()
    call Run_git_command('add ' . shellescape(file_path))

  elseif Current_line_has_staged_changes()
    call Run_git_command('reset -- ' . shellescape(file_path))
    if Current_line_has_staged_rename()
      call Run_git_command('reset -- ' . shellescape(Get_file_path()))
    endif

  elseif Current_line_has_unstaged_delete()
    call Run_git_command('rm ' . shellescape(file_path))

  elseif Current_line_has_unmerged_modifications()
    call Run_git_command('add '. shellescape(file_path))

  else
    echo "Sorry, I don't know how to stage " . shellescape(file_path)
    return
  endif
  call Refresh()
endfunction


function! Patch_file()
  let file_path = Get_file_path()

  if Current_line_has_unstaged_modification()
    call Run_git_command_in_terminal('add --patch ' . shellescape(file_path))

  elseif Current_line_is_untracked()
    call Run_git_command('add -N ' . file_path)
    call Run_git_command_in_terminal('add --patch ' . shellescape(file_path))

  elseif Current_line_has_staged_changes()
    call Run_git_command_in_terminal('reset --patch -- ' . shellescape(file_path))

  else
    echo "Sorry, I don't know how to patch " . shellescape(file_path)
  endif
endfunction


function! Current_line_is_untracked()
  return getline('.') =~ '^??'
endfunction


function! Current_line_has_unstaged_modification()
  return getline('.') =~ '^[ MAR]M'
endfunction


function! Current_line_has_unstaged_delete()
  return getline('.') =~ '^[ MAR]D'
endfunction


function! Current_line_has_staged_changes()
  return getline('.') =~ '^[MADR] '
endfunction


function! Current_line_has_staged_rename()
  return getline('.') =~ '^R'
endfunction


function! Current_line_has_unmerged_modifications()
  return getline('.') =~ '^\(AA\|[UD]U\|UD\)'
endfunction


function! Current_line_is_comment()
  return getline('.') =~ '^#'
endfunction


function! Set_syntax()
  syn match GministatusLocalBranch /\(^## \)\@<=[^.]*/
  syn match GministatusRemoteBranch /\(^##.*\.\.\.\)\@<=.*/
  syn match GministatusStaged /^[MADRCU]/
  syn match GministatusUnstaged /\(^.\)\@<=[MADU]/
  syn match GministatusUntracked /^\(??\|!!\|##\)/

  hi GministatusStaged       ctermfg=2
  hi GministatusUnstaged     ctermfg=1
  hi GministatusUntracked    ctermfg=8
  hi GministatusLocalBranch  ctermfg=2
  hi GministatusRemoteBranch ctermfg=1
endfunction


function! Map_keys()
  map <buffer> <silent> -    :call Stage_file()<CR>
  map <buffer> <silent> r    :call Refresh()<CR>
  map <buffer> <silent> R    :call Refresh()<CR>
  map <buffer> <silent> t    :call Open_file('tabnew')<CR>
  map <buffer> <silent> s    :call Open_file('split')<CR>
  map <buffer> <silent> v    :call Open_file('vsplit')<CR>
  map <buffer> <silent> o    :call Open_file('')<CR>
  map <buffer> <silent> p    :call Patch_file()<CR>
  map <buffer> <silent> q    :q<CR>
  map <buffer> <silent> cc   :Gcommit<CR>
  map <buffer>          git  : <C-R>=Get_file_path()<CR><Home>!git<space>
  map <buffer> <silent> <CR> :call Open_file('')<CR>
  map <buffer>          .    : <C-R>=Get_file_path()<CR><Home>
endfunction
