" vim: set foldmarker={{{,}}} foldmethod=marker:
" Base {{{


" enable filetype detection, plugins for filetypes, and indent
filetype plugin indent on
syntax on

" tell vim how to handle folds (zm, zr, za)
set foldmethod=syntax

set autoindent
set background=dark
set backspace=indent,eol,start    " allow backspace over anything in insert mode

" don't be compatible with legacy vi
set nocompatible

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::

" if we have spelling on, where are the words?
set dictionary+=/usr/share/dict/words

"replace tabs with spaces
set expandtab

set equalalways "automatically resize open windows
set foldlevelstart=99
set hlsearch
set ignorecase
set incsearch
set matchtime=2
" set matchpairs (which patterns can be matched with %)
"set matchpairs=(:),{:},[:],<:>
set mousemodel=popup
set nojoinspaces
set number
set showcmd        " display incomplete commands
set showfulltag    " show prototype when completing words using tags file
set showmatch
set smarttab
set smartindent
set shiftwidth=4
set nostartofline
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.class
set title
set ttyfast        " we have a fast terminal connection
set ttyscroll=3
set visualbell
set wildmenu
set wildmode=list:longest
set mouse=a
let g:html_tag_case = 'lowercase'
" don't read .gvimrc
set secure
set grepprg=grep\ -nH\ $*

" Don't litter my directory with .swp files, put them in ~/tmp and use full
" paths (trailing //)
set backupdir=~/tmp//
set directory=~/tmp//

" see ':he last-position-jump'
" Goes to the line the file was last at when opened
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after,~/.vim/bundle/vundle
set viminfo='100,h
set laststatus=2
:set hidden
set completeopt-=preview
"}}}
" C++ options {{{
let b:syntastic_cpp_cflags = '-I. -I$HOME/include -I/opt/openmpi/include -I/usr/include -std=c++11'
function SetCppOpts()
    setfiletype cpp
    "match these characters with %
    set matchpairs=(:),{:},[:],<:>

    "eclipse style add a * comments
    set comments-=s1:/*,mb:*,ex:*/
    set comments+=fb:*

    "completion options
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set completeopt=longest,menuone
endfunction
autocmd BufNewFile,Bufread *.cxx,*.h,*.cpp,*.cc,*.c,*.hpp call SetCppOpts()

"}}}
" Java options {{{
function SetJavaOpts()
    setfiletype java
    "match these characters with %
    setlocal matchpairs=(:),{:},[:],<:>

    "eclipse style add a * comments
    setlocal comments-=s1:/*,mb:*,ex:*/
    setlocal comments+=fb:*

    "completion options
    setlocal cscopequickfix=s-,c-,d-,i-,t-,e-
    setlocal completeopt=longest,menuone
    setlocal completefunc=javacomplete#Complete
    "export java classpath as completion locations for javacomplete
    for i in split($CLASSPATH,":")|call javacomplete#AddClassPath(i)|endfor
endfunction
autocmd BufNewFile,Bufread *.java call SetJavaOpts()

"}}}
" python options {{{
function SetPythonOpts()
    setfiletype python
    setlocal completeopt=longest,menuone
endfunction
autocmd BufNewFile,Bufread *.py call SetPythonOpts()
"}}}
" make options {{{
function SetMakeOpts()
    " Make sure a hard tab is used, required for most make programs
    setlocal noexpandtab softtabstop=0

    " Set 'formatoptions' to break comment lines but not other lines,
    " and insert the comment leader when hitting <CR> or using "o".
    setlocal fo-=t fo+=croql

    " Set 'comments' to format dashed lists in comments
    setlocal com=sO:#\ -,mO:#\ \ ,b:#

    " Set 'commentstring' to put the marker after a #.
    setlocal commentstring=#\ %s

    " Including files.
    let &l:include = '^\s*include'

    setlocal noexpandtab " don't use spaces to indent
    setlocal nosmarttab  " don't ever use spaces, not even at line beginnings
endfunction
autocmd BufNewFile,Bufread Makefile,makefile call SetMakeOpts()
"}}}
" sh settings {{{
let g:is_bash = 1
"}}}
" R settings {{{
"au BufWritePost *.r,*.R !LD_LIBRARY_PATH=/opt/java/jre/lib/amd64/server Rscript %
"}}}
" Bundles {{{
"call vundle#rc()

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

"manage bundles
call plug#begin('~/.vim/bundle')
"Bundle 'gmarik/vundle'
"git integration
Plug 'tpope/vim-fugitive'
"warnings and errors in sidebar
Plug 'scrooloose/syntastic'
"prettyful status line
Plug 'bling/vim-airline'
"show buffer names in status line
Plug 'bling/vim-bufferline'
"add motions like inside paragraph
Plug 'tpope/vim-surround'
"show where motions will move to
Plug 'Lokaltog/vim-easymotion'
"make <C-A> and <C-X> smart for dates
Plug 'tpope/vim-speeddating'
"make tabs visible
Plug 'Yggdroot/indentLine'
"align text
Plug 'godlygeek/tabular'
"useful for highlighing columns
Plug 'chrisbra/csv.vim'
"C/C++ autocompletion
Plug 'Rip-Rip/clang_complete'
"python autocompletion
Plug 'davidhalter/jedi-vim'
"java autocompletion
Plug 'cilquirm/javacomplete'
"nice looking color scheme
Plug 'vim-scripts/tchaba'
"another decent looking color scheme
Plug 'morhetz/gruvbox'
"a set of color schemes
Plug 'vim-scripts/Colour-Sampler-Pack'
"tab that can determine when to complete vs when to insert a tab
Plug 'ervandew/supertab'
"rename files with :Renamer, make changes, :Ren
Plug 'vim-scripts/renamer.vim'
"another nice dark color scheme
Plug 'freeo/vim-kalisi'
"colorscheme development file
Plug 'MicahElliott/vim-cterm-highlight'

"syntax file for OpenCL
Plug 'petRUShka/vim-opencl'

"test color schemes by setting filetype to highlight them
Plug'vim-scripts/Color-Scheme-Test'

cal plug#end()
"}}}
" Aesthetics {{{
" Get fancy symbols from powerline (airline)
let g:airline_powerline_fonts = 1
let g:airline_theme="simple"
let g:AirlineEnableSyntastic=1

" Use the old symbols for powerline (airline)
let g:airline_symbols = {}
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" set a color and symbol for indentation (to see level)
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'
"indentLine breaks latex with concealcursor, don't let it do this
let g:indentLine_noConcealCursor=1

"}}}
" CSV settings {{{
" Highlight csv columns (almost a necessity with wrap on)
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
"}}}
" Latex settings {{{
function SetTexOpts()
    setfiletype tex
    let g:tex_flavor = "latex"
    setlocal concealcursor=""
    setlocal conceallevel=2
    setlocal tw=80
endfunction
autocmd BufNewFile,Bufread *.tex call SetTexOpts()
" Get the name of the main latex file, poached from either latex-suite or
" latex-box, used for synctex with subfiles
function! Tex_GetMainFileName(...)
    if a:0 > 0
        let modifier = a:1
    else
        let modifier = ':p'
    endif
    let s:origdir = fnameescape(getcwd())
    let dirmodifier = '%:p:h'
    let dirLast = fnameescape(expand(dirmodifier))
    exe 'cd '.dirLast
    " move up the directory tree until we find a .latexmain file.
    " TODO: Should we be doing this recursion by default, or should there be a
    " setting?
    while glob('*.latexmain',1) == ''
        let dirmodifier = dirmodifier.':h'
        let dirNew = fnameescape(expand(dirmodifier))
        " break from the loop if we cannot go up any further.
        if dirNew == dirLast
            break
        endif
        let dirLast = dirNew
        exe 'cd '.dirLast
    endwhile
    let lheadfile = glob('*.latexmain',1)
    if lheadfile != ''
        " Remove the trailing .latexmain part of the filename... We never want
        " that.
        let lheadfile = fnamemodify(substitute(lheadfile, '\.latexmain$', '', ''), modifier)
    else
        " If we cannot find any main file, just modify the filename of the
        " current buffer.
        let lheadfile = expand('%'.modifier)
    endif
    exe 'cd '.s:origdir
    " NOTE: The caller of this function needs to escape the file name with
    " fnameescape() . The reason its not done here is that escaping is not
    " safe if this file is to be used as part of an external command on
    " certain platforms.
    return lheadfile
endfunction

" Go to current location in pdf file if using latex
function! SyncTexForward()
    let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
    let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &>/dev/null &'
    exec execstr | redraw!
endfunction
autocmd BufNewFile,BufRead *.tex :setlocal spell
"}}}
" Keybindings {{{
let mapleader=" "
" Put all mappings at the end of the file so functions are declared first
" Print highlight group (useful to figure out why colors suck)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Close buffer
nnoremap <Leader>d :bd<CR>
" Go to previous buffer
nnoremap <Leader>p :bp<CR>
" Go to next buffer
nnoremap <Leader>n :bn<CR>
" Go to buffer <type name of buffer (or number)>
nnoremap <Leader>f :b<Space>
" Go to next error in code
nnoremap <Leader>cn :cn<CR>
" Go to previous error in code
nnoremap <Leader>cp :cp<CR>
" Jump to current location in pdf
nnoremap <Leader>j :call SyncTexForward()<CR>
" Go to buffer n
nnoremap <Leader>1 :b 1<CR>
nnoremap <Leader>2 :b 2<CR>
nnoremap <Leader>3 :b 3<CR>
nnoremap <Leader>4 :b 4<CR>
nnoremap <Leader>5 :b 5<CR>
nnoremap <Leader>6 :b 6<CR>
nnoremap <Leader>7 :b 7<CR>
nnoremap <Leader>8 :b 8<CR>
nnoremap <Leader>9 :b 9<CR>
" indent file
nnoremap <Leader>= mzgg=G`z
" Compile a (simple) latex file (use make for a more complex one)
nnoremap <F2> :w<CR>:!latexmk -pdflatex='pdflatex -file-line-error -synctex=1 -shell-escape' -pdf %<CR>:!latexmk -c %<CR>
" run make
nnoremap <Leader>m :make<CR>

" change mapping so that control space does user supplied completion
inoremap <expr> <C-Space> "\<C-x>\<C-u>"
imap <C-@> <C-Space>
"let g:SuperTabDefaultCompletionType = "<C-Space>"
"let g:SuperTabContextDefaultCompletionType = "<C-Space>"
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<C-Space>"
let g:clang_complete_auto=0

"}}}
" Colors {{{
":colors vibrantink
:colors jrusst
" I have not found diff colors that are easy to read, these ones work but are
" ugly, taken from
" https://github.com/dhruvasagar/vim-railscasts-theme/blob/master/colors/railscasts.vim
"
"" Diffs
"" -----
"hi DiffAdd guifg=#e4e4e4 guibg=#519F50 ctermfg=254 ctermbg=22
"hi DiffDelete guifg=#000000 guibg=#660000 gui=bold ctermfg=16 ctermbg=52 cterm=bold
"hi DiffChange guifg=#FFFFFF guibg=#870087 ctermfg=15 ctermbg=90
"hi DiffText guifg=#FFFFFF guibg=#FF0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
"hi diffAdded guifg=#008700 ctermfg=28
"hi diffRemoved guifg=#800000 ctermfg=1
"hi diffNewFile guifg=#FFFFFF guibg=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
"hi diffFile guifg=#FFFFFF guibg=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
"
"" Force a black background
"hi Normal ctermbg=black ctermfg=white
"
"" Make search colors readable
"hi Search ctermbg=57 ctermfg=white
"
"" Fix parend matches
"hi MatchParen cterm=bold ctermfg=yellow ctermbg=bg
"
"" Completion colors
"highlight   Pmenu         ctermfg=0 ctermbg=2
"highlight   PmenuSel      ctermfg=2 ctermbg=0
"":highlight   PmenuSbar     ctermfg=7 ctermbg=0
"":highlight   PmenuThumb    ctermfg=0 ctermbg=7
"
"" Regular background
""highlight Normal ctermbg=black ctermfg=white
"" Search colors
"highlight Search ctermbg=57 ctermfg=white
"
" Highlight the 80th column so that it's easy to see where to break lines
let &colorcolumn=80

"}}}
set completeopt-=preview
