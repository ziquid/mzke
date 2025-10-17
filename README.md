# mzke

A build tool framework with modular includes and a command-line interface.

## Two Components

### 1. mzke-includes (Framework)
The include files that projects use as a Git submodule:

```bash
# In your project
git submodule add <mzke-includes-url> mzke-includes
echo "include mzke-includes/Mzkefile" > Mzkefile
```

### 2. mzke (Tool)
The command-line tool that you install once:

```bash
# Install the tool
git clone <mzke-url>
cd mzke
sudo ./install.sh

# Now you can use it anywhere
mzke && mzke install
```

## Usage

1. Add mzke-includes as a submodule to your project
2. Create a minimal Mzkefile that includes the framework
3. Install the mzke tool once system-wide
4. Run `mzke && mzke install` in any project using the framework

## Structure

- `bin/mzke` - The command-line tool
- `install.sh` - Installation script
- `mzke-includes/` - The framework submodule (separate repo)