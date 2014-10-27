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
else
    set background=dark
endif

let mapleader = ","
let g:load_doxygen_syntax=1
"let g:solarized_termcolors=256
colorscheme solarized "bandit  colorful256   gardener  desert256  default_modified

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
noremap <F9> :Rgrep <CR><Home>\(public\\|protected\\|private\)\s\+<CR>
noremap <F10> <ESC>g<C-]>
noremap <F11> :q<CR>
noremap <F12> <ESC><C-w>g<C-]>

noremap <Leader>s :Sscratch<CR>
noremap <Leader>con :Gcppc <C-R>=expand('<cword>')<CR>
noremap <Leader>tu :Gcpptu <C-R>=expand('<cword>')<CR>
noremap <Leader>use :Gcpp <C-R>=expand('<cword>')<CR>

" faster cursor movements between splits
noremap <A-Up> <C-W><Up>
noremap <A-Down> <C-W><Down>
noremap <A-Left> <C-W><Left>
noremap <A-Right> <C-W><Right>

noremap <space> <C-W>_  " fullscreen current buffer
noremap = :res +10<cr>
noremap - :res -10<cr>
noremap _ :vertical res -10<cr>
noremap + :vertical res +10<cr>
xnoremap p pgvy " yank once and paste multiple times then

au FocusGained,BufEnter * :silent! checktime

au BufRead,BufNewFile *.log,*.k3.txt set filetype=log
au BufRead,BufNewFile *.LOG,*.out set filetype=out
au BufRead,BufNewFile *.pu* set filetype=plantuml
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

"==========================================
"   functions
"==========================================

fun! GetTwoFistCatalogsOfCurrentPath()
    let list = split(expand('%'),"/")
    return join(list[0:1], "/")
endfun

" function and a command to load build log from file
fun! LoadLog()
    cfile /tmp/mgmake-build-log
    copen
    set wrap
endf
command! -nargs=* LoadLog call LoadLog()

" to clean application log *.out from timestamps
fun! CleanTimestampsInLog()
    %s/\(.*\)\(<.*\d\d:\d\d:\d\d.*> \)\([a-zA-Z0-9]\+\)/\2/g
endf
command! -nargs=* CleanTimestampsInLog call CleanTimestampsInLog()

function! ToggleHeaderSource()
  if match(expand("%"),'\.cpp') > 0
    let l:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
    let l:flipname = substitute(l:flipname,'Source','Include',"")
    exe ":e " . l:flipname
  elseif match(expand("%"),'\.hpp') > 0
    let l:flipname = substitute(expand("%"),'\.hpp\(.*\)','\.cpp\1',"")
    let l:flipname = substitute(l:flipname,'Include','Source',"")
    exe ":e " . l:flipname
  endif
endfun

function! PlantUML()
    let l:imageName = substitute(expand("%"),'\.pu.*','\.png',"")
    exe "silent !plantuml %"
    exe "silent !eog " . l:imageName . " &"
    redraw!
endfun
command! -nargs=* PlantUML call PlantUML()

function! Gcpp( ... )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcpp " . l:searchPath . " " . a:1 . " ' ) | copen"
endfunction
command! -nargs=* -complete=file Gcpp call Gcpp( <f-args> )

function! Gcppc( ... )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcppc " . l:searchPath . " " . a:1 . " ' ) | copen"
endfunction
command! -nargs=* -complete=file Gcppc call Gcppc( <f-args> )

function! Gcpptu( ... )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcpptu " . l:searchPath . " " . a:1 . " ' ) | copen"
endfunction
command! -nargs=* -complete=file Gcpptu call Gcpptu( <f-args> )

"==========================================
"    plugins
"==========================================

" Unite
let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_default_opts = '-RHn'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" ignore certain files and directories while searching
call unite#custom_source('file,file_rec,file_rec/async,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'build/',
      \ 'logs/',
      \ 'lteTools/',
      \ 'T_Tools/',
      \ ], '\|'))
nnoremap <C-p> :<C-u>UniteWithInputDirectory -start-insert file_rec/async:!<CR>/home/vvolkov/cplane/git/trunk/C_Application<CR>
nnoremap <leader>/ :Unite grep:C_Application<cr>
nnoremap <leader>o :<C-u>Unite -start-insert -auto-preview outline<cr>
nnoremap <leader>u :<C-u>Unite -start-insert file_mru<cr>
nnoremap <leader>t :Unite -start-insert  tag<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>b :Unite -quick-match buffer<cr>

" Neocomplete
let g:neocomplete#enable_at_startup = 1

" Mark Default ..
let g:mwDefaultHighlightingPalette='extended'

" grep
let Grep_Skip_Files='*.bak, *.svn*, *.tmp*, *.swp, *.swo, *.rej, *.orig, *.swm'
let Grep_Skip_Dirs = '.svn lteDo'
let Grep_Default_Filelist = '*.h *.hpp *.c *.cpp *.hxx *.cxx'

let Tlist_Use_Right_Window=1
let Tlist_WinWidth=50
let Tlist_File_Fold_Auto_Close=1

" Airline statusbar
set laststatus=2
let g:airline_powerline_fonts=1

