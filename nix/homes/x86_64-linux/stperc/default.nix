{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.garf;
{
  garf = {
    apps.helix = enabled;
    tools = {
      eza = enabled;
    };
  };

  programs.zsh = enabled;

  home = {
    stateVersion = "23.11";
  };
}
