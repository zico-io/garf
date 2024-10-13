{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf;
let
  cfg = config.garf.tools.zoxide;
  aliases = {
    cd = mkDefault "z";
    f = mkDefault "zi";
  };
in
{
  options.garf.tools.zoxide = with types; {
    enable = mkBoolOpt false "Enable zoxide?";
  };

  config = mkIf cfg.enable {
    programs = {
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };

      fish.shellAliases = aliases;
      bash.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
