# .vim configuration

Clone this repository in a directory named `.vim` in your home directory (hence
the name "dotvim"). Create a symbolic link from the `vimrc` file to a file
named `.vimrc` in your home directory. Finally, load the git submodules.

For example:

    phil@laptop:~$ git clone https://github.com/deuxpi/dotvim.git .vim
    Cloning into '.vim'...
    ...
    phil@laptop:~$ ln -s .vim/vimrc .vimrc
    phil@laptop:~$ cd .vim
    phil@laptop:~/.vim(master)$ git submodule update --init --recursive
    Submodule 'bundle/YouCompleteMe' (git@github.com:Valloric/YouCompleteMe.git) registered for path 'bundle/YouCompleteMe'
    Submodule 'bundle/flake8' (git@github.com:nvie/vim-flake8.git) registered for path 'bundle/flake8'
    Submodule 'bundle/pathogen' (https://github.com/tpope/vim-pathogen.git) registered for path 'bundle/pathogen'
    Submodule 'bundle/vim-colors-solarized' (git://github.com/altercation/vim-colors-solarized.git) registered for path 'bundle/vim-colors-solarized'
    ...
