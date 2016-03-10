au FocusGained,BufEnter * :silent! checktime

fun! s:DetectK3rFile()
    if getline(1) =~ '^\d\{8}T\d\{6}\.\d\{6}\|'
        setf k3r
    endif
endfun

augroup filetypedetect
    au BufNewFile,BufRead *.ttcn3 setf ttcn
    au BufNewFile,BufRead *.k3.log setf k3p
    au BufNewFile,BufRead *.log call s:DetectK3rFile()
    au BufRead,BufNewFile *.k3.txt set filetype=sct_k3_txt_log
    au BufRead,BufNewFile *.LOG,*.out set filetype=out
    au BufRead,BufNewFile *.ttcn* set filetype=ttcn
    au BufRead,BufNewFile *ssionList.txt set filetype=regr
augroup END

" following line makes Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" trim trailing whitespaces on save
autocmd BufWritePre *.[chs]*,*.ttcn*,*.py :%s/\s\+$//e

" highlight and remove trailind whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/
autocmd InsertEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/

