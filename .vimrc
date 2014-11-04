" turn filetype detection off and, even if it's not strictly
" necessary, disable loading of indent scripts and filetype plugins
filetype off
filetype plugin indent off

" pathogen runntime injection and help indexing
call pathogen#infect()
call pathogen#helptags()

" turn filetype detection, indent scripts and filetype plugins on
" and syntax highlighting too
filetype plugin indent on

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
 set mouse=a
 set ttymouse=xterm2
endif

set t_Co=256
"set background=dark
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
set wildignore=*.swp,*.bak,*.pyc,*.class,*.svn*,.git,*.tmp*,*.orig,*.rej

syntax enable
syntax on

if has('gui_running')
    set background=light
    cnoremap <S-Insert> <C-R>*
    inoremap <S-Insert> <C-R>*
    nnoremap <S-Insert> "*p
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set linespace=1
else
    set background=dark
endif

let mapleader = ","
let g:load_doxygen_syntax=1
"let g:solarized_termcolors=256
colorscheme solarized "bandit  colorful256   gardener  desert256  default_modified

" set different cursor color in different modes
if &term =~ "xterm\\|rxvt"
    " use green cursor in insert mode
    let &t_SI = "\033]12;SpringGreen4\007"
    " use blue cursor in normal mode
    let &t_EI =      "\033]12;RoyalBlue1\007"
    silent !echo -ne "\033]12;RoyalBlue1\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\003]12;Gray\007"
endif

