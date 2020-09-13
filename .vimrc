" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Define plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
Plug 'edwinb/idris2-vim'
call plug#end()

" Set local leader to "\\"
let maplocalleader="\\\\"

set number
set relativenumber

" set background colour of folds
highlight Folded ctermbg=DarkGrey

" Setup tags
set tags=./tags,tags,.git/tags;

" Enable fzf in vim
" set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :!tmux send-keys -t 0.1 'dev test' C-m<CR><CR>
nmap <Leader>g :GFiles<CR>

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

" Command for rg grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --ignore-case --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <Leader>f :Rg<space>
