# kickstart.nvim-FreeBSD

## Introduction

A FreeBSD-optimized fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that is:

* Small
* Single-file
* Completely Documented
* **FreeBSD-Native**: Configured to use system packages instead of Mason auto-install

**NOT** a Neovim distribution, but instead a starting point for your configuration tailored for FreeBSD.

## What's Different from Original Kickstart

This fork includes FreeBSD-specific modifications:
- **No Mason auto-compilation**: Uses system `pkg` packages instead
- **Tree-sitter support**: Configured to use system tree-sitter libraries
- **Tested on FreeBSD**: All plugins verified to work on FreeBSD systems
- **Pre-install script**: Automated dependency installation via `install-freebsd.sh`

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

#### FreeBSD (Recommended for FreeBSD users)

Use the provided installation script to automatically install all dependencies:

```sh
sudo sh install-freebsd.sh
```

Or manually install dependencies:

```sh
sudo pkg update -f
sudo pkg install -y git gmake unzip llvm ripgrep fd-find tree-sitter stylua base64-by-elvis node npm
```

**Note:** `lua-language-server` is not available in FreeBSD pkg repositories, so LSP support for Lua is disabled in this config.

#### Other External Requirements

- Basic utils: `git`, `gmake` (FreeBSD uses gmake instead of make), `unzip`, C Compiler (clang via `llvm`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel or xclip-freebsd)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - If you want markdown live preview, you need `node` and `npm`
  - etc.

### Install Kickstart.nvim-FreeBSD

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configuration location on FreeBSD:

```
~/.config/nvim
```

#### Clone the Repository

```sh
git clone https://github.com/YOUR_USERNAME/kickstart.nvim-freebsd.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
cd ~/.config/nvim
```

#### Install Dependencies

Run the automated install script:

```sh
sudo sh install-freebsd.sh
```

#### Start Neovim and Sync Plugins

```sh
nvim
```

Inside Neovim, run:

```vim
:Lazy sync
```

Wait for plugins to finish installing, then restart Neovim.

### Getting Started

Read through the `init.lua` file in your configuration folder for more information about extending and exploring Neovim.

#### Markdown Writing

This config includes built-in support for editing and previewing technical articles:
- **Syntax & Math Highlighting**: `vim-markdown` handles syntax highlighting, frontmatter, and math support. Single `$...$` and double `$$...$$` math syntax is fully supported for highlight and structure awareness. Note that the actual math rendering happens in the browser preview.
- **Live Preview**: Toggle a live browser preview with `<leader>mp` (runs `:MarkdownPreviewToggle`). This relies on `markdown-preview.nvim` which requires `node` and `npm` installed.

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-freebsd` and create an alias:
    ```
    alias nvim-freebsd='NVIM_APPNAME="nvim-freebsd" nvim'
    ```
    When you run Neovim using `nvim-freebsd` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-freebsd`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)


