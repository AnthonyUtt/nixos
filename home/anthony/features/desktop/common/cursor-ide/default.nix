{ pkgs, ... }: {
  home.packages = [
    (pkgs.code-cursor.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.neovim-unwrapped
        # pkgs.writeScriptBin "activate-ruby-nix" ''
        #   echo "export GEM_HOME=\"$GEM_HOME\""
        #   echo "export GEM_PATH=\"$GEM_PATH\""
        #   echo "export PATH=\"$(command -v ruby | xargs dirname):$GEM_HOME/bin:\$PATH\""
        # ''
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
