" vim: set foldenable foldlevel=1 nospell:
" File:          ~/.config/nvim/config/options.vim
" Author:        Henry Addo <henry@addhen.org>
" Description:   The core of my configuration.
" Setup:         ln -s tools/config/nvim/config/options.vimrc ~/.config/nvim/config/options.vimrc
" Last Modified: 01-03-2017 11:50:43 JST
"

 let mapleader="\<SPACE>" " Map the leader key to ,

" General {
  set smartindent        " Make smart indentations.
  set ttimeout
  set ttimeoutlen=100
" }

" Search {
  set ignorecase            " Make searching case insensitive
  set smartcase             " ... unless the query has capital letters.
  set gdefault              " Use 'g' flag by default with :s/foo/bar/.
  set magic                 " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
  endif
" }

"
" Formatting {
  set encoding=utf-8          " UTF-8 NWA style.
  set termguicolors           " Enable terminal true colors.
  set showcmd                 " Show partial command in status line.
  set ruler                   " Show the line and column numbers of the cursor.
  set number                  " Show line numbers on the left side.
  set formatoptions+=o        " Continue comment marker in new lines.
  set textwidth=100             " Hard-wrap long lines as you type them.
  set expandtab               " Insert spaces when TAB is pressed.
  set tabstop=2               " Render TABs using this many spaces.
  set shiftwidth=2            " Indentation amount for < and > commands.

  set noerrorbells            " No beeps.
  set modeline                " Enable modeline.
  set esckeys                 " Cursor keys in insert mode.
  set linespace=0             " Set line-spacing to minimum.
  set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)

  " More natural splits
  set splitbelow              " Horizontal split below current.
  set splitright              " Vertical split to right of current.

  if !&scrolloff
    set scrolloff=3           " Show next 3 lines while scrolling.
  endif
  if !&sidescrolloff
    set sidescrolloff=5       " Show next 5 columns while side-scrolling.
  endif
  set nostartofline           " Do not jump to first character with page commands.

  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  set listchars=tab:»-,trail:.,extends:>,precedes:<,nbsp:+
  set list                    " Show problematic characters.
" }
"
" Configuration {
  set autochdir               " Switch to current file's parent directory.

  " Remove special characters for filename
  set isfname-=:
  set isfname-==
  set isfname-=+
  set nobackup noswapfile     " Don't create swap files 
  set undofile undodir=~/.config/nvim/undodir
  set diffopt+=iwhite         " Show diff with white color
  " Map ; to :
  nnoremap ; :

  if &undolevels < 200
    set undolevels=200        " Number of undo levels.
  endif

  " Path/file expansion in colon-mode.
  set wildmode=list:longest
  set wildchar=<TAB>
  " Also highlight all tabs and trailing whitespace characters.
  "highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  "match ExtraWhitespace /\s\+$\|\t/
  set clipboard=unnamed         " Copy to system clipboard when you yank
  set showbreak=↪\              " Show this character when the line wraps. Note the trailing space (escaped with a backslash) because this character is wider than 1 normal character
  set updatetime=100            " Fixes issue with highlighting current word being too slow
  setlocal conceallevel=0       " Fixes issue with json files hiding quotes
  " Turn on spell checking for commit messages and automatic wrapping at the recommended 72 characters
  augroup filetype_gitcommit
    autocmd!
    autocmd Filetype gitcommit setlocal spell textwidth=72
  augroup END

  " Turn on spell checking for markdown files
  augroup filetype_markdown
    autocmd!
    autocmd Filetype markdown setlocal spell
  augroup END
" }
"
" Neomake {
  autocmd! BufWritePost * Neomake
  nnoremap <Leader>l :lopen<CR>

  let g:netrw_liststyle=3 " tree (change to 0 for thin)
  let g:netrw_banner=0    " no banner
  let g:netrw_altv=1      " open files on right
  let g:netrw_winsize=80  " only use 20% screen for netrw
  let g:netrw_preview=1   " open previews vertically
" }
"
" vim:set ft=vim sw=2 ts=2:
