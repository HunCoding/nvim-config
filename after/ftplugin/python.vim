setlocal textwidth=120
setlocal foldmethod=indent
setlocal foldnestmax=1
setlocal colorcolumn=120
nnoremap <silent><buffer> <Leader>t :AsyncRun -save=1 -mode=term -pos=external python
nnoremap <silent><buffer> <Leader>r :AsyncRun -save=1 python
