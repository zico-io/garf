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

  programs = {
    zsh = enabled;
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "/home/stperc/.ssh/id_stperc";
        };
      };
    };
  };

  home = {
    stateVersion = "23.11";
  };
}
