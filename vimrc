" Getting vim to work the way I want
" Author: Henry Addo <henry@addhen.org>
" This setups up Vundle for easier management of vim plugins
" Follow the instructions below to setup Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this lin

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

set clipboard=unnamed        "Copy stuff to the system clipboard instead of the vim buffer"
