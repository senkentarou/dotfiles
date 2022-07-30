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
command! -nargs=* GinaGrepInteractiveInput call s:GGrepInteractiveInput('Gina grep', <q-args>)

" Git grep on current word
function! s:GGrepCurrentWordQuery(cmd) abort
  let cword = expand('<cword>')
  execute a:cmd . ' ' . cword
endfunction
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
