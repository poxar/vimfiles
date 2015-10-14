" Initialization {{{

if exists('b:loaded_mylatexfolding')
    finish
endif
let b:loaded_mylatexfolding=1

" }}}
" Set options {{{

setlocal foldmethod=expr
setlocal foldexpr=LatexBox_FoldLevel(v:lnum)
setlocal foldtext=LatexBox_FoldText()

if !exists('g:LatexBox_fold_preamble')
    let g:LatexBox_fold_preamble=1
endif

if !exists('g:LatexBox_fold_parts')
    let g:LatexBox_fold_parts=[
                \ 'appendix',
                \ 'frontmatter',
                \ 'mainmatter',
                \ 'backmatter'
                \ ]
endif

if !exists('g:LatexBox_fold_sections')
    let g:LatexBox_fold_sections=[
                \ 'part',
                \ 'chapter',
                \ 'section',
                \ 'subsection',
                \ 'subsubsection'
                \ ]
endif

if !exists('g:LatexBox_fold_envs')
    let g:LatexBox_fold_envs=1
endif
if !exists('g:LatexBox_folded_environments')
    let g:LatexBox_folded_environments = [
                \ 'abstract',
                \ 'frame'
                \ ]
endif

" }}}
" LatexBox_FoldLevel helper functions {{{

" This function parses the tex file to find the sections that are to be folded
" and their levels, and then predefines the patterns for optimized folding.
function! s:FoldSectionLevels()
    " Initialize
    let l:level = 1
    let l:foldsections = []

    " If we use two or more of the *matter commands, we need one more foldlevel
    let l:nparts = 0
    for l:part in g:LatexBox_fold_parts
        let l:i = 1
        while l:i < line('$')
            if getline(l:i) =~ '^\s*\\' . l:part . '\>'
                let l:nparts += 1
                break
            endif
            let l:i += 1
        endwhile
        if l:nparts > 1
            let l:level = 2
            break
        endif
    endfor

    " Combine sections and levels, but ignore unused section commands:  If we
    " don't use the part command, then chapter should have the highest
    " level.  If we don't use the chapter command, then section should be the
    " highest level.  And so on.
    let l:ignore = 1
    for l:part in g:LatexBox_fold_sections
        " For each part, check if it is used in the file.  We start adding the
        " part patterns to the fold sections array whenever we find one.
        let l:partpattern = '^\s*\(\\\|% Fake\)' . l:part . '\>'
        if l:ignore
            let l:i = 1
            while l:i < line('$')
                if getline(l:i) =~# l:partpattern
                    call insert(l:foldsections, [l:partpattern, l:level])
                    let l:level += 1
                    let l:ignore = 0
                    break
                endif
                let l:i += 1
            endwhile
        else
            call insert(l:foldsections, [l:partpattern, l:level])
            let l:level += 1
        endif
    endfor

    return l:foldsections
endfunction

" }}}
" LatexBox_FoldLevel {{{

" Parse file to dynamically set the sectioning fold levels
let b:LatexBox_FoldSections = s:FoldSectionLevels()

" Optimize by predefine common patterns
let s:foldparts = '^\s*\\\%(' . join(g:LatexBox_fold_parts, '\|') . '\)'
let s:folded = '\(% Fake\|\\\(document\|begin\|end\|'
            \ . 'front\|main\|back\|app\|sub\|section\|chapter\|part\)\)'

" Fold certain selected environments
let s:notbslash = '\%(\\\@<!\%(\\\\\)*\)\@<='
let s:notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'
let s:envbeginpattern = s:notcomment . s:notbslash .
            \ '\\begin\s*{\('. join(g:LatexBox_folded_environments, '\|') .'\)}'
let s:envendpattern = s:notcomment . s:notbslash .
            \ '\\end\s*{\('. join(g:LatexBox_folded_environments, '\|') . '\)}'

function! g:LatexBox_FoldLevel(lnum)
    " Check for normal lines first (optimization)
    let l:line  = getline(a:lnum)
    if l:line !~ s:folded
        return '='
    endif

    " Fold preamble
    if g:LatexBox_fold_preamble == 1
        if l:line =~# '\s*\\documentclass'
            return '>1'
        elseif l:line =~# '^\s*\\begin\s*{\s*document\s*}'
            return '0'
        endif
    endif

    " Fold parts (\frontmatter, \mainmatter, \backmatter, and \appendix)
    if l:line =~# s:foldparts
        return '>1'
    endif

    " Fold chapters and sections
    for [l:part, l:level] in b:LatexBox_FoldSections
        if l:line =~# l:part
            return '>' . l:level
        endif
    endfor

    " Fold environments
    if g:LatexBox_fold_envs == 1
        if l:line =~# s:envbeginpattern
            return 'a1'
        elseif l:line =~# '^\s*\\end{document}'
            " Never fold \end{document}
            return 0
        elseif l:line =~# s:envendpattern
            return 's1'
        endif
    endif

    " Return foldlevel of previous line
    return '='
endfunction

" }}}
" LatexBox_FoldText helper functions {{{

function! s:CaptionFrame(line)
    " Test simple variants first
    let l:caption1 = matchstr(a:line,'\\begin\*\?{.*}{\zs.\+\ze}')
    let l:caption2 = matchstr(a:line,'\\begin\*\?{.*}{\zs.\+')

    if len(l:caption1) > 0
        return l:caption1
    elseif len(l:caption2) > 0
        return l:caption2
    else
        let l:i = v:foldstart
        while l:i <= v:foldend
            if getline(l:i) =~? '^\s*\\frametitle'
                return matchstr(getline(l:i),
                            \ '^\s*\\frametitle\(\[.*\]\)\?{\zs.\+')
            end
            let l:i += 1
        endwhile

        return ''
    endif
endfunction

" }}}
" LatexBox_FoldText {{{

function! g:LatexBox_FoldText()
    " Initialize
    let l:line = getline(v:foldstart)
    let l:nlines = v:foldend - v:foldstart + 1
    let l:level = ''
    let l:title = 'Not defined'

    " Fold level and number of lines
    let l:level = '+-' . repeat('-', v:foldlevel-1) . ' '
    let l:alignlnr = repeat(' ', 6-(v:foldlevel-1)-len(l:nlines))
    let l:lineinfo = l:nlines . ' lines: '

    " Preamble
    if l:line =~? '\s*\\documentclass'
        let l:title = 'Preamble'
    endif

    " Parts, sections and fakesections
    let l:sections = '\(\(sub\)*section\|part\|chapter\)'
    let l:secpat1 = '^\s*\\' . l:sections . '\*\?\s*{'
    let l:secpat2 = '^\s*\\' . l:sections . '\*\?\s*\['
    if l:line =~? '\\frontmatter'
        let l:title = 'Frontmatter'
    elseif l:line =~? '\\mainmatter'
        let l:title = 'Mainmatter'
    elseif l:line =~? '\\backmatter'
        let l:title = 'Backmatter'
    elseif l:line =~? '\\appendix'
        let l:title = 'Appendix'
    elseif l:line =~? l:secpat1 . '.*}'
        let l:title =  l:line
    elseif l:line =~? l:secpat1
        let l:title = l:line
    elseif l:line =~? l:secpat2 . '.*\]'
        let l:title = l:line
    elseif l:line =~? l:secpat2
        let l:title = l:line
    elseif l:line =~? 'Fake' . l:sections . ':'
        let l:title =  matchstr(l:line,'Fake' . l:sections . ':\s*\zs.*')
    elseif l:line =~? 'Fake' . l:sections
        let l:title =  matchstr(l:line, 'Fake' . l:sections)
    endif

    " Environments
    if l:line =~? '\\begin'
        " Capture environment name
        let l:env = matchstr(l:line,'\\begin\*\?{\zs\w*\*\?\ze}')
        if l:env ==? 'abstract'
            let l:title = 'Abstract'
        elseif l:env ==? 'frame'
            let l:caption = s:CaptionFrame(l:line)
            let l:title = 'Frame - ' . substitute(l:caption, '}\s*$', '','')
        endif
    endif

    return l:level . l:alignlnr . l:lineinfo . l:title . ' '
endfunction

" }}}
