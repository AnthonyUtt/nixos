{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    departure-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    nerdfonts
    font-awesome

    # Custom fonts (see /pkgs/)
    koulen
    phosphor-icons
  ];
}
