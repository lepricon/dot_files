"n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
"i  Insert mode map. Defined using ':imap' or ':inoremap'.
"v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
"x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
"s  Select mode map. Defined using ':smap' or ':snoremap'.
"c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
"o  Operator pending mode map. Defined using ':omap' or ':onoremap'


map <C-F> :pyf /usr/share/vim/addons/syntax/clang-format-3.8.py<CR>
imap <C-F> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.8.py<CR>i

noremap <SCRollWheelUp>     7<C-Y>
noremap <SCRollWheelDown>   7<C-E>

noremap <F2> :call ToggleHeaderSource()<CR>
noremap <S-F2> :call ToggleSourceTest()<CR>
noremap <F3> :NERDTreeToggle<CR>
noremap <S-F3> :NERDTreeFind<CR>
noremap <F4> :tab split<CR>
noremap <F5> :Rgrep<CR>
noremap <F6> :TlistToggle<CR>
noremap <F7> :TagbarToggle<CR>
noremap <F8> :vsplit<CR><C-]> " Open the definition in a vertical split
noremap <F9> :Rgrep <CR><Home>\(public\\|protected\\|private\)\s\+<CR>
noremap <F10> :q<CR>
noremap <S-F10> :on<CR>
noremap <F11> <ESC>g<C-]>zz
noremap <F12> <ESC><C-w>g<C-]>zz

noremap <Leader>s :Sscratch<CR>
noremap <Leader>con :Gcppc \\\<<C-R>=expand('<cword>')<CR>\\\>
noremap <Leader>tu :Gcpptu \\\<<C-R>=expand('<cword>')<CR>\\\>
noremap <Leader>use  :Gcpp \\\<<C-R>=expand('<cword>')<CR>\\\>
noremap <Leader>d :Inherits <C-R>=expand('<cword>')<CR>

" faster cursor movements between splits
noremap <A-Up> <C-W><Up>
noremap <A-Down> <C-W><Down>
noremap <A-Left> <C-W><Left>
noremap <A-Right> <C-W><Right>

" cursor movements between tabs
noremap <C-Right> gt
noremap <C-Left> gT

" error lookup in QuickFix
noremap <C-Up> :copen<CR>?[Ee]rror[ :]<CR>
noremap <C-Down> :copen<CR>j/[Ee]rror[ :]<CR>

nnoremap _ :res -10<CR>
nnoremap + :res +10<CR>

xnoremap p pgvy
nnoremap <space> viw

" case sensitive search
nnoremap * /<C-R><C-W>\C<CR>
nnoremap # ?<C-R><C-W>\C<CR>

" relative path
nnoremap <Leader>ff :let @+ = expand("%")<CR>
" full path
nnoremap <Leader>fp :let @+ = expand("%:p")<CR>
" just filename
nnoremap <Leader>ft :let @+ = expand("%:t")<CR>

" For local variable name replace
nnoremap gr viwy[{V%:s/\<<C-R>"\>/<C-R>"/gc<left><left><left>
" For global variable name replace
nnoremap gR :%s/\<<C-R><C-W>\>/<C-R><C-W>/gc<left><left><left>

nnoremap <Leader>wm :w<CR> :make<CR>

" * w/o jump
"nnoremap <Leader>* :let @/ = '\<'.expand('<cword>').'\>'<CR>

" move selected line up/down-wards
nnoremap <C-J> ddp
nnoremap <C-K> ddkP

" next selected Mark
map <Leader>. <Leader>*

