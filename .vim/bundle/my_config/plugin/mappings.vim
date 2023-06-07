"n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
"i  Insert mode map. Defined using ':imap' or ':inoremap'.
"v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
"x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
"s  Select mode map. Defined using ':smap' or ':snoremap'.
"c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
"o  Operator pending mode map. Defined using ':omap' or ':onoremap'


noremap <SCRollWheelUp>     5<C-Y>
noremap <SCRollWheelDown>   5<C-E>

noremap <F2> :call ToggleHeaderSource()<CR>
noremap <S-F2> :call ToggleSourceTest()<CR>
noremap <F3> :NERDTreeToggle<CR>
noremap <S-F3> :NERDTreeFind<CR>
noremap <F4> :tab split<CR>
noremap <F5> :vimgrep <C-R>=expand('<cword>')<CR> <C-R>=fnamemodify(expand("%"), ":h")<CR>/**
"noremap <F6>
"noremap <F7>
noremap <F8> :vsplit<CR><C-]> " Open the definition in a vertical split
noremap <F9> :Rgrep <CR><Home>\(public\\|protected\\|private\)\s\+<CR>
noremap <F10> :q<CR>
noremap <S-F10> :on<CR>
noremap <F11> <ESC>g<C-]>zz
noremap <F12> <ESC><C-w>g<C-]>zz

noremap <Leader>s :Sscratch<CR>

" faster cursor movements between splits
noremap <A-Up> <C-W><Up>
noremap <A-Down> <C-W><Down>
noremap <A-Left> <C-W><Left>
noremap <A-Right> <C-W><Right>

" cursor movements between tabs
noremap <C-Right> gt
noremap <C-Left> gT

nnoremap _ :res -10<CR>
nnoremap + :res +10<CR>

xnoremap p pgvy
nnoremap <space> viw

" case sensitive search
"nnoremap * /\<<C-R><C-W>\>\C<CR>
noremap <kMultiply> /\<<C-R><C-W>\>\C<CR>
"nnoremap # ?\<<C-R><C-W>\>\C<CR>

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

" move current line up/down-wards
nnoremap <C-S-Up> :m -2<CR>
nnoremap <C-S-Down> :m +1<CR>

" next selected Mark
map <Leader>. <Leader>*

