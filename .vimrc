set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'jlanzarotta/bufexplorer'
Plugin 'jondkinney/dragvisuals.vim'
Plugin 'mark', {'pinned': 1}
Plugin 'my_config', {'pinned': 1}
" Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'aklt/plantuml-syntax'
Plugin 'vim-scripts/QFGrep.vim'
Plugin 'vim-scripts/Tagbar'
Plugin 'ttcnSupport', {'pinned': 1}
Plugin 'Shougo/unite.vim'
Plugin 'hewes/unite-gtags'
Plugin 'Shougo/unite-outline'
Plugin 'vim-scripts/vcscommand.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'markcornick/vim-bats'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-commentary'
Plugin 'skroll/vim-easycolour'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Shougo/vimproc.vim'
Plugin 'skroll/vim-taghighlight'
Plugin 'valloric/youcompleteme'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line





" turn filetype detection off and, even if it's not strictly
" necessary, disable loading of indent scripts and filetype plugins
filetype off
filetype plugin indent off

" pathogen runntime injection and help indexing
call pathogen#infect()
call pathogen#helptags()

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
 set mouse=a
 set ttymouse=xterm2
endif

set t_Co=256
set backspace=2
set number                  " show the line number for each line
set showcmd                 " display incomplete commands
set wildmode=longest,list,full
set wildmenu
set hlsearch
set incsearch
set cursorline
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
"set hidden                  "remember your changes in hidden buffers -> no need to save on close

set nowritebackup   "write a backup file before overwriting a file
set tags+=./tags
set matchpairs+=<:>
set makeprg=clang++\ -g\ -std=c++14\ -stdlib=libc++\ -lpthread
set wildignore=*.swp,*.bak,*.pyc,*.class,*.svn*,.git,*.tmp*,*.orig,*.rej
set indentkeys=0{,0},0#,!^F,o,O,e

syntax enable
syntax on

if has('gui_running')
    set background=light
    cnoremap <S-Insert> <C-R>*
    inoremap <S-Insert> <C-R>*
    nnoremap <S-Insert> "*p
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
"    set guifont=Monaco\ for\ Powerline\ 10

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
"    set linespace=1
    let g:mwDefaultHighlightingPalette='maximum'
else
    set background=dark
    let g:mwDefaultHighlightingPalette='extended'
endif

let mapleader = ","
let g:mapleader = ","
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

