" =====================
" === Enhance Editor ==
" =====================

" 基础设置
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set smartcase
set notimeout
set jumpoptions=stack
set updatetime=200

" 快捷输入标志位符
imap <buffer> ( ()<ESC>F(li
imap [ []<ESC>F[li
imap <buffer> { {}<ESC>F{li

" 分屏操作
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

" 分屏下光标移动
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

" 分屏大小改变
map <C-up> :res +5<CR>
map <C-down> :res -5<CR>
map <C-left> :vertical resize-5<CR>
map <C-right> :vertical resize+5<CR>

" 快捷移动光标
map - 5k
map = 5j

let mapleader='\'


" install plug mannager
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  :exe '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif




" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"
" 加入注释
func SetComment()
    call setline(1,"/*================================================================")
    call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Goodfanqie. All rights reserved.")
    call append(line(".")+1, "*   ")
    call append(line(".")+2, "*   File   name：".expand("%:t"))
    call append(line(".")+3, "*   Created  by：Goodfanqie")
    call append(line(".")+4, "*   Create Date：".strftime("%Y.%m.%d."))
    call append(line(".")+5, "*   Description：")
    call append(line(".")+6, "*")
    call append(line(".")+7, "================================================================*/")
    call append(line(".")+8, "")
    call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
    call setline(3, "#================================================================")
    call setline(4, "#   Copyright (C) ".strftime("%Y")." Goodfanqie. All rights reserved.")
    call setline(5, "#   ")
    call setline(6, "#   File   name：".expand("%:t"))
    call setline(7, "#   Created  by: Goodfanqie")
    call setline(8, "#   Create date：".strftime("%Y年%m月%d日"))
    call setline(9, "#   Description：")
    call setline(10, "#")
    call setline(11, "#================================================================")
    call setline(12, "")
    call setline(13, "")
endfunc
" 定义函数SetTitle，自动插入文件头
func SetTitle()
    if &filetype == 'make'
        call setline(1,"")
        call setline(2,"")
        call SetComment_sh()

    elseif &filetype == 'sh'
        call setline(1,"#!/system/bin/sh")
        call setline(2,"")
        call SetComment_sh()

    else
         call SetComment()
         if expand("%:e") == 'hpp'
          call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
          call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
          call append(line(".")+12, "#ifdef __cplusplus")
          call append(line(".")+13, "extern \"C\"")
          call append(line(".")+14, "{")
          call append(line(".")+15, "#endif")
          call append(line(".")+16, "")
          call append(line(".")+17, "#ifdef __cplusplus")
          call append(line(".")+18, "}")
          call append(line(".")+19, "#endif")
          call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

         elseif expand("%:e") == 'h'
          call append(line(".")+10, "#pragma once")
         endif
    endif
endfunc



" =====================
" === plugins begin  ==
" =====================
call plug#begin('~/.config/nvim/plugged')

" theme
  Plug 'morhetz/gruvbox'

" floating terminal
  Plug 'voldikss/vim-floaterm'

" add file icon
  Plug 'ryanoasis/vim-devicons'

" theme
  Plug 'cateduo/vsdark.nvim'

" file explorer
  Plug 'preservim/nerdtree'

" lsp
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" ==== 907th/vim-auto-save ====
let g:auto_save = 0
augroup cpp
    au!
    au FileType cpp let b:auto_save = 1
    au FileType c let b:auto_save = 1
augroup END




" ==== cateduo/vsdark.nvim ====
set termguicolors
colorscheme gruvbox



" ==== floaterm ====
map te :FloatermNew<CR>


" ==== preservim/nerdtree ====

" 快速打开NERDTree 视窗
map <leader><leader> :NERDTreeToggle<CR>  
" show the hidden file
let NERDTreeShowHidden=1


" ==== coc extensions ====
set signcolumn=number
" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <s-TAB> to select candidate backward
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif


nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" Use `[g` and `]g` to navigate diagnostics
" 使用快捷键跳转下一条错误信息
" 使用[g和]g查找上一个或下一个代码报错
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)



" GoTo code navigation.跳转函数定义
" 或者是查看定义的函数在哪里被调用
" 列出定义列表
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)    "转至类型定义
nmap <silent> gi <Plug>(coc-implementation)     "待办事项清单
nmap <silent> gr <Plug>(coc-references)         "列出参考列表
nmap <LEADER>qf <Plug>(coc-fix-current)






" ==== clipboard with os ====
let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }


