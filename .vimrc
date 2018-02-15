set nocompatible
filetype off

"{{{ Plugins
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
    Plug 'zchee/deoplete-go'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'shime/vim-livedown'
Plug 'cespare/vim-toml'
Plug 'edkolev/tmuxline.vim'
call plug#end()

filetype indent plugin on
"}}}

let g:tmuxline_powerline_separators = 0

"{{{ Visual
" Turn on syntax highlight
syntax on

" Setting background to dark
set background=dark

" Sweet theme
colorscheme onedark

" Always show status line
set laststatus=2

" Show tab line
set showtabline=0

" Show numbers
set number

" Draw line cursor
set cursorline

" Want to see right margin
set colorcolumn=120

" Don't need mode to be shown
set noshowmode

" Don't break in the middle of word
set linebreak

" Good break marker
let &showbreak='> '

" Hide '1 match' and other related messages
set shortmess+=c

set splitbelow
set splitright
"}}}

"{{{ Search
" Highlight search matches
set hlsearch

" Incremental search
set incsearch

" Let's be smart on search
set ignorecase
set smartcase
"}}}

"{{{ Editor
" Treat tab as 4 spaces during editing
set softtabstop=4

" Spaces for shifting/indenting
set shiftwidth=4

" We need spaces, not tabs
set expandtab

" Backspace behavior I used to
set backspace=2

" Wrapping behavior
set whichwrap+=<,>,h,l,[,]
set showmatch

" I don't like swapfiles
set noswapfile
"}}}

"{{{ UNGROUPED
set hidden
set autowrite
set completeopt-=preview
set completeopt+=noselect
set clipboard=unnamed
let loaded_matchparen=1
set lazyredraw          " Wait to redraw
set ttyfast
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

nnoremap <leader>a :cclose<CR>
noremap <Up> gk
noremap <Down> gj
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
map zi :tabedit +<C-r>=line(".")<cr> %<cr>zz
map Zi :only<cr>
map zo :tabclose<cr>

map "p vi"p
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
let g:go_auto_type_info = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
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
