setlocal spell
setlocal linebreak
setlocal wrap
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal noexpandtab
setlocal foldmethod=manual
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=v:lua.require('pretty-fold').foldtext.global()
function! AutoItem()
    let [end_lnum, end_col] = searchpairpos('\\begin{', '', '\\end{', 'nW')
    if match(getline(end_lnum), '\(itemize\|enumerate\|description\)') != -1
        return '\item '
    elseif match(getline(end_lnum), '\(tasks\)') != -1
        return '\task '
    else
        return ''
    endif
endfunction
function! GetLine()
    let list = ['\\task $', '\\item $']
    return getline('.') =~ list[0] || getline('.') =~ list[1]
endfunction
function! MiscFixes()
    let l:save = winsaveview()
    keeppatterns %s/\(input\|include\)\({.\+\)\\\(.\+}\)/\1\2\/\3/ge
    keeppatterns %s/\\item$/\\item /e
    keeppatterns %s/\\task$/\\task /e
    keeppatterns %s/^\s*\\item\s*\\item/\\item/e
    keeppatterns %s/\\item\\/\\item \\/e
    keeppatterns %s/^\s\+%\\label{fig:main_label}%\n//e
    call winrestview(l:save)
endfunction
function! CleanAuxFiles(...) abort
let l:cur_tex_path = fnamemodify(b:vimtex.tex, ':p:h')
python3 << EOF
import vim
import os
cur_tex_path = vim.eval(
for folder, _, files in os.walk(cur_tex_path):
    for file in files:
        if file.endswith(
            (
            )
        ):
            os.remove(os.path.join(folder, file))
EOF
echo 'Auxiliary files cleaned!'
endfunction
augroup TEX_AUTOCOMMANDS
    autocmd!
    autocmd BufWritePre *.tex :call MiscFixes()
    autocmd User VimtexEventQuit :silent! VimtexStopAll
    autocmd User VimtexEventQuit :silent! call CleanAuxFiles()
augroup END
nnoremap <silent><buffer> <Leader>lc :call CleanAuxFiles()<CR>
inoremap <buffer><expr> <CR> GetLine()
            \ ? '<C-w><C-w>'
            \ : (col('.') < col('$') ? '<CR>' : '<CR>' . AutoItem())
nnoremap <buffer><expr> o 'o' . AutoItem()
nnoremap <buffer><expr> O 'O' . AutoItem()
imap <buffer> <kEnter> <C-o>o
nnoremap <buffer> <Insert> i<CR>\item <Esc>
nnoremap <buffer> <Delete> gJi<C-o>dW<C-o>dW <Esc>
nmap <buffer> <M-B> <Plug>Ysurroundiw}i\textbi<Esc>
xmap <buffer> <M-B> <Plug>VSurround}i\textbi<Esc>
nmap <buffer> <M-b> <Plug>Ysurroundiw}i\textbf<Esc>
xmap <buffer> <M-b> <Plug>VSurround}i\textbf<Esc>
nmap <buffer> <M-f> <Plug>Ysurroundiw}i\ul<Esc>
xmap <buffer> <M-f> <Plug>VSurround}i\ul<Esc>
nmap <buffer> <M-F> <Plug>Ysurroundiw}i\underline<Esc>
xmap <buffer> <M-F> <Plug>VSurround}i\underline<Esc>
nmap <buffer> <M-v> <Plug>Ysurroundiw}i\ch<Esc>
xmap <buffer> <M-v> <Plug>VSurround}i\ch<Esc>
nmap <buffer> <M-m> <Plug>Ysurroundiw$
xmap <buffer> <M-m> <Plug>VSurround$
vnoremap <buffer> np :norm A.<CR>
vnoremap <buffer> nc :norm A,<CR>
nmap <buffer> <C-t> gui}gzi}
