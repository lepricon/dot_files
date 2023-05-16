"==========================================
"    plugins
"==========================================

" Unite
let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_default_opts = '-RHn'

" CtrlP search
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
" replacing unite with ctrl-p
nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>
nnoremap <leader>o :<C-u>Unite -start-insert -auto-preview outline<cr>
nnoremap <leader>u :<C-u>Unite -start-insert file_mru<cr>
nnoremap <leader>br :Unite buffer<cr>

" Unite gtags
nnoremap <leader>gd :execute 'Unite gtags/def'<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>gg :execute 'Unite gtags/grep'<CR>
nnoremap <Leader>gt :execute 'Unite -start-insert gtags/completion'<CR>

let g:unite_source_gtags_project_config = { '_': { 'treelize': 1 } }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
let g:ycm_enable_semantic_highlighting=1
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grep
let Grep_Skip_Files='*.bak, *.svn*, *.tmp*, *.swp, *.swo, *.rej, *.orig, *.swm'
let Grep_Skip_Dirs = '.svn lteDo'
let Grep_Default_Filelist = '*.h *.hpp *.c *.cpp *.hxx *.cxx *.asn *.py'

let Tlist_Use_Right_Window=1
let Tlist_WinWidth=50
let Tlist_File_Fold_Auto_Close=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline statusbar
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_extensions=["quickfix","unite","netrw","branch","po"]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Marks
let g:mwIgnoreCase = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DragVisuals
vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')
