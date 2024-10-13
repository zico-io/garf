{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf;
let
  cfg = config.garf.tools.fzf;
in
{
  options.garf.tools.fzf = with types; {
    enable = mkBoolOpt false "Enable fzf?";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;

      defaultCommand = "${pkgs.fd} --type f --strip-cwd-prefix";
      defaultOptions = [
        "--border"
        "--prompt 'λ '"
        "--pointer ''"
        "--marker ''"
      ];
    };
  };
}
