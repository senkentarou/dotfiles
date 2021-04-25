" Git grep on current word
function! s:gGrepCurrentWordQuery() abort
	let cword = expand('<cword>')
	execute 'Gina grep ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:gGrepCurrentWordQuery()

function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction
command!  -nargs=* ToggleGStatus call ToggleGStatus()

