" Expand tabs to four spaces
set expandtab
set tabstop=4 
set shiftwidth=4 
set autoindent
" set smartindent

" Line numbers
set nu

" Relative line numbers
" set rnu

" Set 7 lines to the cursor when scrolling with j/k
" set so=7

" Turn on the Wild menu (tab auto-complete in command interface)
set wildmenu

" Always show ruler
set ruler

" Sets hidden so files can be hidden instead of closed when opening another
" file and current changes has not been written yet
set hidden

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases. I.e., when a pattern contains
" an uppercase letter it's included in the search, but when it's only lowercase
" ignorecase is active
set smartcase

" Highlight search results
set hlsearch
hi Search ctermfg=Black ctermbg=LightGray
nmap <F9> :nohlsearch<CR>

" Move to search results when typing search pattern
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Enable syntax highlighting
syntax enable

" Always show the status line
set laststatus=2

" Format status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Syntax highlighting of ROS launch files
" Ref: https://stackoverflow.com/a/28117335/3723378
au BufRead,BufNewFile *.launch set filetype=xml

" Remaps pressing j and k in quick succession to be the same as escape
imap jk <ESC>

" Enable mouse mode 
set mouse=a
