" Turn filetype off so we can force-reload ftdetect files after pathogen loads.
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" Automatically re-read files that were changed outside of vim.
set autoread

" from http://b4winckler.wordpress.com/2009/07/10/a-minimal-vim-configuration/
set nocompatible
set backspace=indent,eol,start
syntax on

set noerrorbells

set linebreak " soft-wrap at word boundaries

" highlight searches and make them case insensetive if no caps are used
set hls is ic scs

set ruler

set nobackup
set noswapfile
set fileformats=unix,dos,mac " support all three, in this order

" Use 4 spaces for indentation and replace tabs with spaces in a smart way
set shiftwidth=4 softtabstop=4 expandtab
set tabstop=4

" Auto-wrap comments at 79 chars.
set formatoptions=qcr
set textwidth=79

set hidden " don't lose buffer history when one isn't showing in a window

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bindings

nnoremap <Leader>s :OpenSession!<cr>
nnoremap <Leader>eb :OpenSession! everyblock<cr>
nnoremap <leader>a :Ack <cword><cr>

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>tf :CommandTFlush<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" restrict session options so most things will just be read from .vimrc
set sessionoptions=blank,buffers,curdir,help,resize,tabpages,winsize

set wildmode=longest,list
set suffixes+=.pyc
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.beam

set list

autocmd FileType html,htmldjango,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType html,htmldjango setlocal noautoindent nosmartindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-session https://github.com/xolox/vim-session

let g:session_autoload='no'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer

let g:bufExplorerSortBy='mru'
let g:bufExplorerFindActive=1         " Open the selected buffer in the current window.
let g:bufExplorerShowTabBuffer = 0    " Only show buffers open in the current tab page.
let g:bufExplorerShowDirectories = 0  " Don't show directories. e.g. `:e somedir`.
let g:bufExplorerShowRelativePath = 1 " Show relative paths.
let g:bufExplorerSplitOutPathName = 1 " Don't split the path and filename.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree

nnoremap <Leader>nt :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1 " Close the NERD_tree window when a file is selected.
let NERDTreeHijackNetrw = 0 " Don't hijack netrw for exploring the local filesystem.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist

nnoremap <Leader>tl :TlistToggle<Enter>
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_One_File = 1           " Only show the tags for the current buffer.
let Tlist_Close_On_Select = 1         " Close the Tlist window when a tag is selected.
let Tlist_Process_File_Always = 1     " Process tags even when Tlist is not open.
let Tlist_GainFocus_On_ToggleOpen = 1 " Give the Tlist window focus on :TlistToggle.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
" https://github.com/majutsushi/tagbar

nnoremap <Leader>tb :TagbarToggle<Enter>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" statusline 
" mostly from http://github.com/scrooloose/vimfiles/blob/master/vimrc

set laststatus=2        "always show the statusline
set statusline=%f       "tail of the filename
 
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
 
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
 
set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

set statusline+=%=      "left/right separator

set statusline+=%<%=%([%{Tlist_Get_Tagname_By_Line()}]\ %)
set statusline+=%c:     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://blog.golden-ratio.net/2008/08/19/using-tabs-in-vim/

function! GuiTabLabel()
    " add the tab number
    let label = '['.tabpagenr()

    " modified since the last save?
    let buflist = tabpagebuflist(v:lnum)
    for bufnr in buflist
        if getbufvar(bufnr, '&modified')
            let label .= '*'
            break
        endif
    endfor

    " count number of open windows in the tab
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= ', '.wincount
    endif
    let label .= '] '

    " add the file name without path information
    let n = bufname(buflist[tabpagewinnr(v:lnum) - 1])
    let label .= fnamemodify(n, ':t')

    return label
endfunction

set guitablabel=%{GuiTabLabel()}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/shawncplus/dotfiles/blob/master/.vimrc#L388
" Auto-create any needed directories when writing a new file.

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call mkdir(required_dir, 'p')
    endif
endfunction

augroup AutoMkdir
    autocmd!
    autocmd  BufWritePre  *  :call EnsureDirExists()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
"
let g:python_highlight_all=1

" Save as sudo
cnoremap w!! %!sudo tee > /dev/null %

noremap <Leader>f :Ack<space>
noremap <Leader>gx :!gitx .<CR><CR>

" Use buffkill.vim for bd
cnoremap bd :BD
