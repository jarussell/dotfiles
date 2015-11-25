set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "jrusst"

" Only use colors 16+ because many people change 0-16 in
" .Xresources/.Xdefaults
set t_Co=256
" This must appear before any ctermbg=NONE
highlight Normal ctermfg=White ctermbg=Black guifg=White guibg=Black

" Rest are sorted unless there is a hi link
"highlight Comment ctermfg=98 guifg=#9933CC
highlight Comment ctermfg=105 guifg=#9933CC
highlight Constant ctermfg=81 guifg=#FFEE98
highlight Cursor ctermfg=Black ctermbg=Yellow guifg=Black guibg=Yellow
highlight CursorLine cterm=NONE ctermbg=235 guibg=#323300
highlight Define ctermfg=202 guifg=#FF6600
highlight DiffAdd guifg=#e4e4e4 guibg=#519F50 ctermfg=254 ctermbg=22
highlight DiffChange guifg=#FFFFFF guibg=#870087 ctermfg=15 ctermbg=90
highlight DiffDelete guifg=#000000 guibg=#660000 gui=bold ctermfg=16 ctermbg=52 cterm=bold
highlight DiffText guifg=#FFFFFF guibg=#FF0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
highlight Function ctermfg=220 guifg=#FFCC00 gui=NONE
highlight Identifier ctermfg=White guifg=White gui=NONE
highlight Include ctermfg=220 guifg=#FFCC00 gui=NONE
highlight Keyword ctermfg=202 guifg=#FF6600
"highlight LineNr cterm=bold ctermfg=White ctermbg=59  guibg=DarkGrey guifg=NONE
highlight LineNr cterm=bold ctermfg=243 ctermbg=232  guibg=DarkGrey guifg=NONE
highlight MatchParen cterm=bold ctermfg=yellow ctermbg=bg
highlight Operator ctermbg=NONE ctermfg=148
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=2 ctermbg=0
highlight Search ctermbg=57 ctermfg=white
highlight Special ctermfg=145 ctermbg=NONE guifg=#66FF00 guibg=NONE
highlight Statement ctermfg=208 guifg=#FF6600 gui=NONE
highlight String ctermfg=32 ctermbg=NONE guifg=#66FF00 guibg=NONE
highlight Type ctermfg=White guifg=White gui=NONE
highlight diffAdded guifg=#008700 ctermfg=28
highlight diffFile guifg=#FFFFFF guibg=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
highlight diffNewFile guifg=#FFFFFF guibg=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
highlight diffRemoved guifg=#800000 ctermfg=1
highlight rubyInterpolation ctermfg=White guifg=White
highlight rubyPseudoVariable ctermfg=66 guifg=#339999
highlight rubyStringDelimiter ctermfg=82 guifg=#66FF00
highlight rubySymbol ctermfg=66 guifg=#339999 gui=NONE
highlight Type ctermfg=118 guifg=#A6E22E ctermbg=NONE guibg=NONE
