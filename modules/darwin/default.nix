{ libx, ... }:
{
  imports = (libx.scanPaths ./.) ++ [
    ../base
  ];
}

