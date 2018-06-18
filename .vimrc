set nocompatible

"{{{ Plugins
filetype off
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'shime/vim-livedown'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 't9md/vim-choosewin'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
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
set numberwidth=6   " Make line numbers space wider
set cursorline      " Draw line cursor
set colorcolumn=+1  " Want to see right margin
set noshowmode      " Don't need mode to be shown
set linebreak       " Don't break in the middle of word
let &showbreak='↪ ' " Good break marker
set shortmess+=c    " Hide '1 match' and other related messages
set splitbelow      " Horizontal split should appear below
set splitright      " Vertical split should appear on right
set synmaxcol=300   " Don't highlight lines longer than 300 characters
set list            " Show additional characters
set listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬
set title           " Change title of terminal
"}}}

"{{{ Search
set hlsearch    " Highlight search matches
set incsearch   " Incremental search
set ignorecase  " Ignore case...
set smartcase   " unless I start search keyword with capital letter
set grepprg=rg\ --vimgrep
"}}}

"{{{ Editor
set softtabstop=4       " Treat tab as 4 spaces during editing
set shiftwidth=4        " Spaces for shifting/indenting
set expandtab           " We need spaces, not tabs
set backspace=2         " Backspace behavior I used to
set whichwrap+=<,>,[,]  " Wrapping behavior
set showmatch
set noswapfile " I don't like swapfiles
set timeoutlen=500
set ttimeoutlen=0
set pumheight=10        " Completion window max size
set textwidth=120
set shiftround          " Round indent

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END
"}}}

"{{{ UNGROUPED
set hidden " Allow me to switch to another buffers without saving
set autowrite " Write file if jump goes out of this file
set completeopt-=preview
set completeopt+=noselect
set clipboard=unnamed
let loaded_matchparen=1
set lazyredraw          " Wait to redraw
if !has('nvim')
    set ttyfast
endif
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
set scrolloff=3         " Don't reach borders when dummy-scrolling
set mouse=a
let html_no_rendering=1 " Don't render italic, bold, links in HTML
set updatetime=100
set virtualedit=block " Enable virtual edit mode in block selection
set wildmenu
set wildmode=list:full
set wildignorecase
set wildignore+=**/node_modules   " ignores node_modules
set wildignore+=**/bower_components   " ignores bower_components
"}}}

"{{{ Bindings
let mapleader=","

" Vimrc editing simplification
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nmap - <Plug>(choosewin)

" No arrows please
map <left> <nop>
map <right> <nop>
map <down> <nop>
map <up> <nop>

" Moving through visual line by default
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easier jump to begin/end of line
noremap H ^
noremap L $
vnoremap L g_
vnoremap $ g_
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Select the line
nnoremap vv ^vg_

vmap <silent> > >gv
vmap <silent> < <gv

" I want each newline to create undo point
inoremap <return> <C-g>u<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

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
nnoremap <silent> <esc><esc> :nohls<cr>

map <C-n> :NERDTree<cr>
map <C-f> :NERDTreeFind<CR>
map <C-p> :FZF<CR>

" Zooming into specific split.
map <silent> zi :tabedit +<C-r>=line(".")<cr> %<cr>zz
map <silent> Zi :only<cr>
map <silent> zo :call ZoomOut()<cr>
function! ZoomOut()
    let linenr = line(".")
    exec 'tabclose'
    exec 'normal ' . linenr . 'G'
endfunction

" Operator-pending bindings
onoremap p i(
onoremap ib i{
onoremap ab a{
"}}}

"{{{ [C] configuration
augroup filetype_c
    autocmd!
    autocmd FileType c nmap <leader>b :make!<cr>
augroup END
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
    set guifont=Source\ Code\ Pro:h12
endif
"}}}

"{{{ CScope
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-,g-

" All next keymaps set R mark so you are able to return back
" Find assignments to this symbol
nmap <C-s>a mR:cs find a <C-R>=expand("<cword>")<CR><CR>:cwin<CR>
"Find this C symbol
nmap <C-s>s mR:cs find s <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this definition
nmap <C-s>g mR:cs find g <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find functions calling this function
nmap <C-s>c mR:cs find c <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this text string
nmap <C-s>t mR:cs find t <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this egrep pattern
nmap <C-s>e mR:cs find e <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 
"Find this file
nmap <C-s>f mR:cs find f <C-R>=expand("<cfile>")<CR><CR>:cwin<CR> 
"Find files #including this file
nmap <C-s>i mR:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:cwin<CR> 
"Find functions called by this function
nmap <C-s>d mR:cs find d <C-R>=expand("<cword>")<CR><CR>:cwin<CR> 

nmap <C-s>q :cexpr []<cr>

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

"{{{ NERDTree
let NERDTreeChDirMode=0
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
"}}}

"{{{ Ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"}}}

"{{{ NERDCommenter
let g:NERDSpaceDelims = 1       " Add spaces after comment delimiters by default
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
"}}}

"{{{ vim-go
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
    autocmd FileType go cabbrev god GoDecls 
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

"{{{ FZF
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
"}}}

"{{{ Livedown
let g:livedown_browser = "safari"
"}}}

" {{{ Rust
let g:rustfmt_autosave = 1

augroup filetype_rust
    autocmd!
    autocmd FileType rust nmap <leader>r :make run<cr>
    autocmd FileType rust nmap <leader>t :make test<cr>
    autocmd FileType rust nmap <leader>b :make build<cr>
    autocmd FileType rust compiler cargo
augroup END
" }}}

"{{{ Deoplete
let g:deoplete#enable_at_startup = 1
"}}}
"
" {{{ Deoplete CLang
let g:deoplete#sources#clang#libclang_path="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
" }}}
