-- Git grep by interactive input
vim.cmd([[
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
]])

-- Git grep on current word
vim.cmd([[
  function! s:GGrepCurrentWordQuery(cmd) abort
    let cword = expand('<cword>')
    execute a:cmd . ' ' . cword
  endfunction
  command! -nargs=* GinaGrepCurrentWordQuery call s:GGrepCurrentWordQuery('Gina grep')
]])

-- gitsigns
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]'
}

-- neogit
require('neogit').setup {
  integrations = {
    diffview = true
  }
}
