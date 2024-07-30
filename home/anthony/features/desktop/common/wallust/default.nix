{ pkgs, lib, config, ... }:
let
  pywalfox-wrapper = pkgs.writeShellScriptBin "pywalfox-wrapper" ''
    ${pkgs.pywalfox}/bin/pywalfox start
  '';
in
{
  home.packages = with pkgs; [
    wallust
    pywalfox
  ];

  xdg.configFile."wallust/wallust.toml".text = ''
    palette = "${config.wallustPalette}"
    ${lib.strings.fileContents ./wallust.toml}
  '';

  xdg.configFile."wallust/templates" = {
    source = ./templates;
    recursive = true;
  };

  home.file.".mozilla/native-messaging-hosts/pywalfox.json".text = lib.replaceStrings [ "<path>" ] [
    "${pywalfox-wrapper}/bin/pywalfox-wrapper"
  ] (lib.readFile "${pkgs.pywalfox}/lib/python3.11/site-packages/pywalfox/assets/manifest.json");
}
