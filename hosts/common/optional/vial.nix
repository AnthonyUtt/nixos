{ pkgs, ... }: {
  services.udev.packages = with pkgs; [vial];  
  environment.systemPackages = with pkgs; [vial];
}
