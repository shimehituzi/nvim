" ==================================== dein ====================================
if &compatible
    set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:toml_dir = expand('~/.config/nvim')

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

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




" ==================================== 基本設定 ====================================

" 最低限の設定
syntax enable
colorscheme sonokai
set fenc=utf-8
set nobackup
set nowritebackup
set noswapfile
set autoread
set hidden
set showcmd
set shada="NONE"
let g:netrw_dirhistmax=0
set timeoutlen=4000
set updatetime=300
set nofixeol

" 見た目の設定
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set number
set matchtime=1
set laststatus=2
set display=lastline
set pumblend=10
set cmdheight=2
set signcolumn=yes

" 検索の設定
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" インデントの設定
set expandtab
set tabstop<
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent




" ==================================== 補完（マッピングも含む） ====================================

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
set shortmess+=c
inoremap <expr><silent> <C-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr><silent> <C-k> pumvisible() ? "\<C-p>" : coc#refresh()
inoremap <silent><expr> <C-c> pumvisible() ? "\<C-e>" : ""
inoremap <silent><expr> jk pumvisible() ? coc#_select_confirm() : coc#refresh()
inoremap j<space> j




" ==================================== マッピング ====================================

" ローカルなマッピング用のプレフィックス
nnoremap [localmap] <nop>
nmap <C-a> [localmap]
nnoremap [localmap]q :qa<CR>
inoremap <C-a> <nop>

" 基本的な移動系コマンドを押しやすく再定義
noremap <Tab> G
noremap m ge
noremap M gE
noremap j gj
noremap k gk
noremap H ^
noremap L $
noremap <C-h> <C-w>W
noremap <C-l> <C-w>w
noremap <C-f> <C-d>
noremap <C-d> <C-u>


" 小文字か大文字化を入れ替え
noremap gu gU
noremap gU gu

" オペレータのテキストオブジェクトを押しやすく再定義
onoremap aa a>
onoremap ia i>
onoremap as a[
onoremap is i[
onoremap ad a"
onoremap id i"
xnoremap aa a>
xnoremap ia i>
xnoremap as a[
xnoremap is i[
xnoremap ad a"
xnoremap id i"

" インサートモードのマッピング
inoremap <S-Tab> <C-o>
inoremap <C-e> <C-o>$
inoremap <C-s> <Esc>gUawea
inoremap <C-d> <Del>


" インサートモードのマッピング2
inoremap <C-n> <Nop>
inoremap <C-p> <Nop>


"  ノーマルモードのマッピング 1
nnoremap <C-e> <C-e>
nnoremap <C-Space> <C-y>
nnoremap - *N
nnoremap _ g*N
nnoremap <silent> <CR> :w<CR>
nnoremap <silent> <C-c> :bw<CR>:clearjumps<CR>
nnoremap ' :!
nnoremap + zt15<C-y>
nnoremap t <C-a>
nnoremap T <C-x>
vnoremap <silent> <C-y> y']
nnoremap <silent> <C-p> p']
nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap Y y$
nnoremap <silent> ~ :Typo<CR>
nnoremap <C-\> <C-^>
nnoremap <BS> <C-o>
nnoremap <S-Tab> <C-i>
nnoremap G ~
nnoremap U J
nnoremap Q @
nnoremap <silent> ` <C-l>:nohl<CR>

" ノーマルモードのマッピング 2
nnoremap <Space><Esc> <nop>
nnoremap n nzz
nnoremap N Nzz
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap <space>m m
nnoremap <C-^> `
nnoremap <C-g> :HighlightInfo<CR>

" os のクリップボードとの連携
nnoremap <Space>y "+yy
nnoremap <Space>Y "+y$
vnoremap <Space>y "+y
vnoremap <Space>d "+d
nnoremap <Space>p "+p
nnoremap <Space>P "+P

" vim の設定ファイルを再読み込み
nnoremap <Space>` :source ~/.config/nvim/init.vim<CR>

" 矢印で行の移動を可能に
nnoremap <S-Down> Vj
xnoremap <S-Down> j
nnoremap <S-Up> Vk
xnoremap <S-Up> k
nnoremap <silent><S-Left> :m.-2<CR>
xnoremap <silent><S-Left> :m.-2<CR>gv
nnoremap <silent><S-Right> :m.+1<CR>
xnoremap <silent><S-Right> :Vmd<CR>

" ウィンドウの位置を移動
nnoremap <S-C-Down> <C-w>J
nnoremap <S-C-Up> <C-w>K
nnoremap <S-C-Left> <C-w>H
nnoremap <S-C-Right> <C-W>L

" 今んとこ使ってないマッピング
nnoremap <expr> <C-t> ThisKeyIsNop()
nnoremap <expr> <C-b> ThisKeyIsNop()
nnoremap <expr> <C-y> ThisKeyIsNop()
nnoremap <expr> <C-n> ThisKeyIsNop()
nnoremap <expr> <C-_> ThisKeyIsNop()

" ファイルタイプ別のマッピング
augroup fileTypeMapping
    au FileType rust nnoremap <C-o> A;<ESC>
    au FileType typescript.tsx nnoremap <C-o> O<Tab>
    au FileType typescript.tsx inoremap <C-t> <esc>cit
augroup END



" ==================================== マッピングのための自作関数 ====================================

" タイポ修正
function! TypoFunc()
    let @z=@"
    normal! xp
    let @"=@z
    let @z=@_
    let @-=@_
endfunction
command! Typo call TypoFunc()

" 行の移動
function! VisualMoveDown() range
    let l:size = a:lastline - a:firstline
    execute a:firstline ',' a:lastline 'move.+' l:size
    unlet l:size
    normal! gv
endfunction
command! -range Vmd <line1>,<line2>:call VisualMoveDown()

" カーソル下のハイライト情報を得る
function! s:get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
    execute "highlight " . s:get_syn_name(s:get_syn_id(0))
    execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()

" マッピングされてない事を伝える
function! ThisKeyIsNop()
    echo 'このキーには何もマッピングされていません'
endfunction



" ==================================== ファイルタイプ毎の基本設定 ====================================

" ファイルタイプ毎のシステム的な設定
let g:tex_flavor = "latex"
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx

augroup helpfiles
    au!
    au BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
augroup END


" ファイルタイプ毎のインデントの設定（インデントを4にする設定）
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.c setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.h setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.md setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.vim setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.toml setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.tex setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.json setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" vim Treesitter の設定
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {
      rust,
    }
  },
}
EOF



" ==================================== カラースキーム修正 ====================================
hi NonText      ctermfg=74 ctermbg=NONE cterm=NONE guifg=#61bbc8 guibg=NONE gui=NONE
hi Comment      ctermfg=44 ctermbg=NONE cterm=NONE guifg=#5c98cd guibg=NONE gui=NONE
hi MatchParen   ctermfg=203 ctermbg=NONE cterm=underline guifg=#ff6541 guibg=NONE gui=underline
hi LineNr       ctermfg=223 ctermbg=NONE cterm=NONE guifg=#929ba1 guibg=NONE gui=NONE
hi VertSplit    ctermfg=60 ctermbg=60 cterm=NONE guifg=#5f99cb guibg=NONE gui=NONE
hi IncSearch    ctermfg=23 ctermbg=186 cterm=NONE guifg=#2b3e50 guibg=#f5f499 gui=NONE
hi Search       ctermfg=23 ctermbg=186 cterm=NONE guifg=#2b3e50 guibg=#d8e4f8 gui=underline
hi Folded       ctermfg=68 ctermbg=23 cterm=NONE guifg=#5c98cd guibg=NONE gui=bold
hi CocHighlightText guibg=#66747f
hi! link Grey Purple
