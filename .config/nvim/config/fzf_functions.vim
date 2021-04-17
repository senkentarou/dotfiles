" 現在のウィンドウの半透明度を指定する。
set winblend=20
"
" ポップアップメニューの半透明度を指定する
set pumblend=30

" ref: https://kassioborges.dev/2019/04/10/neovim-fzf-with-a-floating-window.html
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS="--layout=reverse"
" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" disable preview window
let g:fzf_preview_window = ''

let g:fzf_buffers_jump = 1

" Function to create the custom floating window
function! FloatingFZF()
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  autocmd! BufWipeout <buffer> exe 'bw '.s:buf
endfunction
command! FZFFileList call fzf#run({'source': 'rg --files --hidden --glob "!.git/*"', 'window': 'call FloatingFZF()', 'sink': 'e'})

