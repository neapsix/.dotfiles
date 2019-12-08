"
" ~/.vimrc
"

" General

set ruler

" Use four-space soft-tabs (sts) and auto-indents (sw). Use spaces instead of 
" tabs (expandtab), but if you were to see a tab, use width 8 (ts).
set ts=8 sts=4 sw=4 expandtab

" Plug-ins

" Bootstrap vim-plug plugin manager if it isn't installed.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Load exactly one plug-in.
Plug 'tpope/vim-sensible'

" Load some color scheme options.
Plug 'arcticicestudio/nord-vim'
" Plug 'andrwb/vim-lapis256'

call plug#end()

" Color schemes and plug-in-specific options

colorscheme nord
" colorscheme lapis256
