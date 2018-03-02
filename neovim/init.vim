" VIM-PLUG SECTION """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug section
call plug#begin('~/.vim/plugged')

" Git related
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'christoomey/vim-conflicted' " git diff tool and merge conflic resolution.

" Vim's UI modification and styling
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File explorer
Plug 'vim-airline/vim-airline' " Status line styling with git and mode integration

" Style and syntax related
Plug 'editorconfig/editorconfig-vim' " Handling EditorConfig files for code style
Plug 'lifepillar/pgsql.vim' " Postgres specific highlighting

" Utilities
Plug 'yegappan/greplace' " Search and replace in all files/folders
Plug 'junegunn/fzf.vim' " Fuzzy finder

" Edition
Plug 'gregsexton/MatchTag' " Highlight matching html tags

" Others / not used
"Plug 'scrooloose/syntastic'
"Plug 'wincent/command-t' " ??

" COLOR SCHEME
Plug 'crusoexia/vim-monokai'
Plug 'michalbachowski/vim-wombat256mod' " Soft but readable contrast
Plug 'shaond/vim-guru'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" SETTINGS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme wombat256mod " @_@
set number
set cursorline
set timeoutlen=1000 ttimeoutlen=0 

" Tabs and indentations
set tabstop=4
set shiftwidth=4

" Display invisble charaters
set list

" set pgsql as default syntax for sql files
let g:sql_type_default = 'pgsql'

" ctrl-p configs
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
let g:ctrlp_custom_ignore = '\v[\/]\.(DS_Storegit|hg|svn|optimized|compiled)|node_modules$'

" REMAPS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move panes using alt-arrows instead of C-w, much more fluid.
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Ctrl-p like prompt for FZF
nmap <C-p> :FZF<CR>

" While in simple visual mode, C-r will replace all occurence with some other
" text (search and replace)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" CUSTOM COMMANDS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :Q and :W to be the same as :q and :w
command! Q q
command! W w
command! Wq wq
command! WQ wq
command! Wqa wqa
command! WQa wqa
command! WQA wqa
