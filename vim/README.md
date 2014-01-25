vim-settings
============

Vim settings for use across different computers

Install
=======

Install vundle:
        
    git clone https://github.com/gmarik/vundle.git bundle/vundle

Install all of the plugins:
    
    vim +BundleInstall +qall

Build vimproc:
    
    cd ./bundle/vimproc.vim/
    make

Dependencies:
=============

 - vim compiled with +python
 - pip
 - pep8
 - exuberant-ctags
 - ruby
 - rake
 - pytest
 - nose
 - ack
 - pyflakes
 - powerline
 - CoffeeTags

Haskell stuff:
==============

Update cabal

    cabal update

Add cabal bin files to PATH

    echo "export PATH=$PATH:$HOME/.cabal/bin" >> ~/.bashrc

Install ghc-mod
    
    cabal install ghc-mod