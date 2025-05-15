{ inputs, config, ... }: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      openai_api_key = {
        mode = "0440";
        group = "keys";
      };
      anthropic_api_key = {
        mode = "0440";
        group = "keys";
      };
      brave_search_api_key = {
        mode = "0440";
        group = "keys";
      };
    };
  };
}
