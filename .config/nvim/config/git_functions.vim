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

lua << EOF
  require('gitsigns').setup {}
EOF

lua << EOF
  require('neogit').setup {
    integrations = {
      diffview = true
    }
  }
EOF
