if has("gui_macvim")
  " Remap cmt-t to :CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>

  " Exit insert mode before saving with cmd-s
  iunmenu File.Save
  imenu <silent> File.Save <Esc>:if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>

  " Stop the middle mouse button from pasting
  map <MiddleMouse> <Nop>
  imap <MiddleMouse> <Nop>
endif
