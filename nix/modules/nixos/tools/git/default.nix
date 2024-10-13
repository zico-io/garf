{ config, lib, pkgs, ... }:

with lib;
with lib.garf;

let
  cfg = config.garf.tools.git;
  user = config.garf.user;
in {
  options.garf.tools.git = with types; {
    enable = mkBoolOpt false "Enable git.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ gitui ];
    programs = {
      # lazygit = enabled;
      git = {
        enable = true;
        package = pkgs.gitFull;
        config = {
          user = {
            name = user.fullName;
            email = user.email;
          };
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          url = {
            "ssh://git@github.com" = {
              insteadOf = "https://github.com";
            };
          };
        };
      };
    };
  };
}
