if exists("did_load_filetypes")
    finish
endif

fun! s:DetectK3rFile()
    if getline(1) =~ '^\d\{8}T\d\{6}\.\d\{6}\|'
        " setfiletype k3r
        " set syntax=k3r
        setf k3r
    endif
endfun

augroup filetypedetect
    au BufNewFile,BufRead *.ttcn3 setf ttcn
    au BufNewFile,BufRead *.k3.log setf k3p
    au BufNewFile,BufRead *.log call s:DetectK3rFile()

    au BufRead,BufNewFile *.log,*.k3.txt set filetype=log
    au BufRead,BufNewFile *.LOG,*.out set filetype=out
    au BufRead,BufNewFile *.pu* set filetype=plantuml
    au BufRead,BufNewFile *.ttcn* set filetype=ttcn
    au BufRead,BufNewFile *ssionList.txt set filetype=regr
augroup END

au FocusGained,BufEnter * :silent! checktime

au BufWinLeave *.[chs]*,*.ttcn* mkview
au BufWinEnter *.[chs]*,*.ttcn* silent loadview

" trim trailing whitespaces on save
autocmd BufWritePre *.[chs]*,*.ttcn*,*.py :%s/\s\+$//e

" highlight and remove trailind whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/
autocmd InsertEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/
