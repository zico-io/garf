{
  config,
  lib,
  ...
}:
with lib;
with lib.garf;

let cfg = config.garf.tools.nh;
in {
  options.garf.tools.nh = with types; {
    enable = mkBoolOpt false "Enable Nix Helper";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.garf.user.name}/garf/nix";
    };
  };
}
