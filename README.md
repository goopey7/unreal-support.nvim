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
when `setup()` is called with no arguments, the plugin will scan for the project you are editing. If one is found it will then also scan for the latest version of Unreal Engine, and provide the Unreal commands.

### Linux Only
create a `.clangd` file in your unreal projects directory or your home directory with the following content
```
CompileFlags:
  Add: [-ferror-limit=0]
```

### Options for `setup()` (not required)
| Option   |      Description      |
|----------|:-------------:|
| engine_path | manually specify Unreal Engine path |
| project_path | manually specify Unreal Project path |
| on_project_loaded | callback function which gets called when the plugin finds an unreal project |

## Features
| Feature   |      Status      |
|----------|:-------------:|
| Code Completion / Intellisense | works on Windows/Linux |
| BuildEditor | works on Windows/Linux |
| Run | Unimplemented |
| Cook | Unimplemented |
| NeovimSourceCodeAccess (set editor to Neovim in UE5) | Unimplemented |

## Code Completion
You need llvm installed and clangd setup with your LSP.

then simply run `:UnrealGen` and restart the LSP when it's finished

## Contributing
Contributions are welcome! Please make a pull request on GitHub.
