# .dotfiles/nvim

My configuration for Neovim.

## Installation
Deploy the configuration as described in the main README. The first time you use Neovim, run `:PaqSync` to install, remove, or update plugins.

## How It Works
The configuration is broken up into modules, which are loaded from the main `init.lua` file. Each module is either a lua file or a directory containing its own `init.lua` file. 

Modules are loaded by running `require('path.to.module')`. To load a lua file, enter the file name without the file extension. To load a directory, make sure it contains an `init.lua` file, and enter the directory name.

Modules under `core` contain configuration for Neovim itself. The `plugins` module sets up the package manager and loads sub-modules containing configuration for individual plugins.

## Benchmarking
To accurately measure startup time, use `hyperfine "nvim +q"`. To see how long each part takes, use the built-in option: `nvim --startuptime /path/to/file`.

## Acknowledgements
Credit to /u/shaunsingh0207 on Reddit ([\[Guide\] Tips and tricks to reduce startup and Improve your lua config](https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/)) for the guide that taught me this approach.
