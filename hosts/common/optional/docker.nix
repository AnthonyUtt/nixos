{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.nvidia-container-toolkit ];
}
