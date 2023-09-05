" disable default plugins
" Speed up init by disabling unused built-ins.
" Handled by tree-sitter
let g:loaded_matchparen        = 1
" Compressed file editing
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_2html_plugin      = 1
" Script stuff
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
" netrw
" Actual plugin is disabled.
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
" ENABLED. Needed for fugitive for some reason.
" let g:loaded_netrw             = 1
" plug
call plug#begin(stdpath('data') . '/plugged')
" Utilities
Plug 'nvim-lua/plenary.nvim' " Lua utilities
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects' 
" Tools
Plug 'gabrielpoca/replacer.nvim' " <Leader>h in quickfix to modify files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/nvim-hlslens' " more search info
Plug 'mhinz/vim-startify' " <F1>
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ruifm/gitlinker.nvim' " Generate permalinks to source with <leader>gY
Plug 'sindrets/diffview.nvim' " :Diff, :DiffMaster
Plug 'tpope/vim-fugitive' " Vim git integration
Plug 'tommcdo/vim-fubitive' " Fugitive bitbucket integration
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Text manipulation
Plug 'AndrewRadev/splitjoin.vim' " multiline join. gJ to join, gS to split
Plug 'coderifous/textobj-word-column.vim' " ic,ac,iC,aC to manipulate columns
Plug 'junegunn/vim-easy-align' " <visual>ga{char} or ga{textobj}{char} to align around char
Plug 'tpope/vim-abolish' " toggling casing and substitution across cases
Plug 'tpope/vim-commentary' " toggling comments generically across languages
Plug 'tpope/vim-surround' " ysiw{char}
Plug 'wellle/targets.vim' " text objects for separators, quotes, etc.
" Functions, commands, etc.
Plug 'jeanCarloMachado/vim-toop' " Allow sending text objects to vim functions
Plug 'tpope/vim-dispatch' " :Dispatch for async command executor
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands
" Language specific
Plug 'aliou/sql-heredoc.vim' " highlight SQL in Ruby heredocs
Plug 'mogelbrod/vim-jsonpath' " <leader>d to copy path, <leader>j to jump to path
Plug 'RRethy/nvim-treesitter-endwise' " Tree-sitter based `end` insertion
Plug 'tpope/vim-rails' " :Emodel, :Econtroller, :A(lternate), :R(elated)
" Doesn't work with Python 3?
Plug 'windwp/nvim-ts-autotag' " autocomplete HTML/JSX tags
" Visual
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } " nvim scrollbars
Plug 'flazz/vim-colorschemes' " large collection of colorschemes
Plug 'folke/lsp-colors.nvim' " LSP patcher for ANY colorscheme
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'yorickpeterse/nvim-pqf' " Pretty quickfix
" Configs
Plug 'editorconfig/editorconfig-vim'

" This must be at the end, as per docs
Plug 'ryanoasis/vim-devicons' " still used for bufferline and some other stuff
call plug#end()
" installation -- :source % :PlugInstall
" Remember to periodically run:
" :PlugUpdate, :PlugClean
" :TSUpdate for tree-sitter
" :CocUpdate for COC
" 
" Settings 
set mouse=a " enable mouse reporting
set nowrap
set sidescroll=1
set scrolloff=2 " min lines to keep above and below cursor
set updatetime=300 " default is 4000
set backspace=indent,eol,start
set autoread " reload files changed externally
set showcmd " show in progress commands
set laststatus=3 " global statusline
" skip backups and swp
set nobackup
set nowritebackup
set noswapfile
" disable arrow keys -- break bad habits
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
" Give some more memory for regex (default is 1000)
set mmp=5000
" Don't waste time redrawing when running macros etc.
set lazyredraw
" Better handling of movement commands when line wrap
noremap <expr> G &wrap ? "G$g0" : "G"
noremap <expr> 0 &wrap ? 'g0' : '0'
noremap <expr> $ &wrap ? "g$" : "$"
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" Visual mode improvements
" Fixed I/A
xnoremap <expr> I mode() ==# 'v' ? "\<c-v>I" : mode() ==# 'V' ? "\<c-v>^o^I" : "I"
xnoremap <expr> A mode() ==# 'v' ? "\<c-v>A" : mode() ==# 'V' ? "\<c-v>Oo$A" : "A"
" Keep selection when indenting
xnoremap < <gv
xnoremap > >gv
" Paste without overwriting default register (doesn't work with other registers)
xnoremap p pgvy
" Block Ex mode
nnoremap Q <Nop>
" 
" Function keys 
imap <silent> <F1> <Nop>
map <silent> <F1> :Startify<CR>
map <silent> <F2> :bprevious<CR>
map <silent> <F3> :bnext<CR>
" Close the current buffer and show previous without closing split
map <silent> <F4> :bn<bar>sp<bar>bp<bar>bd<CR>
" Close the current buffer and show next without closing split
map <silent> <F5> :bp<bar>sp<bar>bn<bar>bd<CR>
" Close all other buffers
map <silent> <F6> :%bd\|e#\|bd#<CR>
" Use `F7` and `F8` to navigate diagnostics
nmap <silent> <F7> <Plug>(coc-diagnostic-next)
nmap <silent> <F8> <Plug>(coc-diagnostic-prev)
nmap <silent> <F9> <Plug>(coc-diagnostic-info)
nmap <silent> <F10> <Plug>(coc-references)

" 
" Whitespace 
filetype plugin indent on " Indent settings by filetype
set autoindent
set expandtab
set lcs=tab:\»\ ,trail:·,nbsp:·
set list
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Add filetypes where whitespace should be trimmed
autocmd BufWritePre *.md %s/\s\+$//e

" 
" Display 
colorscheme monokai
set termguicolors
set background=dark
set colorcolumn=120
set cursorline
set number relativenumber
set noshowmode " don't show mode -- defer to powerline
set ruler
set title
set signcolumn=yes
set shortmess+=A " ignore .swp files

" enable folding in JSON
autocmd FileType json setl foldmethod=syntax
autocmd FileType yaml setl foldmethod=indent
autocmd FileType json,yaml normal zR

" 
" Custom highlighting 
" From: https://github.com/flazz/vim-colorschemes/blob/master/colors/Monokai.vim
let s:ColorWhite="#f8f8f2"
let s:ColorBlack="#272822"
let s:ColorGray100="#f8f8f0"
let s:ColorGray200="#90908a"
let s:ColorGray300="#75715e"
let s:ColorGray400="#64645e"
let s:ColorGray500="#49483e"
let s:ColorGray600="#3c3d37"
let s:ColorGray700="#31322c"
let s:ColorMagenta="#f92672"
let s:ColorRed="#8b0807"
let s:ColorOrange="#fd971f"
let s:ColorYellow="#e6db74"
let s:ColorGreenLight="#a6e22e"
let s:ColorGreenDark="#46830c"
let s:ColorPurple="#ae81ff"
let s:ColorTeal="#66d9ef"
let s:ColorBlueLight="#204a87"
let s:ColorBlueDark="#243955"

" UI elements
" Popup windows. Does NOT include dropdown dialogs.
execute 'highlight CocFloating guibg='.s:ColorGray700
" Dropdown dialog
execute 'highlight Pmenu guibg='.s:ColorGray700
execute 'highlight PmenuSel guibg='.s:ColorGreenLight.' guifg='.s:ColorBlack
execute 'highlight PmenuSbar guibg='.s:ColorGray700
execute 'highlight PmenuThumb guibg='.s:ColorGray500
" 120 char vertical indicator
execute 'highlight ColorColumn guibg='.s:ColorGray700.' guifg=NONE gui=NONE'
" horizontal cursor indicator
execute 'highlight CursorLine guibg='.s:ColorGray700
execute 'highlight CursorLineNR guibg='.s:ColorBlack.' guifg='.s:ColorYellow.' gui=bold'
execute 'highlight LineNr guibg='.s:ColorBlack.' guifg='.s:ColorGray400
execute 'highlight SignColumn guibg='.s:ColorBlack
" visual selection color
execute 'highlight Visual guibg='.s:ColorGray600
execute 'highlight VertSplit guibg='.s:ColorGray600.' guifg='.s:ColorGray600
" for lines under last text line
execute 'highlight NonText guibg='.s:ColorBlack.' guifg='.s:ColorBlack
" Syntax
execute 'highlight Comment gui=italic'
" overwrite nvim colors for diff files
execute 'highlight diffAdded guifg='.s:ColorGreenLight.' gui=italic'
execute 'highlight diffRemoved guifg='.s:ColorMagenta.' gui=italic'
execute 'highlight diffChanged guifg='.s:ColorTeal.' gui=italic'
" GitGutter
execute 'highlight GitGutterAdd guifg='.s:ColorGreenLight.' guibg='.s:ColorBlack
execute 'highlight GitGutterDelete guifg='.s:ColorMagenta.' guibg='.s:ColorBlack
execute 'highlight GitGutterChange guifg='.s:ColorTeal.' guibg='.s:ColorBlack
" indent-blankline
" more subtle divider color
execute 'highlight IndentBlanklineChar guifg='.s:ColorGray600.' gui=nocombine'
execute 'highlight IndentBlanklineContextChar guifg='.s:ColorTeal.' gui=nocombine'
" MatchTag
execute 'highlight MatchTag guifg='.s:ColorGray600.' gui=bold'
" Minimal split dividers
execute 'highlight WinSeparator guifg='.s:ColorGray600.' gui=bold'
" hlslens
execute 'highlight HlSearchLens guifg='.s:ColorGray400
execute 'highlight HlSearchLensNear guifg='.s:ColorYellow.' gui=bold'

" identify syntax group under cursor
nmap <leader>hi :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" 
" Buffer configuration 
set hidden " hide buffers on switch instead of trying to close

" https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" Split configuration 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
" 
" Diff configuration 
" default: diffopt=internal,filler,closeoff
" Turn off whitespaces compare
set diffopt+=iwhite
" Turn off folding
set diffopt+=vertical
" Show filler lines, to keep the text synchronized with a window that has inserted lines at the same position
set diffopt+=filler
" More 'aesthetically pleasing' diffs via whitespace
set diffopt+=indent-heuristic
" Better diff algorithm
set diffopt+=algorithm:histogram
" 
" Search 
set gdefault
set hlsearch
set incsearch
" neovim only -- realtime search highlight
set inccommand=nosplit
" 
" Yank 
" Copy current file path to system clipboard
nnoremap <leader>p :let @+ = expand("%")<CR>
" 
" fzf 
nnoremap <C-p> :Files<CR>
nnoremap <leader>co :Commits<CR>
nnoremap <leader>b :Buffers<CR>
" gs = git status
nnoremap <leader>gs :GFiles?<CR>
" gl = git log
nnoremap <leader>gl :BCommits<CR>
" Augmenting Rg command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
" My muscle memory makes me type this
cabbrev Ag Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" 
" wildmenu 
set wildmenu
set wildmode=longest:list,full
" 
" MatchTagAlways 
let g:mta_filetypes = {
\  'html': 1,
\  'xml': 1,
\  'javascript.jsx': 1,
\  'typescript.tsx': 1,
\}
let g:mta_use_matchparen_group=0 " don't use same syntax as highlighting parens etc.
let g:mta_set_default_matchtag_color=0 " don't use default highlighting
" 
" vim-airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 0 " this is useless
" use nvim-treesitter; default of showing filename is useless
let g:airline_section_c = '%{nvim_treesitter#statusline(90)}'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_solarized_bg='dark'
let g:airline_theme='base16_monokai'
" 
" startify 
" Disable cow :'(
let g:startify_custom_header = [
        \ '                 __                ',
        \ '         __  __ /\_\    ___ ___    ',
        \ '        /\ \/\ \\/\ \ /'' __` __`\ ',
        \ '        \ \ \_/ |\ \ \/\ \/\ \/\ \ ',
        \ '         \ \___/  \ \_\ \_\ \_\ \_\',
        \ '          \/__/    \/_/\/_/\/_/\/_/',
        \ '                                   ',
        \ ]
let g:startify_lists = [
\ { 'type': 'sessions',  'header': ['        Sessions']       },
\ { 'type': 'dir',       'header': ['        MRU '. getcwd()] },
\ { 'type': 'files',     'header': ['        MRU']            },
\ { 'type': 'bookmarks', 'header': ['        Bookmarks']      },
\ { 'type': 'commands',  'header': ['        Commands']       },
\ ]
" Change dir to Git root when opening file in different dir
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [
\ {'z': '~/.zshrc'},
\ {'c': '~/.config/nvim/coc-settings.json'},
\ {'K': '~/.config/kitty/kitty.conf'},
\ {'T': '~/.tmux.conf.local'},
\ {'v': '~/.vimrc'}
\]
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
" 
" coc-explorer 
nmap <C-n> :CocCommand explorer<CR>
nmap <leader>n :CocCommand explorer<CR>
" 
" indentLine 
let g:indent_blankline_char = '│'
" tree sitter highlight
let g:indent_blankline_use_treesitter = v:true
" different highlight within nested blocks
let g:indent_blankline_show_current_context = v:true
" disable for markup-type files
let g:indent_blankline_filetype_exclude = ['startify', 'markdown', 'coc-explorer']
let g:indent_blankline_buftype_exclude = ['terminal']
" contexts to highlight nested
" this is kind of shitty
let g:indent_blankline_context_patterns = [
    \'argument_list',
    \'arguments',
    \'array',
    \'begin',
    \'block',
    \'case',
    \'catch',
    \'class',
    \'conditional',
    \'declaration',
    \'do',
    \'else',
    \'elsif',
    \'expression',
    \'finally',
    \'for',
    \'function', 
    \'hash',
    \'if',
    \'import',
    \'interface',
    \'jsx_element',
    \'jsx_expression',
    \'jsx_self_closing_element',
    \'lambda',
    \'method',
    \'module',
    \'object',
    \'return',
    \'statement',
    \'ternary',
    \'unless',
    \'until',
    \'while'
    \]
" 
" vim-abolish 
" Allow usage of text objects, e.g. criW
" nmap cr <Plug>(abolish-coerce)
" 
" vim-easyalign 
" align markdown tables on |
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" 
" vim-jsonpath 
" Optionally copy path to a named register (* in this case) when calling :JsonPath
let g:jsonpath_register = '*'
" Define mappings for json buffers
au FileType json noremap <buffer> <silent> <leader>d :call jsonpath#echo()<CR>
au FileType json noremap <buffer> <silent> <leader>g :call jsonpath#goto()<CR>
" 
" vim-test 
" Open tests in a new split
let test#strategy = "neovim"
" 
" diffview.nvim 
" Open diff against head
" :tabc to exit
nmap <leader>gd :<C-u>execute 'DiffviewOpen'<CR>
command! -nargs=? Diff :DiffviewOpen
command! -nargs=0 DiffMaster :DiffviewOpen master
command! -nargs=? DiffClose :DiffviewClose
" 
" replacer.nvim 
nmap <leader>h :lua require("replacer").run()<cr>
"
" targets.vim 
" Disable unused mappings for argument, pair, quote
autocmd User targets#mappings#user call targets#mappings#extend(
\ {
\   'a': {}, 'b': {}, 'q': {}
\ })
" 
lua <<EOF
-- nvim-hlslens
require('hlslens').setup()

-- gitlinker.nvim 
require('gitlinker').setup({
  mappings = "<leader>gY"
})

-- nvim-pqf 
require('pqf').setup()

-- nvim-treesitter 
-- Modules: enable highlighting, indentation, folding, etc. :h nvim-treesitter-modules
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "kotlin",
    "lua",
    "python",
    "regex",
    "ruby",
    "tsx",
    "typescript",
    "yaml",
  },
  autotag = {
    enable = true, -- nvim-ts-autotag
  },
  endwise = {
    enable = true, -- nvim-treesitter-endwise
  },
  highlight = {
    enable = true,
    disable = {},
    custom_captures = {},
  },
  -- gnn - start incremental selection
  -- grn - increment to upper named parent in visual mode
  -- grc - increment to upper scope in visual mode
  -- grm - decrement to previous named node in visual mode
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "<TAB>",
      scope_incremental = "grc",
      node_decremental = "<S-TAB>",
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- selects next available obj if not within one
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ar"] = "@frame.outer",
        ["ir"] = "@frame.inner",
        ["at"] = "@attribute.outer",
        ["it"] = "@attribute.inner",
        ["ae"] = "@scopename.inner",
        ["ie"] = "@scopename.inner",
        ["as"] = "@statement.outer",
        ["is"] = "@statement.outer",
      },
    },
  },
}
EOF
" 
" coc.vim 
" Declare and install missing dependencies
let g:coc_global_extensions = [
    \ "coc-actions",
    \ "coc-css",
    \ "coc-diagnostic",
    \ "coc-eslint",
    \ "coc-explorer",
    \ "coc-git",
    \ "coc-highlight",
    \ "coc-html",
    \ "coc-jest",
    \ "coc-json",
    \ "coc-lists",
    \ "coc-pairs",
    \ "coc-prettier",
    \ "coc-react-refactor",
    \ "coc-solargraph",
    \ "coc-styled-components",
    \ "coc-svg",
    \ "coc-tslint-plugin",
    \ "coc-tsserver",
    \ "coc-vimlsp",
    \ "coc-yaml"
    \]

" Settings almost directly copied from: https://github.com/neoclide/coc.nvim#example-vim-configuration
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Overwrite K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" DISABLED -- now handled by tree-sitter
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR      :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Autofix :call     CocAction('runCommand', 'eslint.executeAutofix')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" remap range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" navigate chunks of current buffer
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" create text object for git chunks (inner chunk etc.)
omap ic <Plug>(coc-git-chunk-inner)
xmap ic <Plug>(coc-git-chunk-inner)
omap ac <Plug>(coc-git-chunk-outer)
xmap ac <Plug>(coc-git-chunk-outer)

" coc-jest
" Run jest for current file
command! -nargs=0 JestFile :call  CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>jf :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>

" Run jest for current test
command! -nargs=0 JestCurr :call  CocAction('runCommand', 'jest.singleTest')
nnoremap <leader>jc :call CocAction('runCommand', 'jest.singleTest')<CR>
