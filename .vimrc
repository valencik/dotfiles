" Use Vim defaults (much better!)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" read/write a .viminfo file, don't store more than 50 lines of registers
set viminfo='20,\"50

" keep 50 lines of command line history
set history=500

" show the cursor position all the time
set ruler

" Turn syntax and line number on
syntax on
set number
set relativenumber

" Set list characters for viewing whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Force markdown hilighting on *.md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Custom colouring of makeshift comments in MD files
highlight PandocComment ctermbg=NONE ctermfg=blue
match PandocComment /^%- .*$/

" fzf
set rtp+=/usr/local/opt/fzf

" Autowrap git commit messages to 72 characters
au FileType gitcommit setlocal tw=72

" python settings
set shiftwidth=4
set tabstop=4
set expandtab
filetype plugin on
"filetype indent on

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'ensime/ensime-vim'

" Initialize plugin system
call plug#end()

" Typecheck after writing
autocmd BufWritePost *.scala silent :EnTypeCheck

" Unmap space and then set as leader
"nnoremap <Space> <nop>
let maplocalleader=" "
autocmd FileType scala,java
          \ nnoremap <buffer> <silent> <LocalLeader>t :EnType<CR> |
          \ nnoremap <buffer> <silent> <LocalLeader>T :EnTypeCheck<CR> |
          \ nnoremap <LocalLeader>df :EnDeclaration<CR>
