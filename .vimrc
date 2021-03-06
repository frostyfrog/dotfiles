"set number
syntax on
set modeline
set mouse=nv

"File type specific settings
au BufNewFile,BufRead *.ejs set filetype=html

"Droplets don't have utf-8 by default >_>
scriptencoding utf-8
set encoding=utf-8

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=eol:¶,tab:>-,trail:·,extends:>,precedes:<
if v:version > 704 || ( v:version == 704 && has('patch710') )
	set listchars+=space:ﾐ
	"set listchars+=space:｡
endif

set ts=2 sw=2 ai

if hostname() == 'Toronto'
	set rnu
	set list
endif

" Use LaTeX configuration if on Ogre
if hostname() == 'Ogre'
	"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	"% Set the following lines in your ~/.vimrc or the systemwide /etc/vimrc:
	"% filetype plugin indent on
	"% set grepprg=grep\ -nH\ $*
	"% let g:tex_flavor = "latex"
	"%
	"% Also, this installs to /usr/share/vim/vimfiles, which may not be in
	"% your runtime path (RTP). Be sure to add it too, e.g:
	"% set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
	"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	filetype plugin indent on
	set grepprg=grep\ -nH\ $*
	let g:tex_flavor = "latex"
	set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
endif

let b:domainhost = split(hostname(), '\.')
if len(b:domainhost) >= 1 && b:domainhost[0] == 'ipa'
	set list ts=4 sw=4 et
endif

function SmoothScroll(up)
	if a:up
		let scrollaction=""
	else
		let scrollaction=""
	endif
	exec "normal " . scrollaction
	redraw
	let counter=1
	while counter<&scroll
		let counter+=1
		sleep 10m
		redraw
		exec "normal " . scrollaction
	endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

"nnoremap <F5> m'A<C-R>="\t".strftime('%Y-%m-%d %H:%M')<CR><Esc>``
nnoremap <F5> m'A<C-R>="\t".strftime('%a %b %e %H:%M:%S %Z %Y')<CR><Esc>``

"let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
let &titlestring = "vim(" . expand("%:t") . ")"
let &titleold="-vim"
if &term == "screen" || &term == "screen-256color"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term == "xterm" || &term == "screen-256color"
  set title
endif

au BufRead,BufNewFile *.less setfiletype css

" Line 80 "Helpful Correction Reminder"
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
highlight Search term=reverse ctermfg=15 ctermbg=4 guibg=Yellow
match OverLength /\%81v.\+/

" Vundle Stuff "{{{
filetype off
"set rtp+=~/.vim/nonbundle
"set rtp+=~/.vim/bundle/vundle
set rtp+=~/.vim/autoload
"call vundle#rc()

" Bundles!
"Bundle 'gmarik/vundle'
"Bundle 'msanders/snipmate.vim'
"Bundle 'Lokaltog/vim-powerline', {'rtp': 'powerline/bindings/vim/'}
" Arch disabled python
"Bundle 'szw/vim-tags'
"Bundle 'hynek/vim-python-pep8-indent'

"C++ autocomplete
"Bundle 'Valloric/YouCompleteMe'

"Powerline Support
"Note:
"http://makandracards.com/jan0sch/18283-enable-powerline-fonts-with-rxvt-unicode-and-vim-airline
"Bundle 'bling/vim-airline'

" Vim Golang Support
"Bundle 'fatih/vim-go'

" Vim better js support
"Bundle 'pangloss/vim-javascript'

" Vim Snip-Mate {{{
	"Bundle "MarcWeber/vim-addon-mw-utils"
	"Bundle "tomtom/tlib_vim"
	"Bundle "garbas/vim-snipmate"

	" Optional:
	"Bundle "honza/vim-snippets"
" }}}

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status != 'installed' || a:info.force
		if hostname() == 'frostydev'
			!./install.sh --clang-completer --gocode-completer
		else
			!./install.sh --clang-completer --system-libclang --system-boost --gocode-completer
		endif
  endif
endfunction

call plug#begin()
	" Alignment
	Plug 'junegunn/vim-easy-align'
	" The below doesn't work
	" Bundle 'junegunn/vim-easy-align'
	
	"Powerline Support
	"Note:
	"http://makandracards.com/jan0sch/18283-enable-powerline-fonts-with-rxvt-unicode-and-vim-airline
	Plug 'bling/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'szw/vim-tags'
	Plug 'hynek/vim-python-pep8-indent'

	" .editorconfig support
	Plug 'editorconfig/editorconfig-vim'

	" Vim better js support
	Plug 'pangloss/vim-javascript'

	Plug 'tpope/vim-surround'
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	" Tmux
	Plug 'tpope/vim-tbone'

	" Buffer Explorer :help bufexplorer
	Plug 'jlanzarotta/bufexplorer'

	" Auto :set paste and :set nopaste when pasting
	Plug 'roxma/vim-paste-easy'

	" Base64 encode/decode
	Plug 'christianrondeau/vim-base64'

	" Git
	Plug 'tpope/vim-fugitive'

	Plug 'raymond-w-ko/vim-lua-indent'

	" Syntastic code completion GUI
	"Plug 'scrooloose/syntastic'

	" Code to execute when the plugin is loaded on demand
	if hostname() == 'frostydev' || hostname() == 'pythondev'
		Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'commit': '61b5aa76fecd50f6aae5bd787a7b2231b26374b2' }
		"Plug 'davidhalter/jedi-vim'
	else
		"Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'go'], 'do': function('BuildYCM'), 'on': 'YcmRestartServer' }
		Plug 'Valloric/YouCompleteMe', { 'for': ['html', 'cpp', 'c', 'go'], 'do': function('BuildYCM') }
		"Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'go'], 'do': function('youcompleteme#Enable') }
	endif

	" CScope
	"Plug 'http://cscope.sourceforge.net/cscope_maps.vim', { 'as': 'cscope', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }

	"autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif

	" Plugin completion using VimAwesome API
	"Plug 'https://gist.github.com/5dff641d68d20ba309ce.git'
	"			\ { 'as': 'VimAwesome', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }
	
	if v:version >= 700
		" Group dependencies, vim-snippets depends on ultisnips
		Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
		let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
		let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
		let g:ycm_server_keep_logfiles = 1
		let g:ycm_server_log_level = 'debug'
		let g:ycm_show_diagnostics_ui = 0
		let g:ycm_key_invoke_completion = '<C-Z>'
		let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
		let g:ycm_seed_identifiers_with_syntax = 1

		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<tab>"
		let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	endif
	
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	let NERDTreeIgnore=['\.vim$', '\~$', '\.o$']

	" Conque Shell - Shell for vim
	Plug 'frostyfrog/conque'

	" Vimwiki - A Personal Wiki For Vim
	Plug 'vimwiki/vimwiki'

	" Browser for ctags
	Plug 'vim-scripts/taglist.vim'

	" Vim golang shorcuts and bindings
	Plug 'fatih/vim-go'

	autocmd! User YouCompleteMe call youcompleteme#Enable()
	" If you prefer the Omni-Completion tip window to close when a selection is
	" made, these lines close it on movement in insert mode or when leaving
	" insert mode
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
call plug#end()
	let g:go_fmt_command = "goimports"
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	autocmd BufWritePost *.go :GoBuild
	autocmd BufWritePost *_test.go :GoTest
endif

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

filetype indent on
filetype plugin indent on
" "}}}
" Airline Config {{{

let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 3
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline_theme="simple"
function! AirlineInit()
	call airline#parts#define_raw('linenr', '%l')
	call airline#parts#define_accent('linenr', 'bold')
	let g:airline_section_z = airline#section#create(['%3p%%', g:airline_symbols.linenr, 'linenr', ':%c%V'])
endfunction
autocmd VimEnter * call AirlineInit()
set laststatus=2

" }}}

" Airline Config {{{
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
hi Search cterm=NONE ctermfg=white ctermbg=darkblue
hi DiffRemoved term=bold ctermfg=197 guifg=Orange
hi DiffAdded term=bold ctermfg=73 guifg=Teal
" }}}

" Return to our last position in the file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" TODO implement this when I get a chance
"
" In your vimrc you can read an environment variable to allow
" different command depending on which OS or PC you're on and
" thus have same vimrc.
"
"if $USER == 'davidr'
"	echo "on home pc"
"	set .. etc
"else
"	echo "on work pc"
"	set .. etc
"endif
"raise PSAPIException(msg = 'Debugging: %s' % e,
"            code = 500,
"            info = 'Debugging: %s' % e)
let @b="oexcept Exception, e:raise PSAPIException(msg = 'Debugging: %s' % e,code = 500,info = 'Debugging: %s' % e)kuku"
set nolist
match

" ##    ## ######## ##    ##  ######  
" ##   ##  ##        ##  ##  ##    ## 
" ##  ##   ##         ####   ##       
" #####    ######      ##     ######  
" ##  ##   ##          ##          ## 
" ##   ##  ##          ##    ##    ## 
" ##    ## ########    ##     ######  

" Splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright
vnoremap <f2> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>

" ##    ##  #######  ######## ########  ######
" ###   ## ##     ##    ##    ##       ##    ##
" ####  ## ##     ##    ##    ##       ##
" ## ## ## ##     ##    ##    ######    ######
" ##  #### ##     ##    ##    ##             ##
" ##   ### ##     ##    ##    ##       ##    ##
" ##    ##  #######     ##    ########  ######
"
" Match command and syntax
" http://vimdoc.sourceforge.net/htmldoc/pattern.html#:match
"
" TODO: Create a function that puts this in the current buffer:
" :echo system("strings -n 1 < /dev/urandom | tr -cd '[[:alnum:]]'  | head -c30")

let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
"let wiki_1.html_template = '~/vimwiki/templates/template.tpl'
let wiki_1.css_name = 'style.css'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

let wiki_2 = {}
let wiki_2.path = '~/project_docs/'
let wiki_2.index = 'main'

let g:vimwiki_list = [wiki_1, wiki_2]

" g:vimwiki_list [
" {'maxhi': 0,
" 'css_name': 'style.css',
" 'auto_export': 0,
" 'diary_index': 'diary',
" 'template_default': 'default',
" 'nested_syntaxes': {},
" 'auto_toc': 0,
" 'auto_tags': 0,
" 'diary_sort': 'desc',
" 'path': '/home/colton/vimwiki/',
" 'diary_link_fmt': '%Y-%m-%d',
" 'template_ext': '.tpl',
" 'syntax': 'default',
" 'custom_wiki2html': '',
" 'automatic_nested_syntaxes': 1,
" 'index': 'index',
" 'diary_header': 'Diary',
" 'ext': '.wiki',
" 'path_html': '/home/colton/vimwiki_html/',
" 'temp': 0,
" 'template_path': '/home/colton/vimwiki/templates/',
" 'list_margin': -1,
" 'diary_rel_path': 'diary/'}
" ]

" TODO: Move this to it's own plugin
function! s:generate_diff()
	let filetype=&ft
	let my_view = winsaveview()
	exe "%y p"
	" TODO: Figure out how to delete the last line when we do the put
	vnew | exe "put! p" | exe '%!diff -aur ' . expand("#:p") . ' -'
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=diff"
endfunction
command! Diff silent! call s:generate_diff()

function! s:make_executable()
	" Set scripts to be executable from the shell
	au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
endfunction
command! EX silent! call s:make_executable()
