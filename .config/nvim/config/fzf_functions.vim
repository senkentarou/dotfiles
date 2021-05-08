" Window alphas
set winblend=20
set pumblend=30

" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS="--layout=reverse"
" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
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

command! SearchFiles call fzf#run(fzf#wrap({'source': 'rg --files --hidden --glob "!.git/*"', 'sink': 'e', 'options': ['--prompt', 'SearchFiles> ']}))

function! FZFGrep(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--prompt', 'SearchWords> ']}

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang SearchWords call FZFGrep(<q-args>, <bang>0)

function! s:delete_buffer(lines)
  let line_num_bracket = map(a:line, {_, l -> matchstr(split(l)[2], '\[\zs[0-9]*\ze\]')})
  execute 'bd' join(line_num_bracket)
endfunction

command! DeleteBuffers call fzf#run(fzf#wrap({
  \ 'source': map(fzf#vim#_buflisted_sorted(), 'fzf#vim#_format_buffer(v:val)'),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': ['-m', '-x', '--tiebreak=index', '--ansi', '-d', '\t', '--with-nth', '3..', '-n', '2,1..2', '--prompt', 'DeleteBuffers> ', '--reverse', '--bind', 'ctrl-a:select-all+accept']
  \ }))

