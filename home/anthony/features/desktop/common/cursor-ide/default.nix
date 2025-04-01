{ pkgs, inputs, ... }: 
let
  activate-ruby-lsp = pkgs.writeShellScriptBin "activate-ruby-lsp" ''
    echo "export GEM_HOME=\"$GEM_HOME\""
    echo "export GEM_PATH=\"$GEM_PATH\""
    echo "export PATH=\"$(command -v ruby | xargs dirname):$GEM_HOME/bin:\$PATH\""
  '';
in {
  home.packages = [
    # (inputs.cursor.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
    (inputs.cursor.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.neovim-unwrapped
        pkgs.ruby_3_1
        activate-ruby-lsp
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
