function! AutoSaveWinView()
    if !exists(
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr(
endfunction
function! AutoRestoreWinView()
    let buf = bufnr(
    if exists(
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction
augroup RESTORE_WIN_VIEW
    autocmd!
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
augroup END
