{ lib, ... }:
let inherit (lib) types mkOption;
in
{
  options.hyprland = mkOption {
    type = types.submodule {
      options = {
        env = mkOption {
          type = types.lines;
        };
        general = mkOption {
          type = types.lines;
        };
        bindings = mkOption {
          type = types.lines;
        };
        startup = mkOption {
          type = types.lines;
        };
      };
    };
    default = {
      env = "";
      general = ''
        layout=dwindle
      '';
      bindings = "";
      startup = "";
    };
  };
}
