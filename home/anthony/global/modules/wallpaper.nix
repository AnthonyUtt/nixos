{ lib, ... }:
let inherit (lib) types mkOption;
in
{
  options.wallpaper = mkOption {
    type = types.path;
    default = "";
    description = ''
      Wallpaper path
    '';
  };

  options.wallustPalette = mkOption {
    type = types.str;
    default = "softdark16";
    description = ''
      Wallust color generation palette
    '';
  };
}
