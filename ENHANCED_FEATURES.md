# Enhanced Kickstart.nvim Features

This enhanced version of kickstart.nvim includes modern plugins and improved configuration while maintaining the educational spirit of the original.

## 🎨 Modern UI & Theming

### Catppuccin Theme
- **Plugin**: `catppuccin/nvim`
- **Features**: Beautiful pastel theme with excellent syntax highlighting
- **Integration**: Works seamlessly with all other plugins
- **Customization**: Easy to switch between flavours (latte, frappe, macchiato, mocha)

### Enhanced Status Line (Lualine)
- **Plugin**: `nvim-lualine/lualine.nvim`
- **Features**: 
  - Git branch and diff information
  - LSP diagnostics display
  - File encoding and format
  - Search count display
  - Integrated with catppuccin theme

### Buffer Management (Bufferline)
- **Plugin**: `akinsho/bufferline.nvim`
- **Features**:
  - Beautiful buffer tabs
  - Buffer pinning and grouping
  - LSP diagnostics integration
  - Mouse support
- **Keybindings**:
  - `[b` / `]b` - Navigate between buffers
  - `<leader>bp` - Toggle buffer pin
  - `<leader>bo` - Close other buffers

## 🔍 Enhanced Code Navigation

### Improved Telescope
- **Enhanced defaults**: Better layout and ignore patterns
- **Performance**: Optimized file search
- **UI**: Dropdown theme for file/buffer pickers
- **Custom mappings**: Improved fuzzy search behavior

### Diagnostics & Quickfix (Trouble.nvim)
- **Plugin**: `folke/trouble.nvim`
- **Features**:
  - Beautiful diagnostics viewer
  - LSP references and definitions
  - Quickfix and location list management
- **Keybindings**:
  - `<leader>xx` - Toggle diagnostics
  - `<leader>xX` - Buffer diagnostics
  - `<leader>cs` - Symbols
  - `<leader>cl` - LSP definitions/references

## 💻 Developer Experience

### Smart Commenting (Comment.nvim)
- **Plugin**: `numToStr/Comment.nvim`
- **Features**:
  - Treesitter integration for context-aware commenting
  - Support for multiple comment styles
  - Visual mode support
- **Keybindings**:
  - `gcc` - Toggle line comment
  - `gbc` - Toggle block comment
  - `<leader>/` - Toggle comment (normal/visual)

### Text Object Manipulation (nvim-surround)
- **Plugin**: `kylechui/nvim-surround`
- **Features**:
  - Add/change/delete surrounding characters
  - Custom surrounds for functions and HTML tags
  - Visual mode support
- **Usage**:
  - `ys{motion}{char}` - Add surround
  - `cs{target}{replacement}` - Change surround
  - `ds{char}` - Delete surround

### Code Formatting (Conform.nvim)
- **Plugin**: `stevearc/conform.nvim`
- **Features**:
  - Multiple formatter support per language
  - Format on save (toggleable)
  - Visual range formatting
  - LSP fallback support
- **Supported Languages**:
  - **Lua**: stylua
  - **Python**: black, isort
  - **JavaScript/TypeScript**: prettier/prettierd
  - **Web**: CSS, HTML, JSON, YAML
  - **Other**: Rust, Go, Shell scripts
- **Keybindings**:
  - `<leader>f` - Format buffer
  - `<leader>F` - Format selection (visual mode)

### Terminal Integration (ToggleTerm)
- **Plugin**: `akinsho/toggleterm.nvim`
- **Features**:
  - Floating, horizontal, and vertical terminals
  - Multiple terminal management
  - Integration with common tools (lazygit, htop)
- **Keybindings**:
  - `<C-\>` - Toggle terminal
  - `<leader>tt` - Toggle terminal
  - `<leader>tf` - Floating terminal
  - `<leader>gg` - LazyGit integration

## 🛠️ Language Support

### Enhanced LSP Configuration
**Enabled Language Servers**:
- **Web Development**: TypeScript/JavaScript, HTML, CSS, JSON
- **Python**: Pyright
- **Rust**: rust-analyzer
- **Go**: gopls
- **C/C++**: clangd
- **Lua**: lua_ls (with enhanced Neovim support)

### Enhanced Treesitter
**Additional Language Parsers**:
- Web: JavaScript, TypeScript, TSX, CSS, SCSS, HTML
- Data: JSON, YAML, TOML, SQL
- Languages: Python, Rust, Go, Java, C++
- Config: Dockerfile, Git files

### Mason Tool Installation
**Automatically installed tools**:
- **Formatters**: stylua, prettier, black, isort
- **Linters**: eslint_d, shellcheck
- **Language Servers**: All configured LSPs

## ⚡ Performance Optimizations

### Lazy Loading
- All plugins are configured with appropriate lazy loading
- Event-based loading for optimal startup time
- Smart dependency management

### Optimized Defaults
- Improved telescope performance with file ignore patterns
- Global statusline for better performance
- Efficient buffer management

## 🎯 Enhanced Existing Features

### Improved File Explorer (Neo-tree)
- **Enabled by default**
- **Keybinding**: `\` to toggle
- **Integration**: Works with bufferline and lualine

### Enhanced Git Integration
- **gitsigns**: Enabled with recommended keymaps
- **LazyGit**: Integrated via toggleterm

### Auto-pairs
- **Enabled by default**
- **Smart pairing**: Context-aware bracket/quote pairing

### Indent Guides
- **Enabled by default**
- **Visual enhancement**: Better code structure visibility

## 📚 Educational Features

### Comprehensive Comments
- Every plugin configuration includes detailed explanations
- Educational comments explain why features are useful
- Links to documentation and further reading

### Modular Organization
- Each major plugin has its own file in `lua/custom/plugins/`
- Easy to understand and modify individual features
- Clear separation of concerns

### Gradual Enhancement
- Builds upon kickstart.nvim's foundation
- Maintains backward compatibility
- Educational progression from basic to advanced features

## 🚀 Getting Started

1. **Clone the repository**
2. **Start Neovim** - All plugins will be automatically installed
3. **Wait for installation** - Lazy.nvim will download and configure everything
4. **Explore features** - Use `<leader>?` (which-key) to discover keybindings
5. **Customize** - Modify plugin configurations in `lua/custom/plugins/`

## 🔧 Customization

### Disabling Features
- Comment out plugin requires in `init.lua`
- Remove individual plugin files from `lua/custom/plugins/`
- Use plugin configuration options to disable specific features

### Adding More Plugins
- Add new `.lua` files in `lua/custom/plugins/`
- Follow the established pattern of comprehensive documentation
- Consider lazy loading for optimal performance

### Theme Customization
- Modify `lua/custom/plugins/catppuccin.lua`
- Switch between light/dark variants
- Customize highlight groups and integrations

This enhanced configuration provides a modern, full-featured development environment while maintaining the educational and hackable nature of kickstart.nvim.