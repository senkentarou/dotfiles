" Git grep on current word
function! s:GGrepCurrentWordQuery() abort
  let cword = expand('<cword>')
  execute 'Gina grep ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:GGrepCurrentWordQuery()

function! s:GGrepVisualWordQuery() abort
  execute "normal! `<v`>y"
  let vtext = @@
  execute 'Gina grep ' . vtext
endfunction
command! -nargs=* GGrepVisualWordQuery call s:GGrepVisualWordQuery()

function! s:GGrepPreviousWordQuery() abort
  let prev_word = histget('@', -1)
  if len(prev_word) > 0
    execute 'Gina grep ' . prev_word
  endif
endfunction
command! -nargs=* GGrepPreviousWordQuery call s:GGrepPreviousWordQuery()

function! s:GLogCurrentFile() abort
	let cfile = expand('%')
	execute "Gina log --opener=vsplit " . cfile
endfunction
command! -nargs=* GLogCurrentFile call s:GLogCurrentFile()

function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    "bd .git/index
    execute 'close'
  else
    execute 'vertical Git'
  endif
endfunction
command!  -nargs=* ToggleGStatus call ToggleGStatus()

" Open git blame file on web browser
function! s:openCurrentBlameFile() abort
  let line = line('.')
  let commit_hash = substitute(system('git blame -l -L ' . line . ',+1 ' . expand('%') . ' | cut -d" " -f1'), '\n', '', 'g')
  if len(commit_hash) == 0 || commit_hash == 0000000000000000000000000000000000000000
    echo 'commit hash is not found in git: ' . commit_hash
    return
  endif

  let git_remote_path = substitute(system("git remote -v | grep $(git remote | tail -1) | awk '{print $2}' | uniq | cut -d '/' -f 4,5 | sed 's/.git//g'"), '\n', '', 'g')
  let joined_path = join([git_remote_path, 'commit', commit_hash], '/')
  let open_url = 'https://github.com/' . joined_path

  if exists('g:loaded_openbrowser') && g:loaded_openbrowser
    " open browser directly
    execute 'OpenBrowser ' . open_url
  else
    " show only open_url
    echo open_url
  endif
endfunction
command! -nargs=* OpenCurrentBlameFile call s:openCurrentBlameFile()

" Open all additional change files in buffer
function! s:GitOpenAdditionalFiles() abort
  let goafs = systemlist("git status --porcelain | grep -wv D | awk '{print $2}'")
  let length = len(goafs)
  if length == 0
    echo 'No git additional files.'
    return
  endif
  " Open each file in buffer
  for goaf in goafs
    execute 'e ' . goaf
  endfor
  echo 'Opened ' . length . ' git additional files.'
endfunction
command! -nargs=* GitOpenAdditionalFiles call s:GitOpenAdditionalFiles()

" Open gina commit with opening message
function! s:OpenGitCommit() abort
  if len(systemlist('git diff --cached --shortstat')) > 0
    echo 'Opening git commit ...'
    execute 'Gina commit -v'
  echo
    echo 'No staged file.'
  endif
  function! s:clearDisplay(timer)
      echo ''
  endfunction
  call timer_start(1000, function("s:clearDisplay"))
endfunction
command! -nargs=* OpenGitCommit call s:OpenGitCommit()

" gitgutter
let g:gitgutter_highlight_lines = 0
