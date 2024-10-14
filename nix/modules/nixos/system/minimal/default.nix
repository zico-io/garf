{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.garf;

let
  cfg = config.garf.system;
in
{
  config = mkIf (cfg.type == "minimal") {
    garf = {
      tools = {
        git = enabled;
        nh = enabled;
      };
    };

    services.openssh = {
      enable = true;
      # settings = {
      #   PasswordAuthentication = false;
      #   KbdInteractiveAuthentication = false;
      #   PermitRootLogin = "no";
      # };
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
