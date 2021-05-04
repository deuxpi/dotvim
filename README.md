# .vim configuration

<img src="https://raw.githubusercontent.com/deuxpi/dotvim/main/screenshot.png">

Clone this repository in a directory named `.vim` in your home directory (hence
the name "dotvim"). Create a symbolic link from the `vimrc` file to a file
named `.vimrc` in your home directory.

For example:

    deuxpi@laptop:~$ cd
    deuxpi@laptop:~$ git clone https://github.com/deuxpi/dotvim.git .vim
    Cloning into '.vim'...
    ...
    deuxpi@laptop:~$ ln -s .vim/vimrc .vimrc
    deuxpi@laptop:~$ vim


When you're ready, launch Vim and use the `:PlugInstall` command to install all the plug-ins.
