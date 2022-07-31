" defx
" you need to use nerd-fonts on iterm for expressing folder icon correctly
" see https://github.com/ryanoasis/nerd-fonts#option-6-ad-hoc-curl-download
" and configure it

lua << EOF
  vim.call('defx#custom#option', '_', {
    winwidth = 30,
    split = 'vertical',
    direction = 'topleft',
    show_ignored_files = 1,
    buffer_name = 'exlorer',
    toggle = 1,
    resume = 1,
  })

  vim.g.defx_icons_enable_syntax_highlight = 1
  vim.g.defx_icons_column_length = 2
  vim.g.defx_icons_directory_icon = ''
  vim.g.defx_icons_mark_icon = '*'
  vim.g.defx_icons_parent_icon = ''
  vim.g.defx_icons_default_icon = ''
  vim.g.defx_icons_directory_symlink_icon = ''
  vim.g.defx_icons_root_opened_tree_icon = ''
  vim.g.defx_icons_nested_opened_tree_icon = ''
  vim.g.defx_icons_nested_closed_tree_icon = ''

  vim.cmd([[
    function! s:DefxMySettings() abort
      nnoremap <silent><buffer><expr> o defx#do_action('drop')
      nnoremap <silent><buffer><expr> c defx#do_action('copy')
      nnoremap <silent><buffer><expr> m defx#do_action('move')
      nnoremap <silent><buffer><expr> p defx#do_action('paste')
      nnoremap <silent><buffer><expr> d defx#do_action('remove')
      nnoremap <silent><buffer><expr> r defx#do_action('rename')
      nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer><expr> l defx#is_directory() ? defx#do_action('open') : 0
      nnoremap <silent><buffer><expr> yy  defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N defx#do_action('new_file')
      nnoremap <silent><buffer><expr> q defx#do_action('quit')
    endfunction
    command! -nargs=* DefxMySettings call s:DefxMySettings()
  ]])
EOF
