{ ... }: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "titan";
        device_type = "computer";
        use_mpris = true;
      };
    };
  };

}
