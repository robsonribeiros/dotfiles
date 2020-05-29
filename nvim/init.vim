"--------------------------------Plugins---------------------------------------------
call plug#begin()
"Theme Plug
Plug 'morhetz/gruvbox'

"Terminal
Plug 'tc50cal/vim-terminal'

"Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

"Syntax  Highlighting
Plug 'sheerun/vim-polyglot'

"Files Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Check Code Lint
Plug 'dense-analysis/ale'

"Autocomplete pairs
Plug 'jiangmiao/auto-pairs'

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"NerdTree
Plug 'preservim/nerdtree'

"Icons File Manager
Plug 'ryanoasis/vim-devicons'

"Autocomplete Langs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Autoformat
Plug 'Chiel92/vim-autoformat'

"-----------Langs----------------------------------------------------------------------
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'posva/vim-vue'
Plug 'turbio/bracey.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'
Plug 'alvan/vim-closetag'

call plug#end()

"----------Basic------------------------------------------------------------------------
"Char
set encoding=UTF-8

"Theme
let g:airline_theme='base16'
colorscheme gruvbox
set background=dark

"Change files without saving
set hidden

"See numbers on lines
set number

"See numbers relatives on line
set relativenumber

"Preview in real time
set inccommand=split

"Noswap
set noswapfile

"Autosave
set autowrite

"Filetype
filetype on

"Cursorline
set cursorline

"-----------------Leader and maps-------------------------

"Leader Key
let mapleader="\<space>"

"Neovim Edit
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>

"Neovim reload
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

"Fuzzy search Files
nnoremap <c-p> :Files<cr>

"Search ocurrencys
 nnoremap <c-f> :Ag<cr>

 "--------------------------Snipets---------------------------------------
 "Snippets Conf
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'


"-----------------------Vue----------------------------------------------

"SAAS
let g:vue_pre_processors = ['pug', 'scss']


"------------------------Terminal----------------------------------------

"Terminal
nnoremap <leader>t :TerminalSplit zsh<cr>



"------------------Golang------------------------------------------------

"Go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }

" Run gofmt on save
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
"GoLang
nnoremap<leader>gr :GoRun<CR>
nnoremap<leader>gd :GoDebugStart<CR>
nnoremap<leader>gb :GoBuild<CR>

"-------------NERDTre---------------------------------

"File
nnoremap <C-l> :NERDTreeToggle<CR>

"-------------------Flutter--------------------------------
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

let g:flutter_command="flutter"
let g:flutter_command=1
let g:flutter_hot_restart_on_save=0
let g:flutter_show_log_on_run=1

"-------HTMl----------------------------------------------------------------
"
"filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

"-----------------Autoformat----------------------------------------------------

"Save on format
au BufWrite * :Autoformat

"F3 Format
noremap <F3> :Autoformat<CR>