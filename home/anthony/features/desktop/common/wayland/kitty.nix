{ pkgs, config, ... }:
let
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in
{
  home = {
    packages = [ kitty-xterm ];
    sessionVariables = {
      TERMINAL = "kitty -1";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      # https://www.programmingfonts.org/
      # name = "FiraCode Nerd Font";
      name = "ComicShannsMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 4000;
      enable_audio_bell = false;
    };
    extraConfig = ''
      include ~/.cache/wal/colors-kitty.conf
    '';
  };
}
