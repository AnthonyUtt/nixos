{ pkgs, ... }: {
  imports = [
    ./orca-slicer.nix
  ];

  home.packages = with pkgs; [
    blender
    prusa-slicer
    # freecad
  ];
}
