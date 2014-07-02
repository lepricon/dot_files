

" Vim syntax file
"
" Language:     svn 
" Maintainer:   Regg 
" Last Change:  10 August 2005
"
" This file is based on the ETSI standard ES201873-1 v2.2.1. Please let me know
" of any bugs or other problems you run across.


if exists("b:current_syntax")
  finish
endif

syn sync fromstart

syn match   svnAdded    "^+.*"
syn match   svnRem  "^-.*"
syn match   svnFile     "^+++.*("
syn match   svnFile     "^---.*("


" Link our groups to Vim's predefined groups
if version >= 508 || !exists("g:did_ttcn_syn_inits")

  if version < 508
    let g:did_ttcn_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink svnAdded Label
  HiLink svnRem Number 
  HiLink svnFile String

  delcommand HiLink

endif


let b:current_syntax = "svn"

