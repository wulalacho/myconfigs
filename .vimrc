" #####################
" Goodfanqie's .vimrc
" #####################



" #####################
" 插件
" #####################
call plug#begin()
" 文件树插件
Plug 'preservim/nerdtree'
" 文件icon
Plug 'ryanoasis/vim-devicons'
" 代码补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" #####################
" 基础设置
" #####################
set number
set autoindent           " 设置自动缩进
set cindent              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0    " 设置C/C++语言的具体缩进方式
set smartindent          " 智能的选择对其方式
filetype indent on       " 自适应不同语言的智能缩进
filetype plugin on       " 载入文件类型插件
set expandtab            " 将制表符扩展为空格
set tabstop=4            " 设置编辑时制表符占用空格数
set shiftwidth=4         " 设置格式化时制表符占用空格数
set softtabstop=4        " 设置4个空格为制表符
set smarttab             " 在行和段开始处使用制表符
set nowrap               " 禁止折行
set backspace=2          " 使用回车键正常处理indent,eol,start等
set nocompatible         " 设置不兼容原始vi模式
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
filetype plugin indent on
set noeb                 " 关闭错误的提示
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set t_Co=256             " 开启256色支持
set cmdheight=1          " 设置命令行的高度
set showmatch            " 括号匹配,当输入）、}时，光标会短暂地回到相匹配地左括号
" 代码提示框背景颜色

hi Pmenu ctermfg=7 ctermbg=236
hi PmenuSel ctermfg=white ctermbg=32
hi CocFloating ctermfg=black ctermbg=240




" #####################
" 快捷操作
" #####################

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

" 快捷输入标志位符
imap <buffer> ( ()<ESC>F(li
imap [ []<ESC>F[li
imap <buffer> { {}<ESC>F{li






" #####################
" 插件设置
" #####################

" 文件树的键盘映射
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>
map <leader><leader> :NERDTreeToggle<CR>  " 快速打开NERDTree 视窗
" 设置树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'



" json语法支持
autocmd FileType json syntax match Comment +\/\/.\+$+

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')


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



" Use K to show documentation in preview window.
" 使用快捷键来预览文档
nnoremap <silent> <C-h> :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Highligh the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')t
" ymbol renaming.变量重命名
nmap name  <Plug>(coc-rename)S
" Formatting selected code.
"
"









" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"
" 加入注释
func SetComment()
    call setline(1,"/*================================================================")
    call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Goodfanqie. All rights reserved.")
    call append(line(".")+1, "*   ")
    call append(line(".")+2, "*   文件名称：".expand("%:t"))
    call append(line(".")+3, "*   创 建 者：Goodfanqie")
    call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日"))
    call append(line(".")+5, "*   描    述：")
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
    call setline(6, "#   文件名称：".expand("%:t"))
    call setline(7, "#   创 建 者: Goodfanqie")
    call setline(8, "#   创建日期：".strftime("%Y年%m月%d日"))
    call setline(9, "#   描    述：")
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
