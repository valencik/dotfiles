execute pathogen#infect()

set number
set relativenumber

" Setup tags
set tags=./tags,tags,.git/tags;

" Enable fzf in vim
set rtp+=/usr/local/opt/fzf

" Autowrap git commit messages to 72 characters
au FileType gitcommit setlocal tw=72

" enable mouse support past the 220th column
set ttymouse=sgr

" Deal with Ruby
" https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
if v:version >= 703
  " Note: Relative number is quite slow with Ruby, so is cursorline
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline
else
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 re=1 foldmethod=manual
endif
