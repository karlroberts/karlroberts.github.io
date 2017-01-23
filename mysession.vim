let SessionLoad = 1
if &cp | set nocp | endif
nnoremap <silent>  :wincmd h
let s:cpo_save=&cpo
set cpo&vim
nnoremap <silent> <NL> :wincmd j
nnoremap <silent>  :wincmd k
nnoremap  :nohlsearch
nnoremap  bveU
noremap <silent> ,fn :cn
noremap <silent> ,ff :echom "wanker"|:cf target/quickfix/sbt.quickfix
nnoremap ,p :cprevious
nnoremap ,n :cnext
nnoremap ,sv :source $MYVIMRC
nnoremap ,` :vsplit $MYVIMRC
nnoremap / /\v
nnoremap ? ?\v
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
onoremap il{ :normal! F}vi{
onoremap in{ :normal! f{vi{
onoremap il( :normal! F)vi(
onoremap in( :normal! f(vi(
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <Right> <Nop>
nnoremap <Left> <Nop>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <F8> :TagbarToggle
nnoremap <silent> <F2> :TlistToggle
inoremap  bveUea
iabbr tehn then
iabbr waht what
iabbr adn and
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m,,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m,,%-G%.%#
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set hlsearch
set incsearch
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,~/.vim/bundle/potion,~/.vim/bundle/scala,~/.vim/bundle/taglist,~/.vim/bundle/vim-sbt,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set shiftwidth=2
set showmatch
set smartindent
set softtabstop=2
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tags=tags,./tags,~/tags/commontags
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/octopress
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 source/_posts/2014-07-06-google-contacts-api-service-account-howto.markdown
badd +1 source/_posts/2014-07-16-micro-dot-single-file-webapps.markdown
badd +31 source/_posts/2015-03-03-batch-size-for-software.markdown
badd +18 ~/.vimrc
badd +77 source/_posts/2015-03-11-e-do-part-1.markdown
badd +38 source/_posts/2015-06-16-testing-angular-dot-js-at-the-console.markdown
badd +56 source/_posts/2015-06-27-passwordless-ssh-on-synology.markdown
badd +1 source/_posts/2015-09-01-working-with-terraform-remote-statefile.markdown
badd +116 source/_posts/2016-01-14-using-javascript-in-octopress.markdown
badd +1 source/_posts/2017-01-09-disabling-usb-ports-on-linux.markdown
badd +1 source/_posts/2017-01-11-reusable-d3-chart-components-in-angular2.markdown
badd +10 source/_posts/2017-01-11-extract-helper-funcs-to-private-npm-modules.markdown
badd +13 source/_posts/2017-01-11-automounting-s3fs.markdown
badd +1 source/_posts/2017-01-11-using-octopus-to-deploy-to-linux.markdown
badd +37 source/_posts/2017-01-12-howto-correctly-extend-a-prototype-in-typescript.markdown
badd +23 source/_posts/2017-01-13-system-dot-js-gotcha-404-get-slash-traceur.markdown
badd +45 source/_posts/2017-01-17-correct-way-to-add-d3-libs-and-types-to-angular-dot-js-with-system-dot-js.markdown
argglobal
silent! argdel *
edit source/_posts/2017-01-11-automounting-s3fs.markdown
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=80
setlocal colorcolumn=80
setlocal comments=fb:*,fb:-,fb:+,n:>
setlocal commentstring=>\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'markdown'
setlocal filetype=markdown
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^[-*+]\\s\\+
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'markdown'
setlocal syntax=markdown
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 31 - ((30 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
31
normal! 0306|
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
