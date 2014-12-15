" Vim syntax file
"
" Language:     k3post logs highlighting
" Maintainer:   Lukasz Kucharski <lukasz.kucharski@nsn.com>
" Last Change:  04 December 2014
"

if exists("b:current_syntax")
  finish
endif

" Built-in types
syn keyword k3rImportant ptqu ptsd tcfi setv contained
syn keyword k3rLessImportant ptrx cofi codo alwt contained
syn keyword k3rFailStatus fail error contained

syn match k3rGreedy ".*"

syn match k3rConsume "+consume" contained
syn match k3rTimestamp "\(timestamp=\|sender=\)" contained
syn match k3rAny "(any)" contained


syn match k3rMismatchComma "," nextgroup=k3rMismatchValue
syn match k3rMismatchExp "[^,)]*" nextgroup=k3rMismatchComma
syn match k3rMismatchTilde "\~" nextgroup=k3rMismatchExp
syn match k3rMismatchGot "[^~]*" nextgroup=k3rMismatchTilde
syn match k3rMismatchValue "[^:]*" nextgroup=k3rMismatchGot
syn match k3rMismatch "mismatch=value" nextgroup=k3rMismatchValue contained

syn match k3rSeven "[^|]*" nextgroup=k3rGreedy

syn match k3rBreak6 "|" nextgroup=k3rSeven
syn match k3rSix "[^|]*" nextgroup=k3rBreak6 contains=k3rTimestamp,k3rConsume,k3rMismatch

syn match k3rBreak5 "|" nextgroup=k3rSix
syn match k3rFive "[^|]*" nextgroup=k3rBreak5 contains=k3rTimestamp,k3rFailStatus

syn match k3rBreak4 "|" nextgroup=k3rFive
syn match k3rFour "[^|]*" nextgroup=k3rBreak4 contains=k3rAny,k3rFailStatus

syn match k3rBreak3 "|" nextgroup=k3rFour

syn match k3rLocationLine ":\d\+" nextgroup=k3rBreak3
syn match k3rLocation "[^:|]\+" nextgroup=k3rLocationLine,k3rBreak3
syn match k3rAssing2 "=" nextgroup=k3rLocation
syn match k3rComponent "[^=|]\+" nextgroup=k3rBreak3,k3rAssing2

syn match k3rBreak2 "|" nextgroup=k3rComponent
syn match k3rMnemonic "[a-z0-9]\{4}" nextgroup=k3rBreak2 contains=k3rImportant,k3rLessImportant

syn match k3rErrorAny "[^|]*" nextgroup=k3rBreak2
syn match k3rErrorFileLine ":\d\+" nextgroup=k3rErrorAny
syn match k3rErrorFile "[^:]\+" nextgroup=k3rErrorFileLine
syn match k3rAssign "=" nextgroup=k3rErrorFile
syn match k3rError "[A-Z]\{4}" nextgroup=k3rAssign

" 20141112T093859.107954
syn match k3rBreak1 "|" nextgroup=k3rMnemonic,k3rError
syn match k3rTime "\d\{8}T\d\{6}\.\d\{6}" nextgroup=k3rBreak1



" Link our groups to Vim's predefined groups
hi def link k3rImportant Identifier
hi def link k3rLessImportant Type
hi def link k3rFailStatus Error
hi def link k3rTime Normal
hi def link k3rBreak1 Ignore
hi def link k3rBreak2 Ignore
hi def link k3rBreak3 Ignore
hi def link k3rBreak4 Ignore
hi def link k3rBreak5 Ignore
hi def link k3rBreak6 Ignore
hi def link k3rMnemonic PreProc
hi def link k3rError Error
hi def link k3rErrorFile Special
hi def link k3rErrorAny Special
hi def link k3rComponent String
hi def link k3rLocation Type
hi def link k3rLocationLine Number
hi def link k3rErrorFileLine Number
hi def link k3rTimestamp Float
hi def link k3rConsume Operator
hi def link k3rAny Todo


hi def link k3rMismatchComma Ignore
hi def link k3rMismatchExp String
hi def link k3rMismatchTilde Ignore
hi def link k3rMismatchGot Statement
hi def link k3rMismatchValue Comment
hi def link k3rMismatch Error

hi def link k3rFour Comment
hi def link k3rFive Conditional
hi def link k3rSix StorageClass
hi def link k3rSeven Constant



hi def link k3rAssign Normal
hi def link k3rAssing2 Normal

hi k3rGreedy guifg=Khaki guibg=NONE gui=none ctermfg=yellow ctermbg=NONE cterm=BOLD

set synmaxcol=20000

let b:current_syntax = "k3p"

