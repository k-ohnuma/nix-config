# nix-config

## Module Structure

- `flake.nix`: entry point for flake inputs/outputs
- `outputs/`: `darwinConfigurations`, `devShells`, `evalTests`
- `modules/darwin/`: nix-darwin system configuration
- `home/`: home-manager user configuration
- `Justfile`: operational commands

## Initial Setup

### macOS

1. Install Nix:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Clone this repo:

```bash
git clone https://github.com/k-ohnuma/nix-config ~/nix/nix-config
```

3. Apply the nix-darwin configuration:

```bash
sudo nix run nix-darwin -- switch --flake ~/nix/nix-config#user
```

4. Use `just` for day-to-day operations:

```bash
just test
just build
just switch
```

## Just Commands

- `just test`: run eval tests
- `just eval`: verify that `darwinConfigurations.<host>.system` evaluates
- `just build`: build the system (without creating `result`)
- `just switch`: apply the current configuration
- `just generations`: list generations
- `just gc`: garbage collection
- `just update`: update `flake.lock`
- `just update-input <name>`: update a specific flake input

## Related Repositories

- [`nix-config-vars`](https://github.com/k-ohnuma/nix-config-vars): local variables consumed from `inputs.vars`
