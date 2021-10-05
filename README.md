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

If you're setting up a Mac for the first time, run the `macos_setup.sh` script.

### Create Symlinks Using GNU Stow
Use `stow` to easily create symlinks for mulitple files at a time. Just `cd` to the directory and use `stow` to link these files. By default, the command creates links one level up in the tree for all the files within the specified directory.

For example, in `~/.dotfiles/` run the following commands:

```
$ stow bash
$ stow vim
$ stow zsh
```

to create `~/.bash_profile@`, `~/.bashrc@`, `~/.vimrc@`, `~/.zshenv@`, and `~/.zshrc@`.

### Create Symlinks Manually

If you don't want to use `stow`, you can also create the links manually. Using directories as in the previous example, from your home directory, run the following commands:

```
$ ln -s .dotfiles/bash/.bash_profile .bash_profile
$ ln -s .dotfiles/bash/.bashrc .bashrc
$ ln -s .dotfiles/vim/.vimrc .vimrc
$ ln -s .dotfiles/zsh/.zshenv .zshenv
$ ln -s .dotfiles/zsh/.zshrc .zshrc
```

### Run the Setup Script (macOS)

Run the script to set up System Preferences and hidden settings for macOS:

```
$ ./macos_setup.sh
```

## Acknowledgements
Credit to Brandon Invergo ([Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)) and Jon Leopard ([Dotfile Management With GNU Stow](https://jonleopard.com/blog/dotfile-management-with-gnu-stow/)) for the helpful blog posts that taught me this approach. Credit to Quentin Giraud ([aethys256/notes](https://github.com/aethys256/notes)) for many of the macOS defaults tweaks.
