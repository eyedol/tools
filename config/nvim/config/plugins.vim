" vim: set foldenable foldlevel=1 nospell:
" File:          ~/.config/nvim/config/plugins.vim
" Author:        Henry Addo <henry@addhen.org>
" Description:   The core of my configuration.
" Setup:         ln -s tools/config/nvim/config/plugins.vimrc ~/.config/nvim/config/plugins.vimrc
" Last Modified: 01-03-2017 11:50:43 JST
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
