set nocompatible

"{{{ Plugins
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-go'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'shime/vim-livedown'
Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'davidhalter/jedi'
Plug 'zchee/deoplete-jedi'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
call plug#end()

filetype indent plugin on
"}}}

"{{{ Visual
syntax on           " Turn on syntax highlight
set background=dark " Setting background to dark
colorscheme onedark " Sweet theme
set laststatus=2    " Always show status line
set showtabline=0   " Show tab line
set number          " Show numbers...
set relativenumber  " relatively
set cursorline      " Draw line cursor
set colorcolumn=120 " Want to see right margin
set noshowmode      " Don't need mode to be shown
set linebreak       " Don't break in the middle of word
let &showbreak='> ' " Good break marker
set shortmess+=c    " Hide '1 match' and other related messages
set splitbelow      " Horizontal split should appear below
set splitright      " Vertical split should appear on right
"}}}

"{{{ Search
set hlsearch    " Highlight search matches
set incsearch   " Incremental search

set ignorecase  " Ignore case...
set smartcase   " unless I start search keyword with capital letter
"}}}

"{{{ Editor
set softtabstop=4   " Treat tab as 4 spaces during editing
set shiftwidth=4    " Spaces for shifting/indenting
set expandtab       " We need spaces, not tabs
set backspace=2     " Backspace behavior I used to
set whichwrap+=<,>,h,l,[,] " Wrapping behavior
set showmatch
set noswapfile " I don't like swapfiles
set timeoutlen=500
set ttimeoutlen=0
"}}}

"{{{ UNGROUPED
set hidden " Allow me to switch to another buffers without saving
set autowrite " Write file if jump goes out of this file
set completeopt-=preview
set completeopt+=noselect
" set clipboard=unnamed
let loaded_matchparen=1
set lazyredraw          " Wait to redraw
if !has('nvim')
    set ttyfast
endif
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
set mouse=a
let html_no_rendering=1 " Don't render italic, bold, links in HTML
set updatetime=100
set virtualedit=block " Enable virtual edit mode in block selection
set wildmenu
set wildignore+=**/node_modules   " ignores node_modules
set wildignore+=**/bower_components   " ignores node_modules
"}}}

"{{{ Bindings
let mapleader=","

map <left> <nop>
map <right> <nop>
map <down> <nop>
map <up> <nop>
imap <bs> <nop>

nnoremap Hh ^
nnoremap Ll $

" I want each newline to create undo point
inoremap <return> <C-g>u<cr>

" Make numbers a little bit closer on mac
if has('mac')
    map å 1
    map ß 2
    map ∂ 3
    map ƒ 4
    map © 5
    map ˙ 6
    map ∆ 7
    map ˚ 8
    map ¬ 9
    map … 0
endif

noremap j gj
noremap k gk

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <silent> <leader>d :bp\|bd#<cr>
nnoremap <silent> <leader>w :hide<cr>
nnoremap <leader>W :silent! bd!<cr>
nnoremap <leader>, :silent! bp<cr>
nnoremap <leader>. :silent! bn<cr>
nnoremap <leader>n :silent! enew<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap Y y$
nnoremap <esc><esc> :silent! nohls<cr>

map <C-n> :NERDTree<cr> 
map <C-f> :NERDTreeFind<CR>

map <C-p> :FZF<CR>
map ; :Buffers<cr>

" Zooming into specific split.
map zi :tabedit +<C-r>=line(".")<cr> %<cr>zz
map Zi :only<cr>
map zo :call ZoomOut()<cr>
function! ZoomOut()
    let linenr = line(".")
    exec 'tabclose'
    exec 'normal ' . linenr . 'G'
endfunction
"}}}

"{{{ [C] configuration
augroup filetype_c
    autocmd!
    autocmd FileType c nmap <leader>b :make!<cr>
augroup END
"}}}

"{{{ [Go] configuration
augroup filetype_go
    autocmd!
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    autocmd FileType go setlocal tabstop=8
    autocmd FileType go setlocal softtabstop=8
    autocmd FileType go setlocal shiftwidth=8
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
augroup END

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_echo_go_info = 0
"}}}

"{{{ [Vim] configuration
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

"{{{ [Yaml] configuration
augroup filetype_yaml
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
"}}}

"{{{ GUI configuration
if has('gui') 
    set guioptions-=L
    set guifont=Iosevka:h15
endif
"}}}

"{{{ NERDTree configuration
let NERDTreeChDirMode=0
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI=1
"}}}

"{{{ AG configuration
" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
cabbrev ag Ag
"}}}

"{{{ CScope
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-,g-

" All next keymaps set R mark so you are able to return back
" Find assignments to this symbol
nmap <C-i>a mR:cs find a <C-R>=expand("<cword>")<CR><CR>:cwin<CR>
"Find this C symbol
nmap <C-i>s mR:cs find s <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this definition
nmap <C-i>g mR:cs find g <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find functions calling this function
nmap <C-i>c mR:cs find c <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this text string
nmap <C-i>t mR:cs find t <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this egrep pattern
nmap <C-i>e mR:cs find e <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this file
nmap <C-i>f mR:cs find f <C-R>=expand("<cfile>")<CR><CR>:cwin<CR> 
"Find files #including this file
nmap <C-i>i mR:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:cwin<CR> 
"Find functions called by this function
nmap <C-i>d mR:cs find d <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 

nmap <C-i>q :cexpr []<cr>

command! Cqf cexpr []

if has("cscope")
    set csto=0
    set cscopetag
    set cscoperelative
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif
" }}}

"{{{ Deoplete
let g:deoplete#enable_at_startup = 1
"}}}

"{{{ Livedown
" My primary is chrome, so we can use safari for other stuff
let g:livedown_browser = "safari"
"}}}

"{{{ Abbreviations
iabbrev @@ peshkovroman@gmail.com
"}}}

"{{{ Lightline
let g:lightline = {
    \ 'active': {
    \   'left': [['mode'], ['readonly', 'filename', 'modified'], ['tagbar']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \ },
    \ }
"}}}

"{{{ [Rust] configuration
augroup filetype_rust
    autocmd!
    autocmd FileType rust nmap <leader>r :Cargo run<cr>
    autocmd FileType rust nmap <leader>t :Cargo test<cr>
    autocmd FileType rust nmap <leader>b :Cargo build<cr>
augroup END
"}}}

"{{{ FZF configuration
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
"}}}
