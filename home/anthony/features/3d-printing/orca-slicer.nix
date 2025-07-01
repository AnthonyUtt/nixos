{ pkgs, ... }:
let
  orcaSlicerDesktopItem = pkgs.makeDesktopItem {
    name = "orca-slicer-dri";
    desktopName = "OrcaSlicer (DRI)";
    genericName = "3D Printing Software";
    icon = "OrcaSlicer";
    exec = "env GBM_BACKEND=dri ${pkgs.orca-slicer}/bin/orca-slicer %U";
    terminal = false;
    type = "Application";
    mimeTypes = [
      "model/stl"
      "model/3mf"
      "application/vnd.ms-3mfdocument"
      "application/prs.wavefront-obj"
      "application/x-amf"
      "x-scheme-handler/orcaslicer"
    ];
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    keywords = [ "3D" "Printing" "Slicer" "slice" "3D" "printer" "convert" "gcode" "stl" "obj" "amf" "SLA" ];
    startupNotify = false;
    startupWMClass = "orca-slicer";
  };

in
{
  home.packages = with pkgs; [
    orca-slicer
    orcaSlicerDesktopItem
  ];
}
