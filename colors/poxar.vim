set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "poxar"

" Palette {{{1

let s:pxc = {}

" Simple colors
let s:pxc.black = '000000'
let s:pxc.white = 'ffffff'

" https://coolors.co/011627-fdfffc-0a9dff-e71d36-ff9f1c-fade3e-c7915b-9dd900
" https://coolors.co/gradient-palette/011627-fdfffc?number=7
" https://github.com/nightsense/cosmic_latte

" Gray palette from bg to fg
let s:pxc.g0 = '1C1B1A'
let s:pxc.g1 = '242321'
let s:pxc.g2 = '3C3B3A'
let s:pxc.g3 = '5C5C5B'
let s:pxc.g4 = '7D7C7C'
let s:pxc.g5 = '9D9C9C'
let s:pxc.g6 = 'BDBDBD'
let s:pxc.g7 = 'DDDDDD'

" Normal foreground and background
let s:pxc.fg = s:pxc.g7
let s:pxc.bg = s:pxc.g0

" Actual color palette

" used for the position of the user (cursor)
let s:pxc.cur = '0a9dff' " tardis blue :)

" used for errors, diffs, and important highlights
let s:pxc.err = 'E71D36' " rose madder red

" main highlighting color
let s:pxc.clr = 'FF9F1C' " orange

" used for searches and highlights
let s:pxc.fnd = 'FADE3E' " yellow

" used for details
let s:pxc.det = 'C7915B' " brown

" used for diffs and everything that needs to stand out
let s:pxc.grn = '9DD900' " lime green

" Highlighting function {{{1

function! s:HL(group, fg, bg, mod, ...)
  let histring = 'hi ' . a:group . ' '

  " first clear the current highlighting to avoid surprises
  execute histring . 'NONE'

  if strlen(a:fg)
    let histring .= 'guifg=#' . get(s:pxc, a:fg) . ' '
  endif

  if strlen(a:bg)
    let histring .= 'guibg=#' . get(s:pxc, a:bg) . ' '
  endif

  if strlen(a:mod)
    let histring .= 'gui=' . a:mod . ' cterm=' . a:mod
  else
    let histring .= 'gui=NONE cterm=NONE'
  endif

  if a:0 >= 1 && strlen(a:1)
    let histring .= ' guisp=#' . get(s:pxc, a:1)
  endif

  " echom histring
  execute histring
endfunction

" Colorscheme {{{1

" clear all underlining
hi Underlined NONE

" UI {{{2

call s:HL('Normal',            'fg',   'bg',   '')
call s:HL('Folded',            'g3',   '',     '')

call s:HL('NonText',           'g2',   '',     '')
call s:HL('SpecialKey',        'g2',   '',     '')

call s:HL('ColorColumn',       '',     'g1',   '')
call s:HL('CursorColumn',      '',     'g1',   '')
call s:HL('CursorLine',        '',     'g1',   '')

call s:HL('CursorLineNr',      'cur',  '',   '')
call s:HL('LineNr',            'g3',   '',   '')
call s:HL('FoldColumn',        'g3',   '',   '')
call s:HL('SignColumn',        '',     '',   '')

call s:HL('StatusLine',        'bg',   'cur',  '')
call s:HL('StatusLineNC',      'fg',   'g2',   '')
call s:HL('StatusLineTerm',    'bg',   'cur',  '')
call s:HL('StatusLineTermNC',  'fg',   'g2',   '')
call s:HL('VertSplit',         'g3',   '',     '')

call s:HL('Title',             'white',   '',     'bold')
call s:HL('TabLine',           '',     '',     '')
call s:HL('TabLineSel',        'bg',   'cur',  '')
call s:HL('TabLineFill',       '',     '',     '')

call s:HL('Visual',            '',     'g3',   '')
call s:HL('VisualNOS',         'white',   'g3',   'bold')

call s:HL('MatchParen',        'fnd',  '',     'bold')
call s:HL('Directory',         'clr',  '',     'bold') " TODO: not too happy with this

call s:HL('ErrorMsg',          'err',  '',     'bold')
call s:HL('IncSearch',         'bg',   'cur',  'bold')
call s:HL('Search',            'bg',   'fnd',  'bold')

call s:HL('MoreMsg',           'g3',   '',     'bold')
call s:HL('ModeMsg',           'g5',   '',     'bold')
call s:HL('Question',          'grn',  '',     'bold')
call s:HL('WarningMsg',        'err',  '',     '') " TODO: stronger difference to error?
call s:HL('WildMenu',          'bg',   'fnd',  '')

call s:HL('DiffAdd',           'bg',   'grn',  '')
call s:HL('DiffChange',        'bg',   'det',  '')
call s:HL('DiffDelete',        'bg',   'err',  '')
call s:HL('DiffText',          'bg',   'clr',  'bold')

call s:HL('SpellCap',          'fnd',  '',     'undercurl,bold', 'fnd')
call s:HL('SpellBad',          '',     '',     'undercurl',      'fnd')
call s:HL('SpellLocal',        '',     '',     'undercurl',      'grn')
call s:HL('SpellRare',         '',     '',     'undercurl',      'err')

call s:HL('Pmenu',             '',     'g2',   '')
call s:HL('PmenuSel',          'bg',   'cur',  'bold')
call s:HL('PmenuSbar',         '',     'g2',   '')
call s:HL('PmenuThumb',        'fg',   'fg',   '')

call s:HL('Cursor',  'black', 'cur', 'none')
call s:HL('vCursor', 'black', 'cur', 'none')
call s:HL('iCursor', 'black', 'cur', 'none')



call s:HL('Comment', 'g3', '', '')
call s:HL('Todo', 'white', '', 'bold')
call s:HL('SpecialComment', 'white', '', 'bold') " TODO: those are docstrings, maybe different?
call s:HL('Error', 'white', 'err', 'bold')


call s:HL('Statement',   'white', '', 'bold')
call s:HL('Keyword',     'white', '', 'bold')
call s:HL('Conditional', 'white', '', 'bold')
call s:HL('Repeat',      'white', '', 'bold')

call s:HL('Label',       'err', '', '')
call s:HL('Operator',    'err', '', '')

call s:HL('Constant',    'clr', '', '')

call s:HL('Special', '', '', '')
call s:HL('Identifier', '', '', '')
call s:HL('PreProc', '', '', '')
call s:HL('Type', '', '', '')

hi htmlH1     ctermfg=15 cterm=bold
hi htmlLink   ctermfg=4 cterm=bold

hi mkdHeading ctermfg=8 cterm=bold

" hi markdownHeadingRule        ctermfg=0 ctermbg=NONE cterm=bold
" hi markdownHeadingDelimiter   ctermfg=8 ctermbg=NONE cterm=NONE
