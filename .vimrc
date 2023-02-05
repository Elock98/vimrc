"-------------------------------------------------------------------------------
"   Vim Plugins
"-------------------------------------------------------------------------------
    call plug#begin('~/.vim/plugged')

        " Markdown Preview plugin
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

        " NerdTree plugin
        Plug 'preservim/nerdtree'

        " Git for NerdTree
        Plug 'Xuyuanp/nerdtree-git-plugin'

        " Icons for NerdTree
        Plug 'ryanoasis/vim-devicons'

        " GoYo Distraction-free Writing
        Plug 'junegunn/goyo.vim'

        " Fuzzy Files
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'airblade/vim-rooter'

    call plug#end()

    let NERDTreeShowHidden=1 " NerdTree will show hidden files
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Remaps leader
"-------------------------------------------------------------------------------
    let mapleader = "\<Space>"
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Key-Mapping
"-------------------------------------------------------------------------------
    set timeoutlen=250  " Setting timeout delay

    " Remapping ESC to jk in insert mode
    inoremap jk <esc><left><left>

    " Remapping ESC to jk in visual mode
    vnoremap jk <esc><left><left>

    " Remapping Ctrl-C to jk in command mode
    cnoremap jk <C-C>

    " Remapping toggle fold to tab key
    nnoremap <tab> za

    " Vertical split using <space>v
    nnoremap <leader>v :vsplit<CR>

    " Horizontal split using <space>h
    nnoremap <leader>h :split<CR>

    " Swap to next split window using <space>w
    nnoremap <leader>w <C-w>w

    " Create new empty tab
    nnoremap <leader>t :tabnew<CR>

    " Close the current tab
    nnoremap <leader>c :tabclose<CR>

    " Moves to the previous tab
    nnoremap <leader>j :tabpre<CR>

    " Moves to the next tab
    nnoremap <leader>k :tabnext<CR>

    " Open NerdTree with <space>n
    nnoremap <leader>n :NERDTreeFocus<CR>

    " Remap % to <space>m
    nnoremap <leader>m %

    " Remap $ to <space>e
    nnoremap <leader>e $

    " Use <space>s to get into line substitute fast
    nnoremap <leader>s :s//g<left><left>

    " Use <space>a to get into global substitute fast
    nnoremap <leader>a :%s//g<left><left>

    " Activate markdown preview using <ctrl>m
    nnoremap <C-m> :MarkdownPreview<CR>

    " Toggle Goyo mode using <ctrl>g
    nnoremap <C-g> :Goyo<CR>

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
"   Allow for running powershell functions, remove if not on windows
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
    colorscheme evening
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set cursor style
"-------------------------------------------------------------------------------
    let &t_SI.="\e[5 q" " Set blinking vartical bar
    let &t_SR.="\e[4 q" " Set solid underscore
    let &t_EI.="\e[1 q" " Set blinking block
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

    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set syntax highlight
"-------------------------------------------------------------------------------
    syntax on
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Search highlight
"-------------------------------------------------------------------------------
    set hlsearch " Highlight search

    set incsearch " Incremental search

    set ignorecase  " Be case insensitive

    set smartcase   " Be case sensitive if caps used
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Folds
"-------------------------------------------------------------------------------
    set foldmethod=manual
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Handle make and load view (folds)
"-------------------------------------------------------------------------------
    augroup AutoSaveFolds
        autocmd!
        autocmd BufWinLeave,BufWrite * if CanLoadView() == 1 | mkview | endif
        autocmd BufWinEnter * if CanLoadView() == 1 | silent loadview | endif
    augroup END
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Handle folds when using tabs
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
        " If the file can load
        return 1
    endfunction
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Set split direction
"-------------------------------------------------------------------------------
    set splitbelow " Horizontal split
    set splitright " Vertical split
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"   Silence bells
"-------------------------------------------------------------------------------
    set belloff=all
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

" white behind path and modified flag
hi User1 ctermfg=000 ctermbg=007 guibg=#4e4e4e guifg=#adadad
" central red
hi User2 ctermfg=000 ctermbg=007 guibg=#708090 guifg=#708090
" red behind splitters
hi User3 ctermfg=008 ctermbg=007 guibg=#708090 guifg=#708090
"--------------------------------------------------------------------------------------------------------------------
