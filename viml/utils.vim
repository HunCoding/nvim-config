function! SortLines() range
    execute a:firstline . ',' . a:lastline
                \   . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) .
    execute a:firstline . ',' . a:lastline . 'sort n'
    execute a:firstline . ',' . a:lastline . 's/^\d\+\s//'
    redraw!
endfunction
command! -range Sort <line1>,<line2>call SortLines()
function! Redir(cmd)
    if a:cmd =~ '^!'
        execute
    else
        redir => output
        execute a:cmd
        redir END
    endif
    vnew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output,
    put! = a:cmd
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)
function! GetVisualSelection()
    let [line_start, column_start] = getpos(
    let [line_end, column_end] = getpos(
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines,
endfunction
function! EscapeString (string)
    let string=a:string
    let string = escape(string, '^$.*\/~[]')
    let string = substitute(string, '\n', '\\n', 'g')
    return string
endfunction
