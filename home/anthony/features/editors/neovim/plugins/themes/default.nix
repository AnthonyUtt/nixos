{ pkgs, lib }: {
  bamboo = import ./bamboo.nix { inherit pkgs lib; };
  everforest = import ./everforest.nix { inherit pkgs lib; };
  gruvbox = import ./gruvbox.nix { inherit pkgs lib; };
  gruvbox-baby = import ./gruvbox-baby.nix { inherit pkgs lib; };
  pywal = import ./pywal.nix { inherit pkgs lib; };
}
