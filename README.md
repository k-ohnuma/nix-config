# nix-config

k-ohnuma's Nix configuration for macOS and NixOS-WSL.

## Supported Targets

- macOS via `nix-darwin`
- NixOS-WSL via `nixosConfigurations`

## Structure

- `flake.nix`: flake inputs and output entry point
- `outputs/`: platform-specific flake outputs
- `modules/base/`: shared system-level Nix settings
- `modules/darwin/`: nix-darwin system configuration
- `modules/nixos/`: NixOS-WSL system configuration
- `home/base/`: shared Home Manager configuration
- `home/platforms/darwin/`: macOS-specific Home Manager configuration
- `home/platforms/linux/`: Linux-specific Home Manager configuration
- `home/platforms/wsl/`: WSL-specific Home Manager configuration
- `home/profiles/desktop/`: desktop app configuration used on graphical systems
- `windows/`: files intended to be placed on the Windows side manually
- `Justfile`: operational commands

## Initial Setup

### macOS

Install Nix:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Clone this repository:

```bash
git clone https://github.com/k-ohnuma/nix-config ~/nix/nix-config
```

Apply the nix-darwin configuration:

```bash
cd ~/nix/nix-config
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#user
```

After the first switch, use:

```bash
just switch-darwin
```

### NixOS-WSL

This repository targets NixOS-WSL, not Ubuntu WSL with standalone Home Manager.

Clone this repository:

```bash
git clone https://github.com/k-ohnuma/nix-config ~/nix/nix-config
```

Apply the NixOS-WSL configuration:

```bash
cd ~/nix/nix-config
sudo nixos-rebuild switch --flake .#wsl
```

After the first switch, use:

```bash
just switch-nixos
```

## Variables

Machine/user-specific variables are provided by the `vars` input.

Default:

```nix
vars.url = "path:./vars";
```

For local private values, override the input:

```bash
just switch-darwin user ../nix-config-vars
just switch-nixos wsl ../nix-config-vars
```

Equivalent raw commands:

```bash
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#user --override-input vars path:../nix-config-vars
sudo nixos-rebuild switch --flake .#wsl --override-input vars path:../nix-config-vars
```

Related repository:

- https://github.com/k-ohnuma/nix-config-vars

## Just Commands

General:

- `just fmt`: format Nix files
- `just fmt-check`: check Nix formatting without modifying files
- `just test`: run eval tests
- `just check`: run `fmt-check`, `test`, `eval-darwin`, and `eval-nixos`
- `just push`: run `check`, then push the current branch
- `just update`: update all flake inputs
- `just update-input <input>`: update a specific flake input
- `just gc`: run Nix garbage collection
- `just doctor`: print basic tool paths and evaluate configured targets

macOS:

- `just eval-darwin [host]`
- `just build-darwin [host] [vars-path]`
- `just switch-darwin [host] [vars-path]`

NixOS-WSL:

- `just eval-nixos [host]`
- `just build-nixos [host] [vars-path]`
- `just switch-nixos [host] [vars-path]`

Defaults:

- darwin host: `user`
- NixOS host: `wsl`

## Windows and WezTerm

When using WSL on Windows, WezTerm runs as a Windows application.

The Windows-side WezTerm config should be a small loader that reads this repository through the WSL filesystem. The file intended for the Windows side is:

```text
windows/wezterm/wezterm.lua
```

Place it manually at one of the Windows WezTerm config locations, for example:

```text
%APPDATA%\wezterm\wezterm.lua
```

The loader points at the repository in WSL:

```lua
package.path = "\\\\wsl.localhost\\NixOS\\home\\user\\nix\\nix-config\\wezterm\\?.lua;" .. package.path

return require("windows")
```

The actual shared WezTerm configuration lives in:

```text
wezterm/common.lua
wezterm/windows.lua
wezterm/darwin.lua
```

Note: Windows-side WezTerm did not reliably follow the WSL-side Home Manager symlink, so the loader points to the repository path directly.

## Windows Key Remap

`Win+U` conflicts with Windows system shortcuts. The WezTerm binding uses:

```lua
SUPER|ALT+U
```

PowerToys is used on Windows to remap:

```text
Win+U -> Win+Alt+U
```

This keeps the user-facing shortcut as `Win+U` while avoiding the native Windows conflict.

## CI

GitHub Actions runs:

- `ci-nixos` on `ubuntu-latest`
- `ci-darwin` on `macos-latest`

The Ubuntu runner is only the CI execution environment. The Linux target being checked is `nixosConfigurations.wsl`.
