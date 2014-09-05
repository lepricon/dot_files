" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
 set mouse=a
 set ttymouse=xterm2
endif

set t_Co=256
set background=dark " Change to light if you want the light variant
set backspace=2
set number                  " show the line number for each line
set showcmd                 " display incomplete commands
set wildmode=longest,list,full
set wildmenu
set hlsearch
set incsearch
set cursorline
set nocompatible
set ignorecase
set smartcase
set noequalalways
set nowrap
set colorcolumn=120

set tabstop=4               "number of spaces a <Tab> in the text stands for
set shiftwidth=4            "number of spaces used for each step of (auto)indent
set softtabstop=4           " Sets the number of columns for a TAB
set expandtab               "expand <Tab> to spaces in Insert mode
set autoindent              "automatically set the indent of a new line
set smartindent             "do clever autoindenting

set nowritebackup   "write a backup file before overwriting a file
set tags=tags
set matchpairs+=<:>
set makeprg=make\ -f\ Makefile

syntax enable
syntax on
"highlight Pmenu ctermfg=black

filetype plugin indent on
call pathogen#infect()

"syn keyword myTodo contained todo
"syn match myComment "//.*$" contains=myTodo
"hi def link myTodo Todo

let mapleader = ","
let g:load_doxygen_syntax=1
let g:solarized_termcolors=256
colorscheme solarized "solarized bandit  colorful256   gardener  desert256  default_modified    Change to your preferred colour scheme

if &term =~ "xterm"
    :silent !echo -ne "\033]12;RoyalBlue1\007"
    let &t_SI = "\033]12;SpringGreen4\007"
    let &t_EI = "\033]12;RoyalBlue1\007"
    "autocmd VimLeave * :!echo -ne "\033]12;green\007"
endif

map <C-K> :pyf clang-format.py<CR>
imap <C-K> <ESC>:pyf clang-format.py<CR>i

noremap <ScrollWheelUp>     7<C-Y>
noremap <ScrollWheelDown>   7<C-E>

noremap <F2> :call ToggleHeaderSource()<CR>
noremap <F3> :NERDTreeToggle<CR> " requires vim >= 7.0
noremap <F4> :NERDTreeFind<CR>
noremap <F5> :Rgrep<CR>
noremap <F6> :TlistToggle<CR>
noremap <F7> :TagbarToggle<CR>
noremap <F8> :vsplit<CR><C-]> " Open the definition in a vertical split
noremap <F9> blve<C-]>
noremap <F10> <ESC>g<C-]>
noremap <F12> <ESC><C-w>g<C-]>

noremap <space> <C-W>_  " fullscreen current buffer
noremap = :res +10<cr>
noremap - :res -10<cr>
noremap _ :vertical res -10<cr>
noremap + :vertical res +10<cr>
xnoremap p pgvy " yank once and paste multiple times then

au BufRead,BufNewFile *.log,*.k3.txt set filetype=log
au BufRead,BufNewFile *.LOG,*.out set filetype=out
au BufRead,BufNewFile *.puml set filetype=plantuml
au BufRead,BufNewFile *.ttcn* set filetype=ttcn

au BufWinLeave *.[chs]*,*.ttcn* mkview
au BufWinEnter *.[chs]*,*.ttcn* silent loadview

" trim trailing whitespaces on save
autocmd BufWritePre *.[chs]*,*.ttcn*,*.py :%s/\s\+$//e

" highlight and remove trailind whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/
autocmd InsertEnter *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.[chs]*,*.ttcn*,*.py match ExtraWhitespace /\s\+$/

" function and a command to load build log from file
fun! LoadLog( arg ) "{{{
    cfile /tmp/mgmake-build-log
    copen
    set wrap
endf "}}}
command! -nargs=* LoadLog call LoadLog( '<args>' )

" to clean application log *.out from timestamps
fun! CleanTimestampsInLog( arg ) "{{{
    %s/\(.*\)\(<.*\d\d:\d\d:\d\d.*> \)\([a-zA-Z0-9]\+\)/\2/g
endf "}}}
command! -nargs=* CleanTimestampsInLog call CleanTimestampsInLog( '<args>' )

" Mark Default ..
let g:mwDefaultHighlightingPalette='extended'

let Tlist_Use_Right_Window=1
let Tlist_WinWidth=50
let Tlist_File_Fold_Auto_Close=1

let Grep_Default_Filelist = '*.[ch]*'

function! ToggleHeaderSource()
  if match(expand("%"),'\.cpp') > 0
    let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
    let s:flipname = substitute(s:flipname,'Source','Include',"")
    exe ":e " . s:flipname
  elseif match(expand("%"),'\.hpp') > 0
    let s:flipname = substitute(expand("%"),'\.hpp\(.*\)','\.cpp\1',"")
    let s:flipname = substitute(s:flipname,'Include','Source',"")
    exe ":e " . s:flipname
  endif
endfun


" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=%= " right align
set statusline+=%2*0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

