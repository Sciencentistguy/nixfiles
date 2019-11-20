"""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'junegunn/fzf'                   " Fuzzy finder
Plug 'vim-airline/vim-airline'        " Fancy statusline
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'chrisbra/csv.vim'               " CSV file specific commands
Plug 'lervag/vimtex'                  " LaTeX support
Plug 'Townk/vim-autoclose'            " Automatically close ( { [ etc
Plug 'godlygeek/tabular'              " Align stuff
Plug 'plasticboy/vim-markdown'        " Markdown support
Plug 'mattn/emmet-vim'                " Emmet-style abbreviation expansion
Plug 'sheerun/vim-polyglot'           " Language profiles (syntax highlighting)
Plug 'tpope/vim-fugitive'             " Git integration
Plug 'tpope/vim-unimpaired'           " Miscellaneous mappings
Plug 'wellle/tmux-complete.vim'       " Use words in adjacent tmux panes as a completion source
Plug 'Chiel92/vim-autoformat'         " Autoformatter
Plug 'majutsushi/tagbar'              " Tagbar
Plug '907th/vim-auto-save'            " Autosave
Plug 'francoiscabrol/ranger.vim'      " Open ranger if you accidently vim a directory
Plug 'rbgrouleff/bclose.vim'          " Close buffers without closing the window
Plug 'edkolev/tmuxline.vim'           " Format tmux's statusbar to look like airline
Plug 'dylanaraps/wal.vim'             " Support for Wal colorschemes
Plug 'mbbill/undotree'                " A nice undo-tree viewer
Plug 'tpope/vim-surround'             " Surround text with arbitrary characters
Plug 'tpope/vim-git'                  " Filetype plugin for git files
Plug 'neoclide/coc-neco'              " Viml completion source for coc.nvim
Plug 'airblade/vim-gitgutter'         " Git diff tracker for airline

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " Hugely powerful LanguageServer/Completion/Syntax/EverythingElse plugin

call plug#end()


"""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Colorscheme
if isdirectory(expand("~/.cache/wal"))
    colorscheme wal
else
    colorscheme desert
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" :Q mapped to :q
command Q q

" VIM user interface
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in git etc anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai
set si
set wrap

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

function! ToggleMouse()
    if &mouse == 'nv'
        setlocal mouse=
    else
        setlocal mouse=nv
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""
" Misc Maps
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F3> :Autoformat<cr>
nnoremap <F4> :TagbarToggle<cr>
nnoremap <F5> :UndotreeToggle<cr>:UndotreeFocus<cr>
noremap <Up> <NOP>
noremap <Left> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
noremap q: <NOP>
noremap q/ <NOP>
noremap q? <NOP>
noremap K <NOP>
noremap Q <NOP>
noremap <F1> <NOP>
noremap ¬¬ ZZ

" Make s act like d but it doesn't cut the text to a register
nnoremap s "_d
nnoremap ss "_dd
nnoremap S "_D

" Make j and k move by wrapped line, apart from when it'd break things
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<c-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Move a line of text using CTRL+ALT+[j/k]
nmap <c-m-j> mz:m+<cr>`z
nmap <c-m-k> mz:m-2<cr>`z
vmap <c-m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Remap VIM 0 to first non-blank character
map 0 ^

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Spelling shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <c-j> <c-W>j
map <c-k> <c-W>k
map <c-h> <c-W>h
map <c-l> <c-W>l

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Move between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Use ,tm to toggle mouse support
nnoremap <leader>tm :call ToggleMouse()<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Make curly brackets not stupid
inoremap {<cr> {<cr>}<c-o><s-o>


"""""""""""""""""""""""""""""""""""""""
" Misc Sets
"""""""""""""""""""""""""""""""""""""""
" Spelllang English
set spelllang=en_gb

" Enable neovim's inccommand feature
set inccommand=nosplit

" Set spellcheck on for *.tex files
au FileType tex setlocal spell

" Conceal level 2
set conceallevel=2

" Don't conceal in LaTeX
let g:tex_conceal = ""

" Autosave
let g:auto_save = 0
augroup ft_latex
    au!
    au FileType tex let b:auto_save = 1
augroup END
let g:auto_save_events = ["InsertLeave", "TextChanged"]


"""""""""""""""""""""""""""""""""""""""
" Plugin Options
"""""""""""""""""""""""""""""""""""""""
""" Coc.nvim
" Run snippets in visual mode with <tab>
vnoremap <tab> <Plug>(coc-snippets-select)

" Rebind vim's code navigations keys to use coc's functions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Other misc coc function bindings
nnoremap <silent> K :call <SID>show_documentation()<cr>

" Make <tab> and <s-tab> work like in vscode
inoremap <silent><expr> <tab>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
            \ <SID>check_back_space() ? "\<tab>" :
            \ coc#refresh()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Snippet "next" keybind
let g:coc_snippet_next = '<tab>'

" coc functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


""" Polyglot
" Disable polyglot for everything it will conflict on
let g:polyglot_disabled = ['py', 'markdown', 'latex']


""" Airline
" Enable powerline fonts to use pointy airline separators
let g:airline_powerline_fonts = 1

" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" Set theme
let g:airline_theme='badwolf'

" Format airline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'


""" Vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1

""" Vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : '/tmp/latex',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'Citation %.%# undefined'."\n".
            \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8

""" Autoformat
" Specify astyle commands for c/++ and java
let g:formatdef_astyle_c = '"astyle --mode=c -A2 -F -xg -H -U -xe -k1 -W1 -xb -xf -xh -c -xp -p -C -S -N 2>/dev/null"'
let g:formatdef_astyle_java = '"astyle --mode=java -A2 -F -xg -H -U -xe -k1 -W3 -xb -xf -xh -c -xp -p -C -S -N 2>/dev/null"'

" Specify custom formatters
let g:formatters_c = ['astyle_c']
let g:formatters_cpp = ['astyle_c']
let g:formatters_java = ['astyle_java']

" Autoformat on write
au BufWrite * :Autoformat

""" Ranger.vim
let g:ranger_replace_netrw = 1
