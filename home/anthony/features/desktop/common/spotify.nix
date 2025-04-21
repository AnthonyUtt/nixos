{ pkgs, ... }: {
  home.packages = [ pkgs.spotify ];
  services.spotifyd = {
    enable = true;
    # settings = {
    #   global = {
    #     username = "anthony@anthony.com";
    #     password = "password";
    #   };
    # };
  };
}
