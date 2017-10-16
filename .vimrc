set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugin/prtdialog.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'carakan/new-railscasts-theme'
call vundle#end()
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_chalk'
let g:airline#extensions#tabline#enabled = 1
set number
filetype plugin indent on
set laststatus=2
set t_Co=256

colorscheme google
set background=light
set pdev=pdf
set printoptions=paper:letter,syntax:y,wrap:y,duplex:off,number:y
set printfont=monofur\ for\ Powerline:h10
set tabstop=4
hi Normal guibg=NONE ctermbg=NONE


