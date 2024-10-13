{ config, lib, pkgs, ... }:

with lib;
with lib.garf;

let cfg = config.garf.tools.sops;
  user = config.garf.user;
in {
  options.garf.tools.sops = with types; {
    location = mkOpt str "alpha" "Target server for this deployment.";
  };
  
  config = {
    sops = {
      defaultSopsFile = ../../../../secrets/${cfg.location}.yaml;
      defaultSopsFormat = "yaml";

      age = {
        # sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/home/${user.name}/.config/sops/age/keys.txt";
        # generateKey = true;
      };

      secrets = {
        "users/${user.name}/ssh_key" = {
          path = "/home/${user.name}/.ssh/id_${user.name}";
        }; 
      };
    };
  };
}
