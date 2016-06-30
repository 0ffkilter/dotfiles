" PRELUDE {{{

    " Note: Skip initialization for vim-tiy or vim-small.
    if !1 | finish | endif

    " No vi compatibility
    " Also needed for cool vim stuff
    if &compatible
        set nocompatible
    endif

    " Rebind mapleader to something more accessible.
    let mapleader = ','

    " python setup
    let g:python3_host_prog = '/usr/bin/python3'
    "" disable python
    " let g:loaded_python3_provider = 1
    "" skip if_has('python3') check
    " let g:python3_host_skip_check = 1

" SETUP }}}

" BUNDLES {{{

" INITIALIZATION {{{

call plug#begin('~/.vim/plugged')


function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" INITIALIZATION }}}

" Deoplete - Autocomplete {{{

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    let g:deoplete#enable_at_startup = 1

" }}}

" Vim Fugitive - Git Wrapper {{{

Plug 'tpope/vim-fugitive'

" }}}

" Vim Airline - Buffer Bars {{{

Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1

" }}}

" Vim Auto Save - Auto Saves {{{

Plug '907th/vim-auto-save'
    " Don't save while typing 
    let g:auto_save_in_insert_mode = 0
    " Interval, mostly for latex editing
    let g:auto_save = 1

" }}}

" Git Gutter - Git Changes in sidebar {{{

Plug 'airblade/vim-gitgutter'

" }}}

" Latex Box - Latex autocomplete, etc {{{

Plug 'LaTeX-Box-Team/LaTeX-Box'
    let g:tex_flavor='latex'

" }}}

" Nerdcommenter - Quick Commenting {{{

Plug 'scrooloose/nerdcommenter'

" }}}

" Kalisi - Theme {{{

Plug 'freeo/vim-kalisi'

" }}}

" SudoWrite - SudoEdit {{{

Plug 'chrisbra/SudoEdit.vim'

" }}}

" FINISH {{{

call plug#end()

" FINISH }}}


" }}}

" GENERAL {{{

    filetype plugin on
    filetype plugin indent on       " detect filetypes
    syntax on                       " syntax highlighting
    set history=1000                " make the history larger
    set hidden                      " change buffers w/o having to write first
    set mouse=a                     " enable mouse
    scriptencoding=utf-8            " set encoding to utf-8
    "set shortmess+=filmnrxoOtT      " abbreviate annoying messages

" GENERAL }}}

" VISUAL {{{

    set nu                          " set line numbers
    set showmode                    " show current display mode
    set cursorline                  " show a line under the cursor

    if has('cmdline_info')
        set ruler                                           " show ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " uber ruler
        set showcmd                                         " show partial commands in status line
    endif

    " Colorscheme
    set background=dark
    colorscheme kalisi

    " Highlight CursorLine as lighter background color
    highlight CursorLine ctermbg=black

    " Make matching text readable
    highlight MatchParen ctermbg=black

    " Sign column color should be the same as the line number column
    highlight SignColumn ctermbg=NONE

    " Make line number column same as background color
    highlight LineNr ctermbg=NONE

    " Don't underline the fold lines
    highlight Folded term=bold cterm=bold ctermbg=NONE

" VISUAL }}}

" BEHAVIOR {{{

    set backspace=indent,eol,start  " easy backspace
    set linespace=0                 " reduce space between lines

    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you search
    set hlsearch                    " highlight search
    set ignorecase                  " ignore case
    set smartcase                   " case sensitive when uc

    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command completion
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys also wrap

    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " min # of lines to keep below cursor

    set foldenable                  " auto fold code

    set gdefault                    " always use /g on :s substitution

    set wrap                      " warp long lines
    set clipboard=unnamedplus       " place yanked text into the clipboard

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    
    autocmd BufWritePost *.tex Latexmk


    vmap r "_dP 


    " custom text folding function
    function! NeatFoldText()
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart(repeat(foldchar, v:foldlevel*2) . '|' . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction

    set foldtext=NeatFoldText()

" BEHAVIOR }}}

" TAB SETTINGS {{{

    set tabpagemax=15               " max # of tabs per page
    set autoindent                  " indent at same level as previous line
    set expandtab                   " space tabs
    set shiftwidth=4                " 4 spaces per tab
    set softtabstop=4               " backspace deletes pseudo-tab
    set tabstop=4                   " indent every 4 columns

" TAB SETTINGS }}}

" KEYBINDINGS {{{

    " Rebind Arrow keys to something more useful
    " Left and Right indent and un-indent the current line/selection
    nnoremap <silent><Left> <<
    nnoremap <silent><Right> >>

    vnoremap <silent><Left> <gv
    vnoremap <silent><Right> >gv

    " Bind Up and Down keys to add line above and below
    nnoremap <silent><Up> O<Esc>j
    nnoremap <silent><Down> o<Esc>k

    " remap Visual Block selection to something that doesn't conflict with system
    " copy/paste
    nnoremap <leader>v <C-v>

    " map S-J and S-K to next and prev buffer
    nnoremap J :bp<CR>
    nnoremap K :bn<CR>

    " map S-H and S-L to undo and redo
    nnoremap H u
    nnoremap L <C-R>

    " Window movement w/ CTRL + h,j,k,l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Reload nvimrc
    nnoremap <silent> <leader>V :source ~/.nvimrc<CR>:filetype detect<CR>:exe ":echo 'nvimrc reloaded'"<CR>

" KEYBINDINGS }}}

" POSTLUDE {{{

    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.

" }}}

" vim: foldmethod=marker
