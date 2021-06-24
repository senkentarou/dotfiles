" git-grepをfzf(preview)で開く

command! -nargs=* -bang Gitgrep call s:Gitgrep(<q-args>)

" 現在開いているファイルパス(current_dir)から.gitディレクトリがあるパスまで辿る
function! s:get_git_base_path(current_dir) abort
  if isdirectory(expand(a:current_dir . '/.git'))
    return a:current_dir
  else
    let split_dir = split(a:current_dir, '/')
    call remove(split_dir, -1)
    return s:get_git_base_path('/' . expand(join(split_dir, '/')))
  endif
endfunction

" 行が選択された場合、新しいバッファで開く
function! s:line_handler(line)
  let keys = split(a:line, ':')
  " path
  exec 'e '. keys[0]
  " line
  exec keys[1]

  normal! ^zz
endfunction

function! GGrep(query, fullscreen)
  let command_fmt = 'rg --sort-files --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'sink': function('s:line_handler'), 'dir': s:get_git_base_path(expand("%:p:h")), 'options': ['--reverse', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--prompt', 'GitGrep> ']}

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'right:50%', 'ctrl-/'), a:fullscreen)
endfunction

command! -nargs=* -bang GGrep call GGrep(<q-args>, <bang>0)

" Git grep by interactive input
function! s:GGrepInteractiveInput(cmd, query) abort
  if len(a:query) > 0
    let query_word = a:query
  else
    let query_word = input('[GitGrep] ')
  endif

  if len(query_word) > 0
    execute a:cmd . ' ' . query_word
    call histadd('@', query_word)
  end
endfunction
command! -nargs=* GGrepInteractiveInput call s:GGrepInteractiveInput('GGrep', <q-args>)
command! -nargs=* GinaGrepInteractiveInput call s:GGrepInteractiveInput('Gina grep', <q-args>)

" Git grep on current word
function! s:GGrepCurrentWordQuery(cmd) abort
  let cword = expand('<cword>')
  execute a:cmd . ' ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:GGrepCurrentWordQuery('GGrep')
command! -nargs=* GinaGrepCurrentWordQuery call s:GGrepCurrentWordQuery('Gina grep')

function! s:GGrepVisualWordQuery(cmd) abort
  execute "normal! `<v`>y"
  let vtext = @@
  if len(vtext) > 0
    execute a:cmd . ' ' . vtext
    call histadd('@', vtext)
  end
endfunction
command! -nargs=* GGrepVisualWordQuery call s:GGrepVisualWordQuery('GGrep')
command! -nargs=* GinaGrepVisualWordQuery call s:GGrepVisualWordQuery('Gina grep')

function! s:GGrepPreviousWordQuery(cmd) abort
  let prev_word = histget('@', -1)
  if len(prev_word) > 0
    execute a:cmd . ' ' . prev_word
    call histadd('@', prev_word)
  endif
endfunction
command! -nargs=* GGrepPreviousWordQuery call s:GGrepPreviousWordQuery('GGrep')
command! -nargs=* GinaGrepPreviousWordQuery call s:GGrepPreviousWordQuery('Gina grep')

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
  " search current buffer filename by fzf.vim function
  let current_file = bufname(fzf#vim#_buflisted_sorted()[0])
  let commit_hash = substitute(system('git blame -l -L ' . line . ',+1 ' . current_file . ' | cut -d" " -f1'), '\n', '', 'g')
  if len(commit_hash) == 0 || string(commit_hash) =~ '0000000000000000000000000000000000000000'
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
  " check diff files
  let goafs = systemlist("git status --porcelain | grep -wv D | awk '{print $2}'")
  let len_goafs = len(goafs)
  if len_goafs == 0
    echo 'No git additional files.'
    return
  endif
  " delete current open all buffers
  let open_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  if len(open_buffers) > 0
    execute 'bd ' . join(open_buffers, ' ')
  end
  " open each diff file in buffer
  for goaf in goafs
    execute 'e ' . goaf
  endfor
  echo 'Opened ' . len_goafs . ' git additional files.'
endfunction
command! -nargs=* GitOpenAdditionalFiles call s:GitOpenAdditionalFiles()

" Open gina commit with opening message
function! s:OpenGitCommit() abort
  if len(systemlist('git diff --cached --shortstat')) > 0
    echo 'Opening git commit ...'
    execute 'Gina commit -v'
  else
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
