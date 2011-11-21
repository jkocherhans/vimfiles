if has("gui_macvim")
    " Map cmd-d to :CommandT
    noremap <D-d> :CommandT<CR>
    inoremap <D-d> <Esc>:CommandT<CR>

    " Exit insert mode before saving with cmd-s
    iunmenu File.Save
    imenu <silent> File.Save <Esc>:if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>

    " Stop the middle mouse button from pasting
    map <MiddleMouse> <Nop>
    imap <MiddleMouse> <Nop>

    set number
    " clear the current search highlighting in insert mode
    nnoremap <silent> <esc> :noh<CR>

    set bg=dark
    colorscheme vilight
    set guifont=Inconsolata:h11
    set linespace=1     " Extra space between lines
    set go-=T           " hide the toolbar (MacVim)
    set guioptions=eg   " turn off scrollbars
    set lines=60
    set columns=110
    set fuoptions=maxhorz,maxvert " use full width/height in fullscreen mode
    set cursorline
    set gcr=n:blinkon0  " don't blink in normal mode

    set listchars=tab:‣\ ,eol:¬,trail:· " show tabs, trailing whitespace, and linebreaks similar to TextMate
endif
