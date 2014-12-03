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
nnoremap <leader>o :<C-u>Unite -start-insert -auto-preview outline<cr>
nnoremap <leader>u :<C-u>Unite -start-insert file_mru<cr>
nnoremap <leader>t :Unite -start-insert  tag<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>b :Unite -quick-match buffer<cr>

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

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


