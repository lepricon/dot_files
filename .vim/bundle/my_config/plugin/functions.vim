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

function! TabGmock()
    let l:filenameInclude = expand("%")
    let l:filenameMock1 = substitute(l:filenameInclude, "Include", "Test_modules", "")
    let l:filenameMock2 = substitute(l:filenameMock1, "\.hpp", "Mock\.hpp", "")
    exe "tabnew " . l:filenameMock2
    silent  execute ".! ~/workspace/googlemock-scripts/generator/gmock_gen.py " . l:filenameInclude
endfunction
command! -nargs=* -complete=command TabGmock call TabGmock()

function! OpenInSplitAndJumpToLine( ... )
    let l:name_line = split(a:1, ":")
    execute "split " . name_line[0]
    execute name_line[1]
endfunction
command! -nargs=* -complete=command Sp call OpenInSplitAndJumpToLine( <f-args> )

