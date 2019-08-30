" 使ってないマッピング
"   

" Setting
colorscheme lucario
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set shada="NONE"
let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'


" colorscheme
augroup latexfiles
    au!
    au BufNewFile,BufRead *.tex set background=dark
    au BufNewFile,BufRead *.tex let g:solarized_termtrans=1
    au BufNewFile,BufRead *.tex let g:solarized_termcolors = 256
    au BufNewFile,BufRead *.tex colorscheme solarized
    au BufNewFile,BufRead *.tex AirlineRefresh
augroup END
augroup markdownfiles
    au!
    au BufNewFile,BufRead *.md set background=dark
    au BufNewFile,BufRead *.md let g:solarized_termtrans=1
    au BufNewFile,BufRead *.md let g:solarized_termcolors = 256
    au BufNewFile,BufRead *.md colorscheme solarized
    au BufNewFile,BufRead *.md highlight SignColumn ctermbg=NONE
    au BufNewFile,BufRead *.md AirlineRefresh
augroup END


" filetype
let g:tex_flavor = "latex"
au BufRead,BufNewFile *.md set filetype=markdown
augroup helpfiles
    au!
    au BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
augroup END


" functional
syntax enable
set timeoutlen=4000
" set foldmethod=syntax


" Appearance
set number
set matchtime=1
set laststatus=2
set display=lastline


" Indent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.vim setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.toml setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.tex setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.json setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch


" map
" -------------------------------------------------------------------------------------
noremap <Tab> G
noremap m ge
noremap M gE
noremap H ^
noremap L $
noremap j gj
noremap k gk
noremap <C-f> <C-d>
noremap <C-d> <C-u>
noremap <C-s> M
noremap <C-h> H
noremap <C-l> L
noremap 0 <C-l>
noremap gu gU
noremap gU gu
" -------------------------------------------------------------------------------------
onoremap aa a>
onoremap ia i>
onoremap ar a[
onoremap ir i[
onoremap ad a"
onoremap id i"
" -------------------------------------------------------------------------------------
inoremap j<space> j
inoremap jk <C-o>
inoremap jl <esc>
inoremap <C-a> <Esc>A
inoremap <expr><C-c> pumvisible() ? "\<C-e>" : "\<C-c>"
" -------------------------------------------------------------------------------------
nnoremap <silent> <C-c> :bw<CR>:clearjumps<CR>
nnoremap <silent> <CR> :w<CR>
nnoremap <C-_> zt15<C-y>
nnoremap - <C-e>
nnoremap _ <C-y>
nnoremap * *<C-o>
nnoremap ^ g*<C-o>
nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap Y y$
nnoremap t <C-a>
nnoremap T <C-x>
nnoremap <S-Tab> <C-i>
nnoremap <BS> <C-o>
nnoremap G ~
nnoremap U J
nnoremap & :%s///gc<Left><Left><Left>
nnoremap <silent> ` :nohl<CR>
nnoremap <silent> ~ :let @z = @"<CR>xp:let @" = @z<CR>
nnoremap <Space><Esc> <nop>
" -------------------------------------------------------------------------------------
nnoremap n nzz
nnoremap N Nzz
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap <space>m m
nnoremap ' `
" -------------------------------------------------------------------------------------
vnoremap <silent> <C-y> y']
nnoremap <silent> <C-p> p']
nnoremap <Space>y "+yy
nnoremap <Space>Y "+y$
vnoremap <Space>y "+y
vnoremap <Space>d "+d
nnoremap <Space>p "+p
nnoremap <Space>P "+P
" -------------------------------------------------------------------------------------
nnoremap Q @
nnoremap $ <nop>
nnoremap # <nop>
nnoremap @ <nop>
" -------------------------------------------------------------------------------------
nnoremap <Space>` :source ~/.config/nvim/init.vim<CR>


" cmdline-emacs-keybind
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-p> <Up>



" ======================== スクリプトローカルな関数のSID取得 =========================

function! GetScriptID(fname)
    let snlist = ''
    redir => snlist
    silent! scriptnames
    redir END
    let smap = {}
    let mx = '^\s*\(\d\+\):\s*\(.*\)$'
    for line in split(snlist, "\n")
        let smap[tolower(substitute(line, mx, '\2', ''))] = substitute(line, mx, '\1', '')
    endfor
    return smap[tolower(a:fname)]
endfunction

" ======================== スクリプトローカルな関数のSID取得 =========================




" ======================================= arrow =======================================

nnoremap <Down> <nop>
nnoremap <Up> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

nnoremap <S-Down> <nop>
nnoremap <S-Up> <nop>
nnoremap <S-Left> <nop>
nnoremap <S-Right> <nop>

nnoremap <C-S-Down> <C-w>J
nnoremap <C-S-Up> <C-w>K
nnoremap <C-S-Left> <C-w>H
nnoremap <C-S-Right> <C-W>L

" ======================================= arrow =======================================




" ======================================== dein ========================================
if &compatible
    set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:toml_dir = expand('~/.config/nvim')

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    "delete plugin"
    " call map(dein#check_clean(), "delete(v:val, 'rf')")
    " call dein#recache_runtimepath()
    "delete plugin"

    let s:toml = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif
" ======================================== dein ========================================


" ======================================== PyDoc =======================================

" 自分でマッピング
" nnoremap <silent> <buffer> ^ :call <SID>ShowPyDoc(<SID>ReplaceModuleAlias(), 1)<CR>
" <SID>は外部から取得できないのでこんな感じにする
function! PyDocMap()
    let s:pydocsid = GetScriptID('~/.cache/dein/repos/github.com/fs111/pydoc.vim/ftplugin/python_pydoc.vim')
    let s:showpydoc = '<SNR>' . s:pydocsid . '_ShowPyDoc(<SNR>' . s:pydocsid . '_ReplaceModuleAlias(), 1)'
    call eval(s:showpydoc)
endfunction
autocmd BufNewFile,BufRead *.py nnoremap <silent> <buffer> <Space>k :call PyDocMap()<CR>

" ======================================== PyDoc =======================================


" ======================================== toml ========================================

" tomlにvimのsyntax highlightを効かせる
augroup MyVimrcTOML
    autocmd!
augroup END

autocmd MyVimrcTOML BufNewFile,BufRead dein*.toml call s:syntax_range_dein()

function! s:syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \           'add\|source\|post_source\|post_update'.
  \           '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction

" ======================================== toml ========================================


" ======================================== 補完 ========================================

" 補完のプレビューウィンドウを表示させない
set completeopt-=preview
" 補完が一つであってもポップアップメニューを使う
set completeopt+=menuone
" 補完のカーソルを一つ目に合わせておく
set completeopt+=noinsert
" 補完関連のメッセージを表示しない
set shortmess+=c

" ======================================== 補完 ========================================
