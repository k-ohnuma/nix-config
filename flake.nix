{
  description = "k-ohnuma's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # neovim 0.11.5
    nixpkgs-neovim.url = "github:nixos/nixpkgs/nixos-25.05";
    # tree-sitter 0.25.10 for old nvim-treesitter master branch compatibility.
    nixpkgs-tree-sitter.url = "github:nixos/nixpkgs/4c1018dae018162ec878d42fec712642d214fdfa";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vars.url = "path:./vars";
  };
  outputs = inputs: import ./outputs inputs;
}
