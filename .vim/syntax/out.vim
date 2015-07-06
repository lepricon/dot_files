
" Vim syntax file
"
" Language:     outLog 
" Maintainer:   Regg 
" Last Change:  10 August 2005
"
" This file is based on the ETSI standard ES201873-1 v2.2.1. Please let me know
" of any bugs or other problems you run across.


if exists("b:current_syntax")
  finish
endif

if exists("g:ttcn_minlines")
  exec "syn sync minlines=" . g:ttcn_minlines
else
  syn sync fromstart
endif

" Literals
"syn match   logError  "[Ff]ail"
"syn match   logError  "[Ff]ailed"
"syn match   logError  "[Ee]rror"
"syn match   logError  "[Tt]imeout"

syn match   logInfo   "INF[\/,#][^ ]*"
syn match   logDebug   "DBG[\/,#][^ ]*"
syn match   logWarning   "WRN[\/,#][^ ]*"
syn match   logError   "ERR[\/,#][^ ]*"

syn match   logApplicationMessage "\([A-Z0-9]\+_\)\{2,\}[A-Z0-9]\+"
syn match   logMessage  "msgId\s*=\s*0x[a-f0-9]\{0,4}\W"
syn match   logMessage  "eventId\s*=\s*0x[a-f0-9]\{0,4}\W"
syn match   logMessage  "messageId\s*=\s*[a-f0-9]\{0,4}\W"



" Comments 
if version < 700 
  syn match   ttcnCmnt    "//.*" contains=ttcnTodo
  syn region  ttcnCmnt    start="/\*" end="\*/" contains=ttcnTodo
else
  syn match   ttcnCmnt    "//.*" contains=ttcnTodo,@Spell
  syn region  ttcnCmnt    start="/\*" end="\*/" contains=ttcnTodo,@Spell
endif

"syn case ignore
syn keyword ttcnTodo    xxx todo fixme contained
"syn case match


" Link our groups to Vim's predefined groups
if version >= 508 || !exists("g:did_ttcn_syn_inits")

  if version < 508
    let g:did_ttcn_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink logWarning Type
  HiLink logMessage Keyword
  HiLink logInfo    Statement
  HiLink logDebug   String
  HiLink logError   Special
  HiLink logApplicationMessage MoreMsg

  delcommand HiLink

endif


let b:current_syntax = "log"

