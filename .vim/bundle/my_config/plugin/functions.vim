"==========================================
"   functions
"==========================================

fun! GetTwoFistCatalogsOfCurrentPath()
    exe "cd ."
    let list = split(expand('%'),"/")
    return join(list[0:1], "/")
endfun

" function and a command to load build log from file
fun! LoadLog()
    cgetfile /tmp/mgmake-build-log
    copen
    set wrap
    exe "/error:\\|Error \d"
endf
command! -nargs=* LoadLog call LoadLog()

fun! LoadLogExe()
    cgetfile /tmp/mgmake-build-log-exe
    copen
    set wrap
    exe "/error:"
endf
command! -nargs=* LoadLogExe call LoadLogExe()

fun! LoadLogUt()
    cgetfile /tmp/mgmake-build-log-ut
    copen
    set wrap
    exe "/error:"
endf
command! -nargs=* LoadLogUt call LoadLogUt()

" to clean application log *.out from timestamps
fun! CleanTimestampsInLog()
    %s/\(.*\)\(<.*\d\d:\d\d:\d\d\.\d\{6}Z> \)\(\x\+\)/\2/g
endf
command! -nargs=* CleanTimestampsInLog call CleanTimestampsInLog()

function! ToggleHeaderSource()
  if match(expand("%"),'\.cpp') > 0
    let l:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
    let l:flipname = substitute(l:flipname,'\(.*\)Source','\1Include',"")
    exe ":e " . l:flipname
  elseif match(expand("%"),'\.hpp') > 0
    let l:flipname = substitute(expand("%"),'\.hpp\(.*\)','\.cpp\1',"")
    let l:flipname = substitute(l:flipname,'\(.*\)Include','\1Source',"")
    exe ":e " . l:flipname
  endif
endfun

function! ToggleSourceTest()
  if match(expand("%"),'Test_modules\/') > 0
    let l:flipname = substitute(expand("%"),'\(.*\)Test_modules','\1Source',"")
    let l:flipname = substitute(l:flipname,'TestSuite','',"")
    exe ":e " . l:flipname
  elseif match(expand("%"),'Source\/') > 0
    let l:flipname = substitute(expand("%"),'\(.*\)Source','\1Test_modules',"")
    let l:flipname = substitute(l:flipname,'\.cpp','TestSuite\.cpp',"")
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

function! Gcpp( word )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcpp " . l:searchPath . " \"" . a:word . "\" ' ) | copen"
endfunction
command! -nargs=1 -complete=file Gcpp call Gcpp( <f-args> )

function! Gcppc( word )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcppc " . l:searchPath . " \"" . a:word . "\" ' ) | copen"
endfunction
command! -nargs=1 -complete=file Gcppc call Gcppc( <f-args> )

function! Gcpptu( word )
    let l:searchPath = GetTwoFistCatalogsOfCurrentPath()
    exe "cgetexpr system( ' gcpptu " . l:searchPath . " \"" . a:word . "\" ' ) | copen"
endfunction
command! -nargs=1 -complete=tag Gcpptu call Gcpptu( <f-args> )

function! Inherits( word )
    let l:command = "grep \"^[_a-zA-Z][_a-zA-Z0-9]\\{0,30\\}::.*inherits[:_a-zA-Z]\\\+" . a:word . "$\" tags \\| while read LINE; do FILE=`echo $LINE \\| awk ''{print $2}''`; TAGLINE=`echo $LINE \\| sed ''s\\|.*/^\\(.*\\)$/.*\\|\\1\\|''`; grep -Hn \"$TAGLINE\" \"$FILE\"; done"
    exe "cgetexpr system( \' " . l:command . " \' ) | copen"
endfunction
command! -nargs=1 -complete=file Inherits call Inherits( <f-args> )

function! TabGmock()
    let l:filenameInclude = expand("%")
    let l:filenameMock1 = substitute(l:filenameInclude, "Include", "Test_modules/Mocks", "")
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

function! OpenInCurrentAndJumpToLine( ... )
    let l:name_line = split(a:1, ":")
    execute "edit " . name_line[0]
    execute name_line[1]
endfunction
command! -nargs=* -complete=command Ed call OpenInCurrentAndJumpToLine( <f-args> )

function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction

function! UniteGrep( ... )
    set modifiable
    exe '%!grep ' join(a:000, ' ')
    set nomodifiable
endfunction
command! -nargs=* -complete=command UniteGrep call UniteGrep( <f-args> )


