{ pkgs, ... }: {
  home.packages = [
    (pkgs.lutris.override {
      extraLibraries = pkgs: with pkgs; [
        giflib 
        libpng
        gnutls
        mpg123
        openal
        # v4l-utils
        libpulseaudio
        libgpg-error
        alsa-plugins
        alsa-lib
        libjpeg
        sqlite
        xorg.libXcomposite
        xorg.libXinerama
        libgcrypt
        ncurses
        ocl-icd
        libxslt
        libva
        gtk3
        jansson
        vulkan-loader
        winePackages.stagingFull
      ];
      extraPkgs = pkgs: with pkgs; [
        gamescope
      ];
    })
  ];
}
