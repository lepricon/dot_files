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
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>br :Unite buffer<cr>

" Unite gtags
nnoremap <leader>gd :execute 'Unite gtags/def:'.expand('<cword>')<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>gg :execute 'Unite gtags/grep'<CR>
nnoremap <Leader>gt :execute 'Unite -start-insert gtags/completion'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neocomplete

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_select = 1

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NeoSnippets
"
" Plugin key-mappings.
imap <C-K>     <Plug>(neosnippet_expand_or_jump)
smap <C-K>     <Plug>(neosnippet_expand_or_jump)
xmap <C-K>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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

