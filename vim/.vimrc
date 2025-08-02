" 基本設定
set nocompatible              " Vi互換モードを無効化（Vimの機能を使用）
set encoding=utf-8            " デフォルトエンコーディング設定
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,default,latin1

" UI設定
set number                    " 行番号を表示
set relativenumber           " 相対行番号を表示
set ruler                    " カーソル位置を表示
set showcmd                  " 入力中のコマンドを表示
set showmode                 " 現在のモードを表示
set laststatus=2            " ステータスラインを常に表示
set wildmenu                " コマンド補完をメニュー形式で表示
set wildmode=list:longest,full
set cursorline              " 現在行をハイライト
set showmatch               " 対応する括弧をハイライト
set mat=2                   " 括弧の対応表示時間（0.1秒単位）

" カラーと構文
syntax enable               " 構文ハイライトを有効化
set background=dark         " 背景色をダークに設定
set t_Co=256               " ターミナルで256色を使用

" インデント設定
set autoindent             " 自動インデント
set smartindent            " スマートインデント
set expandtab              " タブをスペースに変換
set tabstop=4              " タブの表示幅
set softtabstop=4          " 編集時のタブの幅
set shiftwidth=4           " 自動インデントの幅
set shiftround             " インデントをshiftwidthの倍数に調整

" 検索設定
set hlsearch               " 検索結果をハイライト
set incsearch              " インクリメンタルサーチを有効化
set ignorecase             " 検索時に大文字小文字を区別しない
set smartcase              " 大文字を含む場合は区別する
set magic                  " 正規表現を有効化

" パフォーマンス設定
set lazyredraw             " マクロ実行中は再描画しない
set ttyfast                " 高速ターミナル接続
set synmaxcol=200          " 構文ハイライトは200列まで

" ファイルとバックアップ設定
set nobackup               " バックアップファイルを作成しない
set nowritebackup          " 上書き前のバックアップを作成しない
set noswapfile             " スワップファイルを作成しない
set autoread               " 外部で変更されたファイルを自動読み込み
set hidden                 " 保存せずにバッファ切り替えを許可

" 折りたたみ設定
set foldenable             " 折りたたみを有効化
set foldlevelstart=10      " デフォルトでほとんどの折りたたみを開く
set foldnestmax=10         " 最大折りたたみ深度
set foldmethod=indent      " インデントベースで折りたたみ

" 編集設定
set backspace=indent,eol,start  " バックスペースで削除できる文字
set wrap                        " 行を折り返す
set linebreak                   " 単語の途中で折り返さない
set textwidth=100              " テキストの最大幅
set formatoptions+=t           " テキストを自動折り返し
set clipboard=unnamedplus      " システムクリップボードを使用
set mouse=a                    " マウスサポートを有効化

" ウィンドウ分割設定
set splitbelow             " 水平分割は下に開く
set splitright             " 垂直分割は右に開く

" 補完設定
set completeopt=menuone,noselect,preview
set shortmess+=c           " 補完メッセージを表示しない

" キーマッピング
let mapleader = ","        " リーダーキーをカンマに設定

" ノーマルモードのマッピング
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>h :nohlsearch<CR>

" 分割ウィンドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 行を上下に移動
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" タブ操作
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tm :tabmove

" バッファ操作
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" クイック保存と終了
inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-s> :w<CR>

" ファイルタイプ別設定
augroup configgroup
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType typescript setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType css setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType json setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType markdown setlocal wrap linebreak
    autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" 保存時に末尾の空白を削除
autocmd BufWritePre * :%s/\s\+$//e

" ファイルを開いた時に前回の編集位置に戻る
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Netrw（ファイラー）設定
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" カスタム関数
" 行番号と相対行番号を切り替え
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <leader>n :call ToggleNumber()<CR>

" 末尾の空白を削除
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunc
nnoremap <leader>s :call StripTrailingWhitespace()<CR>

" ビジュアルモードで * または # を押すと選択中のテキストを検索
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction