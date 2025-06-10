{ config, ... }:
let
  host = config.networking.hostName;
in
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "doas nixos-rebuild switch --flake ~/source/nix#${host}";
      nrt = "doas nixos-rebuild test --flake ~/source/nix#${host}";
      ncg = "doas nix-collect-garbage --delete-older-than 1d";
      ns = "(){ nix develop ~/source/nix#$1 ;}";
    };
    shellInit = ''
      # Secrets
      export OPENAI_API_KEY=$(cat ${config.sops.secrets.openai_api_key.path})
      export ANTHROPIC_API_KEY=$(cat ${config.sops.secrets.anthropic_api_key.path})
      export BRAVE_API_KEY=$(cat ${config.sops.secrets.brave_search_api_key.path})
      export VIKUNJA_API_TOKEN=$(cat ${config.sops.secrets.vikunja_api_token.path})
      export LINEAR_ACCESS_TOKEN=$(cat ${config.sops.secrets.linear_access_token.path})
    '';
  };
}
