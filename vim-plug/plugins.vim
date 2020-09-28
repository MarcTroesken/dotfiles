" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/NERDTree'
    Plug 'jiangmiao/auto-pairs'
    Plug 'joshdick/onedark.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'joshdick/onedark.vim'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'posva/vim-vue'
    Plug 'mattn/emmet-vim'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'StanAngeloff/php.vim'
    Plug 'cakebaker/scss-syntax.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'noahfrederick/vim-laravel'
    Plug 'mg979/vim-visual-multi'
    Plug 'arnaud-lb/vim-php-namespace'
    Plug 'airblade/vim-gitgutter'

call plug#end()
