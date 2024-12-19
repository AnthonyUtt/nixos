{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    departure-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    font-awesome

    # Custom fonts (see /pkgs/)
    koulen
    phosphor-icons
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
