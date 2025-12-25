# mzke (ZDS make tool)

A build tool framework with modular includes and a command-line interface.

## Requirements

- [GMSL](https://github.com/jgrahamc/gmsl/) (GNU Make Standard Library) is included as a git submodule and initialized automatically when you run `mzke install`

## Installation

- First time requires sudo and calling the bin directly:

    ```sh
    sudo src/bin/mzke install
    ```
    
- Subsequent times (updates, etc.) can use a simpler method:

   ```sh
   mzke install
   ```

## Usage

### As a standalone `make` wrapper

- Can be used in place of `make` with the following caveats:

1. Will append a target `all` if no target is found on the command line, i.e. `mzke` is interpreted as `make all`, regardless of first target in Makefile.

### With enhanced features

TK

### `mk` includes usage

#### Quick start

From your project root, follow these steps:

1. Copy new `Mzkefile` from `/usr/local/share/mzke/Mzkefile.example`

   ```sh
   cp /usr/local/share/mzke/Mzkefile.example Mzkefile 
   # Can be edited, but usually is not
   ```

1. Symlink (or copy) `mk` to the shared `mk` folder (1)

    ```sh
    ln -s /usr/local/share/mzke/mk .
    # or: cp -a /usr/local/share/mzke/mk .
    ```

1. (Optional) create an &lt;app-name&gt;.inc.mk file to control build behaviors

   ```sh
   cp mk/defaults.inc.mk <app-name>.inc.mk
   # then edit to taste
   ```

#### Feature list

Full list TK.

1. Run `mzke help` to list targets from included features you added in &lt;app-name&gt;.inc.mk

   ```sh
   mzke help
   ```

1. Run `mzke describe-features` to briefly describe all features files.

   ```sh
   mzke describe-features
   ```
