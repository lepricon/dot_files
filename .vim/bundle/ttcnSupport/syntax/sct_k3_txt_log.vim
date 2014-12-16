" Language:     sct_k3_txt_log
"

if exists("b:current_syntax")
  finish
endif

" Literals
syn match   logSpecialMsg  "SACK.[A-Z]*_[A-Za-z]*"
syn match   logImportantMsg  "Waiting for"
syn match   logImportantMsg  "ANY PORT"
syn match   logImportantMsg  "Final Verdict"
syn keyword   logError  fail
syn match   logVerdictValue  "Start timer"
syn keyword   logString  Timeout
syn keyword   logImportantMsg  fail
syn keyword   logNotify  Expected
syn match   logNotify  "New verdict"
syn match   logSpecialMsg  "Message Queued"
syn match   logLog  "+++++++++++++REASON  BEGIN++++++++++"
syn match   logLog  "+++++++++++++REASON  END++++++++++"
syn match   logVerdictValue  "Function Enter"
syn match   logString  "Function Leave"
syn match   logString  "Match Successfull"
syn match   logError  "Match Failed"

syn keyword logDecl  Received Send
syn keyword logBool    true false
syn keyword logVerdictValue   omit null pass inconc none error
"syn region  logString  start=/"/ end=/"/ skip=/""/ oneline

if version < 508
command -nargs=+ HiLink hi link <args>
else
command -nargs=+ HiLink hi def link <args>
endif

HiLink logBool   Boolean
HiLink logVerdictValue  Constant
HiLink logSpecialMsg  Special
HiLink logDecl   Statement
HiLink logError  Error
HiLink logString String
HiLink logLog    PreProc
HiLink logImportantMsg   Error
HiLink logNotify   Type

delcommand HiLink


let b:current_syntax = "sct_k3_txt_log"

