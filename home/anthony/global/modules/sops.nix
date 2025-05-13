{ inputs, config, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = ../../../../secrets/secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      openai_api_key = {
        path = "${config.sops.defaultSymlinkPath}/openai_api_key";
      };
      anthropic_api_key = {
        path = "${config.sops.defaultSymlinkPath}/anthropic_api_key";
      };
      brave_search_api_key = {
        path = "${config.sops.defaultSymlinkPath}/brave_search_api_key";
      };
    };
  };
}
