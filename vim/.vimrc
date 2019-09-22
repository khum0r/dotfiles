"                                   
"                    ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄  
"                   ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█  
"                    ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄ 
"                     ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"                      ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"                      ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"                      ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒   
"                        ░░   ▒ ░░      ░     ░░   ░ ░        
"                         ░   ░         ░      ░     ░ ░      
"                        ░                           ░        

" Vundle Set tings{{{ 
"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'cespare/vim-toml'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'nvie/vim-flake8'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'SirVer/ultisnips'
Plugin 'sukima/xmledit'
Plugin 'python-mode/python-mode'
Plugin 'Raimondi/delimitMate'
Plugin 'digitaltoad/vim-pug'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/goyo.vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'moll/vim-node'
Plugin 'lervag/vimtex'
Plugin 'iamcco/markdown-preview.vim'

""" Colorscheme
Plugin 'dylanaraps/wal.vim'
Plugin 'whatyouhide/vim-gotham'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'lilydjwg/colorizer'
Plugin 'morhetz/gruvbox'

call vundle#end()       
filetype plugin indent on  

"}}}  


"  Set Colorscheme and Statusline{{{
set background=dark
colorscheme bleh

"let g:gruvbox_contrast_dark = 'hard'

"" Status line
set laststatus=0
set t_Co=256
" let g:lightline = {
"       \ 'colorscheme': 'gotham',
"      \ }      
 "}}} 

" UI Config {{{ 
"" These are options that changes random visuals in Vim
syntax on
filetype on
"set number                       " show line numbers
set encoding=utf-8
set noshowmode                   " Hide UI
"set showcmd                      " show command in bottom bar
set tw=79                        " width of document (used by gd)
set nowrap                       " don't automatically wrap on load
set smartindent
set colorcolumn=80
set visualbell                   " don't beep
set noerrorbells                 " don't beep
set autowrite                    " Save on buffer switch
set mouse+=a
set encoding=utf-8
set cursorline                   " highlight current line
set lazyredraw                   " redraw only when we need to
set showmatch                    " highlight matching [{()}]
set autoindent
set expandtab
set splitbelow
set splitright
"set spell                        " Turn on spell checker
"set spellsuggest=5               " Limit the number of suggested words
"}}} 


" Spaces & Tabs{ {{
"set tabstop=4             " number of visual spaces per TAB
"set softtabstop=4         " number of spaces in tab when editing
"set expandtab             " tabs are spaces
set  backspace=indent,eol,start

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
"}}}


" System clipboar d{{{
""cut/copy/paste to/from other application
set clipboard=unnamed     " access your system clipboard
"}}}


" Split Layouts{{{
""specify different areas of the screen
set splitbelow
set splitright
""split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"}}}


" Searching{{{ 
set incsearch             " search as characters are entered
set hlsearch              " highight matches

"" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 
"}}} 


"" Code Folding
set foldmethod=indent
set foldlevelstart=10     " open most folds by default
set foldlevel=99
set foldnestmax=10        " 10 nested fold max

"" space open/closes folds
nnoremap <space> za
set foldmethod=indent     " fold based on indent level
"}}} 


"  Movement{{{ 
"" easier moving of code blocks
"" Try to go into visual mode (v), thenselect several lines of code here and
"" then press ``>`` several times.
vnoremap < <gv              " better indentation
vnoremap > >gv              " better indentation
"}}


" Leader Shortcuts and Short cuts{{{
let mapleader=","           " leader is comma

"" jk is escape
inoremap jk <esc>

"" quicksave command
noremap  <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
"}}}


" CtrlP settings{{{ 
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"}}}


" File Browsing{{{ 
"" Open NERDTree when no files are specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

"" hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"}}}


" Buffer Navigation{{{ 
"" Ctrl Left/h & Right/l cycle between buffers
noremap <silent> <C-left> :bprev<CR>
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-right> :bnext<CR>
noremap <silent> <C-l> :bnext<CR>

"" <Leader>q Closes the current buffer
nnoremap <silent> <Leader>q :Bclose<CR>

"" <Leader>Q Closes the current window
nnoremap <silent> <Leader>Q <C-w>c
"}}}


" Commenting blocks of code{{{
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
"}}}


" Backups{{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
"}}} 


" Git  Integration{{{


"}}}
"
" Lively Previewing LaTeX PDF Output{{{

let g:livepreview_previewer = 'zathura'

"}}}


" Match Valid Ip A ddress {{{
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier

"}}}

"  PEP8 {{{
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
"}}}


" Vim-Notes {{{
  let g:notes_directories = ['~/Documents/Notes']
"}}}

let g:easytags_suppress_ctags_warning = 1

" Python/Django  IDE Setup{{{
"" enable all Python syntax highlighting feautures
let python_highlight_all = 1

"" Python-mode
"Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes, pep8"
let g:pymode_lint_write = 1
"Support virtualenv
let g:pymode_virtualenv = 1
"syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"Don't autofold code
let g:pymode_folding = 0
let g:pymode_rope_lookup_project = 0

"" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1       " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1                   " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1              " Completion for programming language's keyword
let g:ycm_complete_in_comments = 0                      " Completion in comments
let g:ycm_complete_in_strings = 0                       " Completion in string
let g:ycm_global_ycm_extra_conf = '~/Code/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python2.7'
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"" Ultisnips.vim
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>"

" Java IDE Settings{{{

let g:EclimCompletionMethod = 'omnifunc'
 
"}}}

" Enabling transpacency for gruvbox
"hi NonText ctermbg=NONE 
"hi Normal guibg=NONE ctermbg=NONE

" Organization{{{
set modelines=1
" vim:foldmethod=marker:foldlevel=0
