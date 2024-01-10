# Develop on Unreal Engine 5.3 with Neovim

## Quickstart
Install with your favorite plugin manager

Packer:
```lua
use 'goopey7/unreal-support.nvim'
```

In your `init.lua` add this line
```lua
require("unreal-support").setup()
```

### Options for `setup()`
| Option   |      Description      |
|----------|:-------------:|
| engine_path | manually specify Unreal Engine path |
| project_path | manually specify Unreal Project path |

## Code Completion
You need llvm installed and clangd setup.

then simply run `:UnrealGen` and restart the LSP when it's finished
