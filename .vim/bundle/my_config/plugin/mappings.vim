map <C-K> :pyf clang-format.py<CR>
imap <C-K> <ESC>:pyf clang-format.py<CR>i

noremap <SCRollWheelUp>     7<C-Y>
noremap <SCRollWheelDown>   7<C-E>

noremap <F2> :call ToggleHeaderSource()<CR>
noremap <F3> :NERDTreeToggle<CR> " requires vim >= 7.0
noremap <F4> :NERDTreeFind<CR>
noremap <F5> :Rgrep<CR>
noremap <F6> :TlistToggle<CR>
noremap <F7> :TagbarToggle<CR>
noremap <F8> :vsplit<CR><C-]> " Open the definition in a vertical split
noremap <F9> :Rgrep <CR><Home>\(public\\|protected\\|private\)\s\+<CR>
noremap <F10> <ESC>g<C-]>
noremap <F11> :q<CR>
noremap <F12> <ESC><C-w>g<C-]>

noremap <Leader>s :SsCRatch<CR>
noremap <Leader>con :Gcppc <C-R>=expand('<cword>')<CR>
noremap <Leader>tu :Gcpptu <C-R>=expand('<cword>')<CR>
noremap <Leader>use :Gcpp <C-R>=expand('<cword>')<CR>

" faster cursor movements between splits
noremap <A-Up> <C-W><Up>
noremap <A-Down> <C-W><Down>
noremap <A-Left> <C-W><Left>
noremap <A-Right> <C-W><Right>

" cursor movements between tabs
noremap <C-Right> gt
noremap <C-Left> gT

" faster movements in QuickFix
noremap <C-Up> :cp<CR>
noremap <C-Down> :cn<CR>

nnoremap = :res +10<CR>
nnoremap - :res -10<CR>
nnoremap _ :vertical res -10<CR>
nnoremap + :vertical res +10<CR>

xnoremap p pgvy
nnoremap <space> viw

" relative path
nnoremap <Leader>ff :let @+ = expand("%")<CR>
" full path
nnoremap <Leader>fp :let @+ = expand("%:p")<CR>
" just filename
nnoremap <Leader>ft :let @+ = expand("%:t")<CR>

" get derived class by searching tag by I-face name w/o leading "I"
noremap <Leader>d blveg<C-]>

