call plug#begin('~/.config/nvim/plugged')

" General {{{

    set nocompatible                " must put it in the first line
    set autoread                    " automatically reload files changed outside of Vim
    set history=1000                " change history to 1000
    set noshowmode                  " let lightline do the work
    set updatetime=300              " having longer updatetime (default is 4000ms) leads to noticeable delays
                                    " and poor user experience

    set hidden                      " allow moving away from a buffer with unsaved changes
    set nobackup                    " change the behavior of write
    set nowritebackup

    " Appearance
    set textwidth=120
    set cc=120                      " set an 120 column border for good coding style
    set wrap                        " turn on line wrapping
    set linebreak                   " set soft wrapping
    set number                      " always show line numbers
    set title                       " set terminal title
    set showmatch                   " set show matching parenthesis
    set scrolloff=5                 " keep 5 lines off the edges of the screen when scrolling
    set showcmd                     " show incomplete command
    set shortmess+=c                " dont't pass messages to |ins-completion-menu|
    set cursorline
    set termguicolors               " turn on terminal true color if supported
    set splitbelow splitright       " fix splitting

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
    else
        set signcolumn=yes
    endif

    " Enhanced command line completion
    set wildmenu                    " Enable enhanced tab autocomplete
    set wildmode=list:longest,full  " Complete till longest string, then open the wildmenu
    set backspace=indent,eol,start  " allow backspacing over everything in insert mode

    " Clipboard and mouse select
    set clipboard=unnamed,unnamedplus "Copy into system (*, +) register
    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase                  " ignore case when searching
    set smartcase                   " case-sensitive if expression contains a captial letter
    set hlsearch!                   " highlight search terms, use space to toggle
    set incsearch                   " show search matches as you type

    set gdefault                    " search/replace "globally" (on a line) by default
                                    " replace mode: use /g to toggle back to local(first appearance)
                                    " use /I to case-sensitive
    set magic                       " set magic on, for regex which is vim default
    set nowrapscan                  " stop macro wrapping back around

    if(has('nvim'))
        set inccommand=nosplit      " show results of substition as they're happening, but don't open a split
    endif

    " Try redrawing as fewer times as possible
    set lazyredraw
    set ttyfast

    " Tab control
    set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
    set shiftwidth=4                " number of spaces to use for autoindenting
    set tabstop=4                   " a tab is four spaces
    set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
    set expandtab                   " expand tabs by default (overloadable per file type later)
    set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
    set autoindent                  " always set autoindenting on
    set copyindent                  " copy the previous indentation on autoindenting

    " Fold setting
    set foldmethod=syntax           " fold code with syntax, use za to toggle folds
    autocmd BufRead * normal zR     " keep the folds open when opening new files, zR open all, zM close All

    " Remove trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e

" General }}}

" AutoGroups {{{

    " File type specific settings {{{

        augroup filetype_vim
            autocmd!
            " Fold vimrc based on marker
            auto FileType vim setlocal foldmethod=marker

            " Make quickfix windows take all the lower section of the screen
            " when there are multiple windows open
            auto FileType qf wincmd J
            auto FileType qf nmap <buffer> q :q<cr>
        augroup END

        augroup filetype_python
            autocmd!
            "fold python code based on indent
            auto FileType python setlocal foldmethod=indent nofoldenable
        augroup END

    " File type specific settings }}}

" AutoGroups }}}

" Mappings {{{

    " Map the leader key to a comma
    let mapleader=','

    "Edit .vimrc and Source .vimrc
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>

    noremap <leader>q :q<cr>        " quit a file with leader-q
    noremap <leader>w :w<cr>        " save a file with leader-w

    " Fast split navigtion with <Ctrl> + hjkl
    " <c-w>o only window
    " <c-w><shift-h/j/k/l> swap window
    noremap <c-h> <c-w><c-h>
    noremap <c-j> <c-w><c-j>
    noremap <c-k> <c-w><c-k>
    noremap <c-l> <c-w><c-l>

    " Maps Alt-h/j/k/l to resizing a window split
    noremap <silent><A-h> <C-w><
    noremap <silent><A-j> <C-w>-
    noremap <silent><A-k> <C-w>+
    noremap <silent><A-l> <C-w>>
    noremap <silent><A-=> <C-w>=

    " Maps zsh terminal in nvim,
    " use <i> or <a> to enter into insert mode, use <Ctrl+\><Ctrl+n> to switch back to normal mode
    noremap <leader>te :term<cr>
    noremap <leader>ts :split term://zsh<cr>
    noremap <leader>tv :vsplit term://zsh<cr>

    " Movement Motion
    " Using [''] or [``] to jumplist current buffer, <C-o> or <C-I> to jumplist global
    " Using [g,] or [g.] to jump between last edit
    noremap gl $
    noremap gh ^
    noremap gk H
    noremap gj L

    " Switch between current and last buffer
    nmap <leader>. <c-^>
    " Unload current buffer
    nmap <leader>B :bdelete<cr>
    " Open current buffer in a new tab
    nmap <silent> gTT :tab sb<cr>

    " Toggle cursor line
    nnoremap <leader>l :set cursorline!<cr>

    " toggle highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " Toggle spell checking, s for spell check
    " ]s move to next misspelled, [s vice versa, z= suggest, zg add to dict, zw vice versa
    map <leader>s :setlocal spell! spelllang=en_us<cr>

    " Toggle auto indent
    map <leader>i :setlocal autoindent! autoindent?<cr>

    " Enable and disable auto comment
    map <leader>c :setlocal formatoptions-=cro<cr>
    map <leader>C :setlocal formatoptions+=cro<cr>

" Mappings }}}

" Gruvbox {{{

    Plug 'morhetz/gruvbox'

" Gruvbox }}}

" Startify: {{{

    Plug 'mhinz/vim-startify'

    let g:startify_files_number = 10
    let g:startify_change_to_dir = 0                " Don't change to directory when selecting a file
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 0
    let g:startify_use_env = 0

    let g:startify_lists = [
    \  { 'type': 'files',     'header': [ '   MRU' ] },
    \  { 'type': 'dir',       'header': [ '   MRU_DIR '. getcwd() ] },
    \  { 'type': 'sessions',  'header': [ '   Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ '   Bookmarks' ]      },
    \  { 'type': function('helpers#startify#gitModified'),  'header': ['   Git Modified']},
    \  { 'type': function('helpers#startify#gitUntracked'), 'header': ['   Git Untracked']},
    \  { 'type': 'commands',  'header': [ '   Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \   { 'uc': [ 'Update CoC Plugins', ':CocUpdate' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim' },
        \ { 'g': '~/.gitconfig' },
        \ { 'z': '~/.zshrc' }
    \ ]

    autocmd User Startified setlocal cursorline
    nmap <leader>st :Startify<cr>

" }}}

" LightLine {{{

    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

    let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'active': {
        \       'left': [ [ 'mode', 'paste' ],
        \               [ 'gitbranch' ],
        \               [ 'readonly', 'filetype', 'filename' ]],
        \       'right': [ [ 'percent' ], [ 'lineinfo' ],
        \               [ 'fileformat', 'fileencoding' ],
        \               [ 'currentfunction',  'cocstatus' ]]
        \   },
        \ 'component_function': {
        \       'fileencoding': 'helpers#lightline#fileEncoding',
        \       'filename': 'helpers#lightline#fileName',
        \       'fileformat': 'helpers#lightline#fileFormat',
        \       'filetype': 'helpers#lightline#fileType',
        \       'gitbranch': 'helpers#lightline#gitBranch',
        \       'cocstatus': 'coc#status',
        \       'currentfunction': 'helpers#lightline#currentFunction',
        \   },
        \ 'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ [ 'close' ] ]
        \   },
        \ 'tab': {
        \       'active': [ 'filename', 'modified' ],
        \       'inactive': [ 'filename', 'modified' ],
        \   },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
    \}

" LightLine }}}

" Easymotion {{{

    "Activate with <leader><leader>

    Plug 'easymotion/vim-easymotion'

    nmap <leader><leader>f <Plug>(easymotion-overwin-f)
    nmap <leader><leader>j <Plug>(easymotion-overwin-line)
    nmap <leader><leader>k <Plug>(easymotion-overwin-line)
    nmap <leader><leader>w <Plug>(easymotion-overwin-w)

" Easymotion }}}

" Netrw {{{

    let g:netrw_banner = 0
    let g:netrw_liststyle = 3

" Netrw }}}

" NERDTree {{{

    Plug 'preservim/nerdtree'

    noremap <silent><leader>n :NERDTreeToggle<cr>      " toggle NERDTree with leader-n
    noremap <silent><leader>y :NERDTreeFind<cr>        " expand the path of the file in the current buffer

    " Autoclose NERDTree if it's the only open window left.
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree }}}

" Gundo {{{

    Plug 'sjl/gundo.vim'

    nnoremap <leader>u :GundoToggle<cr>

" Gundo }}}

" FZF {{{

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    let g:fzf_layout = { 'down': '25%' }

    " This is the default extra key bindings
    let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

    if isdirectory(".git")
        " if in a git project, use :GFiles
        nmap <silent> <leader>gf :GitFiles --cached --others --exclude-standard<cr>
    endif

    nmap <silent> <leader>b :Buffers<cr>
    nmap <silent> <leader>z :FZF<cr>
    nmap <silent> <leader>p :Snippets<cr>

    " Check mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-x><c-s> <plug>(fzf-complete-word)
    imap <c-x><c-p> <plug>(fzf-complete-path)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    nmap <silent> <leader>o :Files<cr>

    command! -bang -nargs=? -complete=dir GitFiles
        \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)

    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
    nmap <silent> <leader>r :RG<cr>

" FZF }}}

" Goyo {{{

    Plug 'junegunn/goyo.vim'

    autocmd! User GoyoEnter nested call helpers#goyo#enter()
    autocmd! User GoyoLeave nested call helpers#goyo#leave()

    nnoremap <leader>gy :Goyo<cr>

" Goyo }}}

" Limelight {{{

    Plug 'junegunn/limelight.vim'

    " Color name (:help cterm-colors) or ANSI code
    let g:limelight_conceal_ctermfg = 240

    " Color name (:help gui-colors) or RGB color
    let g:limelight_conceal_guifg = '#777777'

    " toggle Limelight
    nnoremap <leader>L :Limelight!!<cr>

" Limelight }}}

" Vim-fugitive {{{

    " usage with :G as :!git or :G<cr> to open git status
    " :G mappings: -    toggle stage or unstage
    "              =    toggle inline diff
    "              X    discard the change under the cursor, use with caution
    "              dv   perform :Gvdiffsplit on the file under the cursor in vim specific way
    "              o    open the file or fugitive-object under the cursor in hsplit
    "              go   open the file or fugitive-object under the cursor in vsplit
    "              cc   create a commit, exit with :wq for the commit to take place
    "              ca   amend the last commit and edit the message

    " :GBrowse  :Gvdiffsplit    :Git blame (with o opens a diff of the chosen commit in split window)   :Gclog
    Plug 'tpope/vim-fugitive'

    " Enables :GBrowse from fugitive.vim to open GitHub URLs
    " In commit messages, GitHub issues, issue URLs, and collaborators can be omni-completed <C-X><C-O> in insert mode
    Plug 'tpope/vim-rhubarb'

    " Maintain branching in Git into an interactive buffer
    " Provide basic merge and rebase support, stashing, and some other goddies
    Plug 'sodapopcan/vim-twiggy'
    nmap <silent><leader>gb :Twiggy<cr>

    " lightweight powerful git branch viewer
    " usage: <C-N> <C-P>    jump between commit with preview
    "        u              refresh the graph
    "        a              toggle viewing all branches
    "        gm             toggle displaying no merges
    "        gr             toggle viewing the reflog
    "        gb             toggle bisect mode
    Plug 'rbong/vim-flog'
    nmap <silent><leader>gc :Flog<cr>

" }}}

" UltiSnips {{{

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " Trigger configuration
    let g:UltiSnipsExpandTrigger="<C-l>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" }}}

" coc.nvim{{{

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    let g:coc_global_extensions = [
        \ 'coc-marketplace',
        \ 'coc-json',
        \ 'coc-sh',
        \ 'coc-jedi',
        \ 'coc-git',
        \ 'coc-pairs',
        \ 'coc-explorer',
        \ 'coc-diagnostic',
        \ 'coc-highlight'
        \ ]

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if exists('*complete_info')
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
        imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    " For enhanced <CR> experience with coc-pairs checkout :h coc#on_enter()
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>$ <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)
    " Format current buffer.
    nmap <leader>F <Plug>(coc-format)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " coc-git
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    nmap gs <Plug>(coc-git-chunkinfo)
    nmap gu :CocCommand git.chunkUndo<cr>

    " coc-explorer
    nnoremap <silent><leader>x :CocCommand explorer<CR>

    " Diagnostics navigation: Use `[c` and `]c` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader><leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <leader><leader>d  :<C-u>CocList diagnostics<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <leader><leader>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <leader><leader>s  :<C-u>CocList -I symbols<cr>
    " Resume latest coc list.
    nnoremap <silent><nowait> <leader><leader>r  :<C-u>CocListResume<CR>
" }}}

    Plug 'tpope/vim-vinegar'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mileszs/ack.vim'

    " Use gcc to comment out a line (takes a count), gc to comment out the target of a motion (for example, gcap to comment out a paragraph)
    " gc in visual mode to comment out the selection, and gc in operator pending mode to target a comment.
    Plug 'tpope/vim-commentary'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " automatically adjust 'shiftwidth' and 'expendtab'
    Plug 'tpope/vim-sleuth'

    " single/multi line code handler:
    " gS - split one line into multiple,
    " gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " paste with indentation adjusted
    Plug 'sickill/vim-pasta'

    " Adds filetype glyphs(icons) to various vim plugins
    Plug 'ryanoasis/vim-devicons'



call plug#end()

" Final setup {{{

    " These setup happen after the plug#end() call to ensure
    " that the colorschemes have been loaded and so on

    syntax on
    filetype plugin indent on       " allows ftplugin, auto-indenting depending on file type

    colorscheme gruvbox
    " transparent bg
    hi Normal guibg=NONE ctermbg=NONE

" Final setup }}}
