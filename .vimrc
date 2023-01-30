"-------------------------------------------------------------------------------
"   Vim Plugins
"-------------------------------------------------------------------------------
    call plug#begin('~/.vim/plugged')

        " Markdown Preview plugin
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    call plug#end()
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set tab size to 4
"-------------------------------------------------------------------------------
    set tabstop=4

    set shiftwidth=4

    set softtabstop=4

    set expandtab
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Allow for running powershell functions
"-------------------------------------------------------------------------------
    set shell=powershell
    set shellcmdflag=-command
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Auto tab
"-------------------------------------------------------------------------------
    set autoindent
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Enable auto complete
"-------------------------------------------------------------------------------
    set wildmode=longest,list,full
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Delete trailing whitespace on write
"-------------------------------------------------------------------------------
    autocmd BufWritePre * %s/\s\+$//e
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
"   Set color scheme
"-------------------------------------------------------------------------------
    colorscheme default
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set cursor color
"-------------------------------------------------------------------------------
    highlight Cursor guifg=orange guibg=orange
"    highlight iCursor guifg=white guibg=steelblue
    set guicursor=n-v-c:block-Cursor
"    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
"    set guicursor+=i:blinkwait10
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set syntax highlight
"-------------------------------------------------------------------------------
    syntax on
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Enable use of backspace and delete
"-------------------------------------------------------------------------------
    set backspace=indent,eol,start
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Show line numbers
"-------------------------------------------------------------------------------
    set number
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Search highlight
"-------------------------------------------------------------------------------
    set hlsearch

    set incsearch

    set ignorecase  " Be case insensitive

    set smartcase   " Be case sensitive if caps used
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Folds
"-------------------------------------------------------------------------------
    set foldmethod=manual
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Key-mapping
"-------------------------------------------------------------------------------
    inoremap jk <esc><left><left>   " Remapping ESC to jk in insert mode
    vnoremap jk <esc><left><left>   " Remapping ESC to jk in visual mode

    cnoremap jk <C-C>   " Remapping Ctrl-C to jk in command mode

    nnoremap <tab> za   " Remapping toggle fold to tab key

    set timeoutlen=250  " Setting timeout delay

    nnoremap tn :tabnew<CR> " Create new empty tab

    nnoremap tk :tabnext<CR> " Move to newxt tab

    nnoremap tj :tabprev<CR> " Move to previous tab
"-------------------------------------------------------------------------------

"--------------------------------------------------------------------------------------------------------------------
"   Setup status bar, based on status bar from: https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641
"--------------------------------------------------------------------------------------------------------------------
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

let g:currentmode={
        \ 'n'  : 'Normal',
        \ 'no' : 'Normal·Operator Pending',
        \ 'v'  : 'Visual',
        \ 'V'  : 'V·Line',
        \ '^V' : 'V·Block',
        \ 's'  : 'Select',
        \ 'S'  : 'S·Line',
        \ '^S' : 'S·Block',
        \ 'i'  : 'Insert',
        \ 'R'  : 'Replace',
        \ 'Rv' : 'V·Replace',
        \ 'c'  : 'Command',
        \ 'cv' : 'Vim Ex',
        \ 'ce' : 'Ex',
        \ 'r'  : 'Prompt',
        \ 'rm' : 'More',
        \ 'r?' : 'Confirm',
        \ '!'  : 'Shell',
        \ 't'  : 'Terminal'
\}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%3*│                                     " Separator
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode

hi User1 ctermfg=000 ctermbg=007 guibg=#4e4e4e guifg=#adadad " white behind path and modified flag
hi User2 ctermfg=000 ctermbg=007 guibg=#708090 guifg=#708090 " central red
hi User3 ctermfg=008 ctermbg=007 guibg=#708090 guifg=#708090 " red behind splitters
"--------------------------------------------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Handle make and load view (folds)
"-------------------------------------------------------------------------------
    augroup AutoSaveFolds
        autocmd!
        autocmd BufWinLeave * mkview
        autocmd BufWinEnter * if CanLoadView() == 1 | silent loadview | endif
    augroup END
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Handle tabs
"-------------------------------------------------------------------------------
    set showtabline=2

    function CanLoadView()
        if @% == ""
            " If no filename
            return 0
        elseif filereadable(@%) == 0
            " If file is not readable
            return 0
        endif

        return 1
    endfunction
"-------------------------------------------------------------------------------
