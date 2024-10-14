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
    ssh.matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${config.garf.user.home}/.ssh/id_git";
      };
    };
  };

  home = {
    stateVersion = "23.11";
  };
}
