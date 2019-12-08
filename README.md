# .dotfiles

Config files for my environment.

## Prerequisites
* [GNU Stow](https://www.gnu.org/software/stow/) (optional). Use stow to easily create links to these files in your home directory.

## Installing
In your home directory, clone the repository:
```
$ git clone git@github.com:neapsix/.dotfiles.git
```

Then, create symlinks in your home directory to the files.

### Create Symlinks Using GNU Stow
Use `stow` To easily create symlinks for mulitple files at a time. Just `cd` to the directory and use stow to link these files. By default, stow creates links one level up in the tree for all the files within the specified directory.

For example, in `˜/.dotfiles/` run

```
$ stow bash
$ stow vim
```

to create `˜/.bash_profile@`, `˜/.bashrc@`, and `˜/.vimrc@`.

### Create Symlinks Manually

If you don't want to use `stow`, you can also create the links manually. Using directorys as in the previous example, from your home directory, run:

```
$ ln -s .dotfiles/bash/.bash_profile .bash_profile
$ ln -s .dotfiles/bash/.bashrc .bashrc
$ ln -s .dotfiles/vim/.vimrc .vimrc
``` 

## Acknowledgements
Credit to Brandon Invergo ([Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html))  and Jon Leopard ([Dotfile Management With GNU Stow](https://jonleopard.com/blog/dotfile-management-with-gnu-stow/)) for the helpful blog posts that taught me this approach.
