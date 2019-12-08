# .dotfiles

Config files for my environment.

### Prerequisites
stow (optional). Use stow to easily create links to these files in your home directory.

### Installing
In your home directory, clone the repository:
```
$ git clone git@github.com:neapsix/.dotfiles.git
```

Then, `cd` to the directory and use stow to link these files. By default, stow creates links one level up in the tree for all the files within the specified directory.
```
$ stow bash
$ stow vim
```
... and so on.
