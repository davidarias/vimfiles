"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"activate pathogen
call pathogen#infect()

colors wolfpack

"guioptions
" Remove menu bar
set guioptions-=m
"
" " Remove toolbar
set guioptions-=T

" Remove right scrollbar
set guioptions-=r
"
" " Remove left scrollbar
set guioptions-=L

" set guifont=Liberation\ Mono\ 10
set guifont=Source\ Code\ Pro\ 11

set nowrap         "no wrap lines
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"autosave when lost focus
autocmd BufLeave,FocusLost * wall

" buffer delete don't close window
map <C-q> :Kwbd<cr>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" copy and paste to sysmtem clipboard
set clipboard=unnamedplus

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set number      "show line numbers

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

"set wrap        "dont wrap lines
"set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeChDirMode = 2

" let g:ycm_add_preview_to_completeopt = 1
"
set completeopt=longest,menuone

"explorer mappings
nnoremap <f1> :BufExplorer<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>

"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif


" bindings for ctrlp
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" bindigns for vim-task

inoremap <silent> <buffer> <C-S-d> <ESC>:call Toggle_task_status()<CR>i
noremap <silent> <buffer> <C-S-d> :call Toggle_task_status()<CR>

" powerline

set laststatus=2
" let g:Powerline_symbols = 'fancy'


" don't show syntastic signs
let g:syntastic_enable_signs = 0
