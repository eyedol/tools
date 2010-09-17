"Getting vim to work the way I want"
" Aurthor: Henry Addo <henry@addhen.org>"

set nocompatible              "don't need to keep compatibility with Vi
set background=dark           "make vim use colors that look good on a dark background

if has("gui_running")
   colorscheme torte             "pretty!
end
"else
 " colorscheme jaf_cli         "use a colorscheme that's cli friendly
"end

syntax on                     "turn on syntax highlighting

set showcmd                   "show incomplete cmds down the bottom
set showmode                  "show current mode down the bottom

set incsearch                 "find the next match as we type the search
set hlsearch                  "hilight searches by default

set nowrap                    "dont wrap lines
set linebreak                 "wrap lines at convenient points

set shiftwidth=4              "number of spaces to use in each autoindent step
set tabstop=4                 "two tab spaces
set softtabstop=4             "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                 "spaces instead of tabs for better cross-editor compatibility
set autoindent                "keep the indent when creating a new line
set smarttab                  "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                   "recommended seting for automatic C-style indentation
set autoindent                "automatic indentation in non-C files
set wrap                      "wrap entire words, don't break them; much easier to read!

set hidden                    "allow hiding buffers with unsaved changes

set number                    "show line numbers"
