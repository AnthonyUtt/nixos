{ inputs, outputs, ... }: {
  imports = [
    inputs.nur.nixosModules.nur
    inputs.sops-nix.nixosModules.sops

    # ./auto-upgrade.nix
    ./dev-tools.nix
    ./doas.nix
    ./locale.nix
    ./nix.nix
    ./zsh.nix

  ] ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
