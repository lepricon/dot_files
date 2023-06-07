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
    normal zz
endf
command! -nargs=* LoadLog call LoadLog()

fun! LoadLogExe()
    cgetfile /tmp/mgmake-build-log-exe
    copen
    set wrap
    exe ":1"
    exe "/error:"
    normal zz
endf
command! -nargs=* LoadLogExe call LoadLogExe()

fun! LoadLogUt()
    cgetfile /tmp/mgmake-build-log-ut
    copen
    set wrap
    exe ":1"
    exe "/error:"
    normal zz
endf
command! -nargs=* LoadLogUt call LoadLogUt()

" to clean application log *.out from timestamps
fun! CleanTimestampsInLog()
    %s/\(.*\)\(<.*\d\d:\d\d:\d\d\.\d\{6}Z> \)\(\x\+\)/\2/g
endf
command! -nargs=* CleanTimestampsInLog call CleanTimestampsInLog()

function! PlantUML()
    let l:imageName = substitute(expand("%"),'\.pu.*','\.png',"")
    exe "silent !plantuml %"
    exe "silent !eog " . l:imageName . " &"
    redraw!
endfun
command! -nargs=* PlantUML call PlantUML()

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

