" Git grep on current word
function! s:gGrepCurrentWordQuery() abort
	let cword = expand('<cword>')
	execute 'Gina grep ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:gGrepCurrentWordQuery()

" Open git blame file on web browser
function! s:openCurrentBlameFile() abort
  let current_absolute_path = expand('%:p')

  if current_absolute_path =~ '^fugitive:.\+$'
    let current_filehash = expand('%:t')

    " get git remote path (origin or upstream)
    let git_remote_path = substitute(system("git remote -v | grep $(git remote | tail -1) | awk '{print $2}' | uniq | cut -d '/' -f 4,5 | sed 's/.git//g'"), '\n', '', 'g')
    let joined_path = join([git_remote_path, 'commit', current_filehash], '/')
    let open_url = 'https://github.com/' . joined_path

    if exists('g:loaded_openbrowser') && g:loaded_openbrowser
      " open browser directly
      execute 'OpenBrowser ' . open_url
    else
      " show only open_url
      echo open_url
    endif
  else
    echo 'Error: Only use in GBlame buffer of fugitive.'
  endif
endfunction
command! -nargs=* OpenCurrentBlameFile call s:openCurrentBlameFile()

