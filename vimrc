set ruler
set backspace=2
set showmatch
set autoindent
set smartindent
set incsearch
"set hlsearch
set background=light
"set term=dtterm
set laststatus=2
"set softtabstop=8
set tabstop=8
set shiftwidth=8
"set expandtab
"set term=xterm

" ^R^R  Inserts the date
" ^R^T  Inserts the time
" ^R^D  Inserts the date & time
"imap <C-R><C-R>  <C-R>=strftime("[Hours Report] <%a-%d-%b-%y>")<CR>
"imap <C-R><C-L>  <C-R> LOG(LOG_ERROR, (char*)__PRETTY_FUNCTION__,);
imap <C-E> LOG(LOG_ERROR, (char*)__PRETTY_FUNCTION__,);
imap <C-T> LOG(LOG_TRACE, (char*)__PRETTY_FUNCTION__,);
"imap <C-R><C-R>  <C-R>=strftime("[Hours Report] %Y-%m-%d")<CR>
"imap <C-R><C-R>  <C-R>=strftime("[Hours Report] %Y-%m-%d")<CR>
"imap <C-R><C-T>  <C-R>=strftime("%H:%M")<CR>
"imap <C-R><C-D>  <C-R>=strftime("%d-%b-%y %H:%M")<CR>
"imap <C-R><C-E>  <C-R><C-T> \| \| eXpand \| @       <ESC>F@R
"imap <C-R><C-E>  <C-R><C-T> \| \| optiBase \|  <ESC>F@i
"imap <C-R><C-E>  <C-R><C-T> \| \| optiBase \|  <ESC>F@i
imap <C-K> /* XXX SK XXX */
"imap <C-D> printf("DEBUGG:SK %s %s:%d\n", __func__, __FILE__, __LINE__);
"imap <C-D> printf("DEBUGG:SK %s:%d\n", __func__, __LINE__);
imap <C-D> pr_err("DEBUGG:SK %s:%d\n", __func__, __LINE__);
"nnoremap <C-c> :cs find c <C-R>=expand("<cword>")<CR><CR> )
"nnoremap <C-s> :cs find s <C-R>=expand("<cword>")<CR><CR> )


let g:ctags_statusline=1
let g:generate_tags=1

"filetype plugin on

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1



"set   statusline=[%n]\ %f\ %(\ %M%R%H)%)
"set   statusline=[%n]\ %f\ %(\ %M%R%H)%)\ \ \ \ \ <%l\,%c%V>\ %P
syntax on
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

"OVS
au BufNewFile,BufRead */openvswitch/* set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
