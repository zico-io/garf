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
      direnv = enabled;
      eza = enabled;
      fzf = enabled;
      zoxide = enabled;
    };
  };

  programs.zsh = enabled;

  home = {
    stateVersion = "23.11";
  };
}
