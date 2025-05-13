{ inputs, lib, pkgs, config, outputs, ... }: 
let
  overlays = {
    rust-overlay = inputs.rust-overlay.overlays.default;
    nur = inputs.nur.overlays.default;
    personal = import ../../../pkgs/overlay.nix;
  };
in
{
  imports = [
    ../features/cli
    ./modules/workstation.nix
    ./modules/sops.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
    overlays = builtins.attrValues overlays;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "anthony";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
