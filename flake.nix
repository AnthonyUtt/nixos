{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    superfile.url = "github:yorukot/superfile";
    cursor.url = "github:omarcresp/cursor-flake/main";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, rust-overlay, nix-gaming, ... }@inputs:
  let
    inherit (self) outputs;

    forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    unstable = import nixpkgs-unstable { inherit system; };

    overlays = {
      rust-overlay = rust-overlay.overlays.default;
      nur = inputs.nur.overlays.default;
      personal = import pkgs/overlay.nix;
    };

    mkNixos = modules: nixpkgs.lib.nixosSystem {
      inherit system;

      modules = modules ++ [
        ({ pkgs, ... }: {
          nixpkgs.overlays = builtins.attrValues overlays;
        })
      ];
      specialArgs = { inherit inputs outputs unstable nix-gaming; };
    };

    mkNixosImage = modules: nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = modules ++ [
        ({ pkgs, ... }: {
          nixpkgs.overlays = builtins.attrValues overlays;
        })
      ];
      specialArgs = { inherit inputs outputs unstable; };
    };
  in
  rec {
    nixosModules = import ./modules/nixos;

    packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));

    nixosConfigurations = {
      tethys = mkNixos [ ./hosts/tethys ];
      titan = mkNixos [ ./hosts/titan ];
      gaia = mkNixos [ ./hosts/gaia ];

      # Devices
      lepotato = mkNixosImage [ ./devices/lepotato.nix ];
    };

    images = {
      lepotato = nixosConfigurations.lepotato.config.system.build.sdImage;
    };

    devShells."${system}" = import ./shells { inherit pkgs; };

    templates = {
      flutter = {
        path = ./templates/flutter;
        description = "A flutter development environment";
      };
      rust = {
        path = ./templates/rust;
        description = "A rust development environment";
      };
    };
  };
}
