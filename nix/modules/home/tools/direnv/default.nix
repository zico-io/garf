{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf;
let
  cfg = config.garf.tools.direnv;
in
{
  options.garf.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv?";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
