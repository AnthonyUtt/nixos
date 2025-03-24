{ lib, ... }:
let inherit (lib) types mkOption mkEnableOption;
in
{
  options.waybar = mkOption {
    type = types.submodule {
      options = {
        showBluetooth = mkEnableOption "Waybar Bluetooth Widget";
        cpuSensorName = mkOption {
          type = types.str;
          default = "coretemp-isa-0000";
          description = "CPU sensor name for Waybar CPU widget";
        };
      };
    };
    default = {
      showBluetooth = false;
      cpuSensorName = "coretemp-isa-0000";
    };
  };
}
