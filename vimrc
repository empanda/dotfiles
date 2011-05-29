" vimrc

" turn off compatibility with vi
set nocompatible

" Loading
" -------
" see http://www.vim.org/scripts/script.php?script_id=2332
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" Filetype
" --------
" turn on filetype detection
filetype on

" turn on filetype indenting
filetype plugin indent on

" Django HTML
function! s:SelectHTML()
    let n = 1
    while n < 50 && n < line("$")
        " check for django
        if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
            set ft=htmldjango
            return
        endif
        let n = n + 1
    endwhile
    " go with html
    set ft=html
endfunction


" Auto Commands
" -------------
if has("autocmd")
    " do syntax highlight syncing from the start
    autocmd BufEnter * :syntax sync fromstart
    
    " allow the edit command to make any needed directories
    "autocmd BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')

    " setup javascript and json files to the correct vim settings 
    autocmd BufRead,BufNewFile *.{js,json} set filetype=javascript

    " test to see if html is Django HTML or just plain HTML
    autocmd BufNewFile,BufRead *.html call s:SelectHTML()
endif


" Basic Settings
" --------------
" set the <leader> key to ,
let mapleader = ","
let g:mapleader = ","

" allow for hidden buffers
set hidden

" turn off modeline for security reasons
set nomodeline

" set the default encoding
set encoding=utf-8

" set the title of the window
set title
set titlestring=%f%(\ [%M]%)

" turn on enhanced menus
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.pyc,*.pyo,CVS,.svn,.git,.*mo,.DS_Store,*.pt.cache,*.Python,*.o,*.lo,*.la,*~

" turn off backup and swap files
set nobackup
set noswapfile

" hide the backup and swap files
set backupdir=~/.backup/vim,/tmp,.
set directory=~/.backup/vim/swap,/tmp,.
set backupskip=/tmp/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

" setup toggle for spell checking
map <silent> <leader>s :set spell!<CR>
set nospell

" turn on smart indenting
set autoindent
set smartindent

" set spaces instead of tabs
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

" show matching parenthese and bracket
set showmatch

" increase history length
set history=1000

" show incomplete command in the lower right corner of the window
set showcmd

" prefer unix over windows over OS9 formats
set fileformats=unix,dos,mac

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


" Searhcing
" ---------
" find as you type
set incsearch

" highlight search terms
set hlsearch

" make searches case-insensitive
set ignorecase

" make searches case-sensitive if they contain upper-case letters
set smartcase

" a toggle for search highlight
map <silent> <leader>H :set hlsearch!<CR>

" shortcut to clear search pattern
map <silent> <leader>h :let @/ = ""<CR>

" use normal regex when searching
nnoremap / /\v
vnoremap / /\v

" subsitute the whole file by default
set gdefault


" Display Settings
" ----------------
" turn syntax highlighting on
syntax on

" gui and terminal compatible color scheme
set t_Co=256
set background=dark

" set the colorscheme
colorscheme wombat

" highlight the cursor line
set cursorline

" turn on line numbers
set number

" turn on the column ruler
set ruler

" toggle for line numbers
map <silent> <leader>n :set number!<CR>

" don't have the curors at the botom
set scrolloff=4

" lines to scroll when cursor leaves screen
set scrolljump=0

" set the satus line up
set statusline=\ \ \ \ \ line:%l\ column:%c\ \ \ %M%Y%r%=%-14.(%t%)\ %p%%

" show the statueline in all windows
set laststatus=2

" set all window splits equal
set noequalalways

" have the mouse enabled at all times
set mouse=a

" make the menu popup on right click
set mousemodel=popup

" show invisible characters
set listchars=eol:¬,tab:»\ 
set nolist

" toggle invisible characters
noremap <silent> <leader>i :set list!<CR>

" tell vim we have a fast connection for smoother redraws
set ttyfast

" don't blink or bell
set noerrorbells
set vb t_vb=


" Movement Settings
" -----------------
" quicker window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" tab to switch between open and close brackets or tags
nnoremap <tab> %
vnoremap <tab> %


" Vim Key Mappings
" ----------------
" quit window
nnoremap <leader>q :q<CR>

" set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" easy switching between filetypes
nnoremap <leader>th :set filetype=htmldjango<CR>
nnoremap <leader>tp :set filetype=python<CR>
nnoremap <leader>tj :set filetype=javascript<CR>
nnoremap <leader>tr :set filetype=rst<CR>

" ; is an alias for :
nnoremap ; :

" using textmate style indentation commands
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" turn off smart indentation when pasting
set pastetoggle=<F2>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


" GUI Settings
" ------------
if has("gui_running")
    " turn off the gui elements
    set guioptions=

    " turn off the cursor blinking (who thinks that is a good idea?)
    set guicursor+=a:blinkon0


    " Mac OS X Specific
    if has("gui_macvim")
        " using the entire screen for VIM
        set fuoptions=maxhorz,maxvert
        
        " set the font
        set guifont=Inconsolata:h18

        " set transparency
        set transparency=2
    endif
endif


" NERDTree Settings
" -----------------
" toggle the NERDTree
map <leader>x :NERDTreeToggle<CR>

" Include NERDTree Config
if filereadable(expand("~/.vim/nerdtree.conf.vim"))
    source ~/.vim/nerdtree.conf.vim
endif


" NERDCommenter Settings
" ----------------------
" toggle the commentedness of the line(s)
map <D-/> <plug>NERDCommenterToggle<CR>

" Ack Settings
" ------------
" shortcut for ack serach
map <leader>a :Ack<Space>


" Filetype Settings
" -----------------
" Python
let python_highlight_all=1

" Javascript
let javascript_enable_domhtmlcss=1



if has("autocmd")

    " reStructuredText
    autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 formatoptions+=nqt textwidth=74

    " Javascript
    autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " HTML
    autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " CSS
    autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    
endif

" ZoomWin Settings
" ----------------
map <Leader>z :ZoomWin<CR>


" Command-T Settings
" ------------------
" mapping for command-t
nnoremap <leader>o :CommandT<CR>
