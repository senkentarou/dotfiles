" defx
call defx#custom#option('_', {
  \ 'winwidth': 40,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': 'exlorer',
  \ 'toggle': 1,
  \ 'resume': 1,
  \ })

let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
let g:defx_icons_root_opened_tree_icon = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''

function! s:DefxMySettings() abort
  nnoremap <silent><buffer><expr> o
    \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> h
    \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> l
    \ defx#is_directory() ? defx#do_action('open') : 0
  nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
    \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> K
    \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
    \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
    \ defx#do_action('toggle_columns',
    \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <C-l>
    \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
    \ defx#do_action('print')
endfunction
command! -nargs=* DefxMySettings call s:DefxMySettings()

