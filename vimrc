" ===========================================================================
" For VIM
" ===========================================================================


" ====== 插件管理 ======
call pathogen#infect()

" 在Mac下把｀Ctrl-f｀映射到了｀Esc-f｀，是为了实现命令行以单词移动光标，导致的结果是
" vim里面的`Ctrl-f`失效了，因此再做个映射把单独的一个`f`键映射到`Ctrl-f`，然后在vim
" 里，就继续可以使用`Ctrl-f`来翻页了，同时也可以单独使用`f`来翻页。如果没有设置前面
" `Ctrl-f`到`Esc-f`的映射，那可以把这个注释掉。`Ctrl-b`也是同样的道理。
" map f <c-f>
" map b <c-b>
imap jj <esc>

" ====== 基本设置 ======
set ts=4
set expandtab
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start

" 高亮显示搜索结果
set hlsearch
map <C-n> :noh<CR>

" 实时进行高亮查询
set incsearch

" 设置光标水平和垂直线
set cursorline
set cursorcolumn

" 显示当前的行号列号：
set ruler

" 在状态栏显示正在输入的命令
set showcmd

" 显示行号：
" set number

" 为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" 临时粘贴，解决缩进混乱的问题，进入paste模式
" 或者使用命令：
" set paste or set nopaste
set pastetoggle=<F10>

" 编码
set fileencoding=utf-8
set encoding=utf-8

" 设置不自动折行
set nowrap

" 配色方案
if ! has("gui_running") 
    set t_Co=256 
endif 
colorscheme anotherdark
"colorscheme darkburn

" 窗口切换快捷键修改
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" 窗口调整大小
" 将当前窗口增加/减少n行: Ctrl+w n +/-
" 将当前窗口增加/减少n列: Ctrl+w n >/<
" 恢复等宽等高：Ctrl+w =
" 窗口最大化：Ctrl+w |
nmap J :resize -3<CR>
nmap K :resize +3<CR>
nmap H :vertical resize -3<CR>
nmap L :vertical resize +3<CR>

" ====== 自动检测文件类型并加载相应的设置 ======
syntax on
filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType java setlocal et sta sw=4 sts=4
autocmd FileType php setlocal et sta sw=4 sts=4
autocmd FileType c setlocal et sta sw=4 sts=4
autocmd FileType cpp setlocal et sta sw=4 sts=4
autocmd FileType html setlocal et sta sw=2 sts=2
autocmd FileType xml setlocal et sta sw=4 sts=4
autocmd FileType bash setlocal et sta sw=4 sts=4
autocmd FileType puppet setlocal et sta sw=4 sts=4

" ====== 代码折叠 ======
autocmd FileType python setlocal foldmethod=indent
autocmd FileType java setlocal foldmethod=indent
autocmd FileType php setlocal foldmethod=indent
autocmd FileType c setlocal foldmethod=indent
autocmd FileType cpp setlocal foldmethod=indent
autocmd FileType html setlocal foldmethod=indent
autocmd FileType xml setlocal foldmethod=indent
autocmd FileType bash setlocal foldmethod=indent

" 默认展开所有代码
set foldlevel=99

" 空格键作为快捷键
nnoremap <space> za

" For html and javascript
let g:SimpleJsIndenter_BriefMode = 1
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "html,body,head,tbody"

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" 上下左右键的行为
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"保证vim在reopen一个文件时定位到同一行
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ====== CTAGS ======
set tags=tags;/

" ====== Tagbar======
nmap <F5> :TagbarToggle<CR>
let tagbar_width = 30

" ====== NerdTree ======
" 打开 NerdTree
map <silent> <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.egg-info', '\.egg$', '\.pyo']

" ===== plantuml =====
let g:plantuml_executable_script='java -jar ~/.vim/bundle/plantuml-syntax/plantuml.jar'

" ====== CommandT =====
" 快捷键F打开CommandT
map F :CommandT<CR>
let g:CommandTMaxHeight=20
let g:CommandTWildIgnore=&wildignore . ",**/*.egg-info/**,*.pyc,*.pyo,**/*.egg*/**"
"set wildignore+=*.o,*.obj,.git,*.pyc,*pyo,**/*.egg-info/**,**/*.egg*/**
let g:CommandTCancelMap='<Esc>'

" ======vim-markdown=====
let g:vim_markdown_folding_disabled=1

"进行版权声明的设置
""添加或更新头
map <F6> :call AddTitle()<cr>'s
function AddTitle()
    let lnum = line(".")
    let indt = indent(lnum)
    let space = ""
    for i in range(indt)
        let space .= " "
    endfor
    call append(lnum, space . "import pdb; pdb.set_trace()")
endf

 
" ===== 垂直线 =====
map <F9> :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = 80
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

" 最大化当前窗口
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose
        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
let mapleader = "\<Space>"
nmap <leader>z :call Zoom()<CR>

" vim-go
let g:go_def_mapping_enabled = 0
