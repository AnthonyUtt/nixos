{ inputs, outputs, ... }: {
  imports = [
    inputs.nur.modules.nixos.default

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
