" vim: set foldenable foldlevel=1 nospell:
" File:          ~/.config/nvim/config/init.vim
" Author:        Henry Addo <henry@addhen.org>
" Description:   The core of my configuration.
" Setup:         ln -s tools/config/nvim/config/init.vimrc ~/.config/nvim/config/init.vimrc
" Last Modified: 01-03-2017 11:50:43 JST
"
call plug#begin('~/.config/nvim/plugged')

" Show git status in the gutter
Plug 'airblade/vim-gitgutter'
" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'qrps/lilypond-vim', { 'for': 'lilypond' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'mxw/vim-jsx'

" Completion
Plug 'mattn/emmet-vim', { 'for': 'html' }

" Make % match xml tags
Plug 'edsono/vim-matchit', { 'for': ['html', 'xml'] }

" Make tab handle all completions
Plug 'ervandew/supertab'

" Syntastic: Code linting errors
Plug 'scrooloose/syntastic'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Fancy statusline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Make is a code linting tool that runs in the background.
Plug 'neomake/neomake'

" Fuzzy file opener
Plug 'ctrlpvim/ctrlp.vim'

" Open from quick-fix-list in new split
Plug 'yssl/QFEnter'

" Respect .editorconfig files. (http://editorconfig.org/)
Plug 'editorconfig/editorconfig-vim'

" Rename/remove files from within vim
Plug 'tpope/vim-eunuch'

" Make commenting easier
Plug 'tpope/vim-commentary'

" Navigate files in a sidebar
Plug 'scrooloose/nerdtree'

" Track time spent coding
Plug 'wakatime/vim-wakatime'

filetype plugin indent on                   " required!
call plug#end()