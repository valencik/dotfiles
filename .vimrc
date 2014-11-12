set nocompatible        " Use Vim defaults (much better!)
set backspace=indent,eol,start "allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Turn syntax and line number on
syntax on
set number

" Force markdown hilighting on *.md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
