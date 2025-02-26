{ pkgs, ... }: {
  home.packages = [
    (pkgs.code-cursor.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.neovim-unwrapped
      ];
    }))
  ];
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.code-cursor;
  #   mutableExtensionsDir = true;
  #   # profiles = {
  #   #   default = {
  #   #     enableExtensionUpdateCheck = true;
  #   #     enableUpdateCheck = true;
  #   #     extensions = [
  #   #
  #   #     ];
  #   #     userSettings = {
  #   #
  #   #     };
  #   #   };
  #   # };
  # };
}
