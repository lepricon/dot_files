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
augroup END

