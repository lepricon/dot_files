" Vim syntax file
"
" Language:     regr 
" Maintainer:   Regg 
"


if exists("b:current_syntax")
  finish
endif

syn sync fromstart

syn match Error  "W .*"
syn match Comment "#.*"

let b:current_syntax = "regr"

