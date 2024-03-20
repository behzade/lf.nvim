# lf.nvim
small neovim plugin to replace netrw with lf terminal file manager
## Installation
This plugin depends on [nvim-unception](https://github.com/samjwill/nvim-unception) to avoid creating nested neovim instances.

Lazy.nvim:
```lua
return {
    "behzade/lf.nvim",
    dependencies = {
        "samjwill/nvim-unception",
    },
}
```

## Usage
This plugins adds a few autocmds to hijack opening directories in neovim and deleting terminal buffers when they are closed to make working with terminal buffers more smooth. If these defaults cause any compatibility issues with other plugins or settings, please create an issue.
