if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.arb		setfiletype ruby " ActiveAdmin
augroup END
