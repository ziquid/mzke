# mzke (ZDS make tool)

A build tool framework with modular includes and a command-line interface.

## Two Components

### 1. Optional but recommended: mzke-includes (build and installation framework)

This is a set of include files that projects use, included as a Git submodule:

```bash
# In your project
git submodule add <mzke-includes-url> mk
```

It is controlled by a *<dirname>.inc.mk* file in your project root, see `mzke.inc.mk` for an example.

### 2. mzke (this tool)

The command-line tool that you install once:

```bash
# Install the tool
git clone <mzke-url>
cd mzke
./mzke install # first time use needs ./

# Now you can use it anywhere
mzke && mzke install
```
