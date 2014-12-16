" Vim syntax file
"
" Language:     K3R logs highlighting
" Maintainer:   Lukasz Kucharski <lukasz.kucharski@nsn.com>
" Last Change:  03 December 2014
"

if exists("b:current_syntax")
  finish
endif


syn match k3pMesNotConsumed "/// Message NOT consumed" contained
syn match k3pMismatch "/// MISMATCH .*"

syn match k3pTimeElapsed "Time: \d\{1,2}:\d\{2}:\d\{2}\.\d\{6}" contained

syn match k3pTestCase "TestCase [^ ]* FinalVerdict: .*"
syn match k3pTcStart "Starting TestCase:.*"
syn match k3pTcStop "Finishing TestCase:.*"
syn match k3pFunEnter "Enter .*"
syn match k3pFunLeave "Leave .*" contains=k3pTimeElapsed

syn match k3pNotConsumed "There are not consumed messages on folliwing ports:"
syn match k3pMissing "Following ports are still waiting for messages:"
syn match k3pError "[ ]*Error:.*"
syn match k3pUnexpected "[ ]*Received unexpected.*"
syn match k3pVerdict "[ ]*New verdict:.*" contains=k3pVerdictFail
syn match k3pVerdictFail "fail" contained
syn match k3pTimeout "[ ]*Timeout for timer:.*"

syn match k3pFoundTc "[ ]*Found TestCase to run:"

syn match k3pSends "[ ]*K3 sends:.*" contains=k3pLocation
syn match k3pReceives "[ ]*K3 \(receives\|recives\):.*" contains=k3pMesNotConsumed,k3pLocation
syn match k3pWait "[ ]*K3 Waits:.*" contains=k3pLocation

syn match k3pAltSteps "Active altsteps for [^ ]* component:"

syn match k3pComponentName "[^ :]\+:" contained
syn match k3pPortName "[^ :]\+:" contained
syn match k3pMessageName "[^\. ]\+\.[^ ]\+" contained
syn match k3pComponent "[ ]*component .*" contains=k3pComponentName
syn match k3pPort "[ ]\{2,}port .*" contains=k3pPortName
syn match k3pMessage "[ ]\{4,}message .*" contains=k3pMessageName

syn match k3pLocation " @ .*" contained

syn match k3pTime "\d\{6}\.\d\{6}"

" Link our groups to Vim's predefined groups
hi def link k3pColon Normal

hi def link k3pNotConsumed Error
hi def link k3pMissing Error
hi def link k3pError Error
hi def link k3pUnexpected Error
hi def link k3pVerdict Statement
hi def link k3pVerdictFail Error
hi def link k3pTimeout Error
hi def link k3pMesNotConsumed Error
hi def link k3pMismatch Error

hi def link k3pReceives Identifier
hi def link k3pSends Statement
hi def link k3pWait Delimiter

hi def link k3pTimeElapsed StorageClass

hi def link k3pTestCase PreProc
hi def link k3pTcStart Comment
hi def link k3pFunEnter Comment
hi def link k3pFunLeave Number
hi def link k3pTcStop Number

hi def link k3pAltSteps Function

hi def link k3pComponent PreProc
hi def link k3pPort Tag
hi def link k3pMessage Typedef

hi def link k3pPortName Function
hi def link k3pComponentName Number
hi def link k3pMessageName String

hi def link k3pFoundTc Keyword

hi def link k3pTime Comment
hi def link k3pLocation Comment

" Normal
" Comment
" Constant
" String
" Character
" Number
" Boolean
" Float
" Identifier
" Function
" Statement
" Conditional
" Repeat
" Label
" Operator
" Keyword
" Exception
" PreProc
" Include
" Type
" StorageClass
" Structure
" Typedef
" Special
" SpecialChar
" Tag
" Delimiter
" SpecialComment
" Debug
" Underlined
" Title
" Ignore
" Error
" Todo
" htmlH2

let b:current_syntax = "k3p"

