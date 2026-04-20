{
  description = "vars for nix-config";

  outputs =
    { ... }:
    {
      lib = import ./vars.nix;
    };
}
