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
