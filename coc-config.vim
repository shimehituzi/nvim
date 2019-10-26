" これをしないと <C-j> と <C-k> にスニペットの移動がマッピングされて補完の選択ができなくなってしまう
let g:coc_snippet_next = "\<C-f>"
let g:coc_snippet_prev = "\<C-d>"


" マッピングのリーダー
nnoremap [coc] <nop>
nmap <space><space> [coc]
" cocList
nnoremap <silent> [coc]w :<C-u>CocList diagnostics<cr>
nnoremap <silent> [coc]e :<C-u>CocList extensions<cr>
nnoremap <silent> [coc]r :<C-u>CocList commands<cr>
nnoremap <silent> [coc]t :<C-u>CocList outline<cr>
nnoremap <silent> [coc]g :<C-u>CocList -I symbols<cr>
nnoremap <silent> [coc]f :<C-u>CocNext<CR>
nnoremap <silent> [coc]d :<C-u>CocPrev<CR>
nnoremap <silent> [coc]s :<C-u>CocListResume<CR>
" LSP
nnoremap <silent> [coc]j :call <SID>show_documentation()<CR>
nmap     <silent> [coc]k <Plug>(coc-references)
nmap     <silent> [coc]i <Plug>(coc-definition)
nmap     <silent> [coc]o <Plug>(coc-type-definition)
nmap     <silent> [coc]l <Plug>(coc-implementation)
nmap              [coc]h <Plug>(coc-rename)
nmap              [coc]u <Plug>(coc-format-selected)
xmap              [coc]u <Plug>(coc-format-selected)

" 移動
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" テキストオブジェクト （関数）
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" 不明
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>ac  <Plug>(coc-codeaction)
" nmap <leader>qf  <Plug>(coc-fix-current)


" コマンド定義
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" 関数（定義参照で使う関数）
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


" オートコマンド
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" ステータスラインの設定
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
