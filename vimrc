" Vimrc. 
"
" Helpful links:
"
"   * http://vimdoc.sourceforge.net/htmldoc/options.html
"   * http://amix.dk/vim/vimrc.html

"--- Meta ---"

" Clear all autocommands! (this comment must be on its own line)
autocmd!

" Enable vim to be non-compatible with vi.
" This is at the start of our vimrc file because
" this setting can affect lots of other options.
set nocompatible

" Use Unix as the standard file type, and enable the others.
set fileformats=unix,dos,mac    

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Don't use or save viminfo files
set viminfo=                    
    
"--- Display ---"

" Set the number of columns used on the screen.
set columns=80          

" Set the number of characters from the right window border where wrapping starts.
set wrapmargin=8        

" Keep at least 5 lines of context above/below our scrolling.
set scrolloff=5         

" Keep at least 5 lines of context left/right of our scrolling.
set sidescrolloff=5     

" Show the ruler that shows the current row and column
" at the bottom right of the screen.
set ruler

" Show what mode we're in.
set showmode

" Don't update the display while executing macros.
set lazyredraw

" linebreak: if on Vim will wrap long lines at a character in 'breakat' 
" rather than at the last character that fits on the screen.  
"
" This only  affects the way the file is displayed, not its contents. 
" This is unnlike 'wrapmargin' and 'textwidth', which insert <EOL>s.
set linebreak

" When a bracket is inserted, briefly jump to the matching one. 
" The jump is only done if the match can be seen on the screen.
" The time to show the match can be set with 'matchtime'.
set showmatch

" How many tenths of a second to blink when matching brackets.
set matchtime=5                 

" cmdheight: number of screen lines to use for the command-line.  
" More lines helps with avoiding |hit-enter| prompts.
set cmdheight=2

"-- Display Syntax Coloring ---"

"highlight Comment  ctermfg=White ctermbg=DarkGray
"highlight Constant ctermfg=White ctermbg=Blue
"highlight Normal   ctermfg=White ctermbg=Black
"highlight NonText  ctermfg=White ctermbg=Black
"highlight Special  ctermfg=White ctermbg=DarkMagenta
"highlight Cursor   ctermfg=White ctermbg=Green

" Enable syntax highlighting.
syntax on

" Skip syntax coloring on very long lines because the coloring is slow.
"set synmaxcol=2048

" Use colors that look good on a dark background.
"set background=dark     

"--- Display Status ---"

" Always show the status line, even if there is only one window.
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Show (partial) command in status line.
set showcmd             

"--- Wrapping ---"

" We like 80 columns
set textwidth=80                

"  Format options:
"  * t - autowrap to textwidth
"  * c - autowrap comments to textwidth
"  * r - autoinsert comment leader with <Enter>
"  * q - allow formatting of comments with :gq
"  * l - don't format already long lines
set formatoptions=tcrql

"--- Visual Mode Related ---"

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"--- Keystrokes ---"

" Configure backspace so it acts as it should act.
" For details, see :help 'bs' for more details.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set the forward slash to be the slash of note.
" This is really only applicable to Microsoft Windows.
set shellslash

" Press space to clear any message, search highlighting, etc.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>


"--- GUI ---"

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Try to use a mouse in the console.
set mouse=a                    

" Hide the mouse pointer while typing
set mousehide

"--- Hidden ---"

" We want to hide buffers instead of closing them. This enables us to have
" have unwritten changes to a file then open a new file using :e, without 
" being forced to write or undo our changes first. Also, undo buffers 
" and marks are preserved while the buffer is open.
"
" The buffer with unsaved changes can still be accessed by typing :ls and 
" then :b[N], where [N] is the number of a buffer.
"
" The help for :q[uit]! states that it "Does not exit when there changed hidden buffers."
set hidden

"--- Wildmenu ---"

" wildmenu: enable enhanced command-line completion.
" Presumes you have compiled with +wildmenu.  See :help 'wildmenu'
set wildmenu 

" wildmode: the meaning of "set wildmode=list:longest,full" is when 
" you do completion in the command line via tab, these events happen:
"
"   1. on the first tab press, a list of completions will be shown and the
"      command will be completed to the longest common command.
"
"   2. on the second tab press, the wildmenu will show up with all 
"      the completions that were listed before.
"
" To try it, type ":spe" then hit tab once to see 1, twice to see 2.
set wildmode=list:longest 

" Ignore compiled files, temp files, etc.
set wildignore=*.o,*~,*.pyc

"--- Files ---

" Set to auto read when a file is changed from the outside.
set autoread

"--- Filetype ---"

" filetype: vim can detect the type of file that is edited.
" Vim does this by checking the file name and sometimes by
" inspecting the contents of the file for specific text.
"
" If vim is unable to detect the file type, or vim finds the wrong type,
" then we can set the 'filetype' option manually, or add a modeline to 
" our file.  Example for an IDL file: ":set filetype=idl"
filetype on         

" Load filetype-specific plugin files.
filetype plugin on  

" Load filetype-specific indentation files.
filetype indent on  

" Display SCons files wiith Python syntax:
autocmd BufReadPre,BufNewFile SConstruct set filetype=python
autocmd BufReadPre,BufNewFile SConscript set filetype=python

"--- Tabs ---"

" tabstop: tell vim how many columns a tab counts for.
" Linux kernel code expects each tab to be eight columns wide. 
" Visual Studio expects each tab to be four columns wide. 
" This command affects how existing text displays.
set tabstop=2

" expandtab: swhen expandtab is set, hitting Tab in insert mode will 
" produce the appropriate number of spaces.
"set expandtab

" shiftwidth: set shiftwidth to control how many columns text is 
" indented with the reindent operations (<< and >>) and automatic
" C-style indentation. We use 2 columns because we do a lot of Ruby.
set shiftwidth=2

"--- Error bells ---"

" If 'errorbells' is on, any vim error message will try to sound a beep 
" or flash the screen. For example, the command ":set xyz" displays an 
" error message because 'xyz' is not a valid option. 
"
" The 'errorbells' option has no effect on the beeps that Vim makes when an 
" error message is not displayed (e.g. on pressing Esc when in normal mode).
"
" The 'errorbells' option is off by default.
set noerrorbells

" The 'visualbell' (abbreviated as 'vb') option is off by default. If it is 
" on (that is, if :set visualbell is used), Vim will flash its screen instead 
" of sounding a beep (that is, at times when a beep would have occurred, the 
" screen will flash instead).
set visualbell

" The 't_vb' option, by default, is set to a code that causes a screen flash. 
" If 't_vb' is cleared, then vim will never flash the screen. 
" Caution: 't_vb' has to be cleared after the GUI has started.
set t_vb=

"--- Management ---"

" How many history items of ":" commands and previous search patterns to remember.
set history=900

"--- Movement ---"

" Make cursor move as expected with wrapped lines.
"
" Q. Is there a better way to make j/k move as expected with wrapped lines?
"    I don't want to press g every time.
"
" A. nnoremap j gj, etc.
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

"--- Search ---"

" Highlight the searched expressions
set hlsearch                    

" Use incremental search
set incsearch

" Use case-insensitive matching
set ignorecase                  
                   
" Unless there's a capital letter
set smartcase                   

" Search scan wraps around the file
set wrapscan

" For regular expressions turn magic on
set magic

"--- Backup ---"

" Write a backup file before overwriting a file.
set backup

" The backup file will be created in this directory.
" The directory must exist; Vim will not create it for you.
set backupdir=~/.vim_backup

"--- Key bindings ---"

" Remap broken meta-keys that send ^[
for n in range(97,122) " ASCII a-z
    let c = nr2char(n)
    exec "set <M-". c .">=\e". c
    exec "map  \e". c ." <M-". c .">"
    exec "map! \e". c ." <M-". c .">"
endfor

"--- Filetypes ---"

" Vimscript
autocmd FileType vim setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Shell
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Lisp
autocmd Filetype lisp,scheme setlocal equalprg=~/.vim/bin/lispindent.lisp expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" PHP
autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" HTML, XHTML, XML
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" JavaScript
autocmd BufRead,BufNewFile *.json setfiletype javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let javascript_enable_domhtmlcss=1

"--- Movement ---"

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"--- Closing ---"

" Turn off all coloring
syntax off
set nohlsearch
set noincsearch
set t_Co=0
filetype off
