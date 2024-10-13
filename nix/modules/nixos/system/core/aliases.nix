{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf;
let
  aliases = {
    q = "exit";
    ll = "ls -l";
    la = "ls -la";
    cls = "clear && la";
  };
in {
  config.programs = {
      bash.shellAliases = aliases;
      fish.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
}
