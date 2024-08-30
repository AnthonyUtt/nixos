{ pkgs, unstable, lib, ... }:
let
  plugins = import ./plugins { inherit pkgs lib; };

  rubyDeps = pkgs.ruby.withPackages (p: with p; [
    ruby-lsp
  ]);
in
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;

    extraPackages = with pkgs; [
      gcc
      typescript
      silicon

      # Language servers
      nodejs_20
      # nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-ls
      nodePackages.eslint
      lua-language-server
      nil
      nodePackages.prettier
      rubyDeps
      rust-analyzer
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
      sqls
      tailwindcss-language-server
      nodePackages.typescript-language-server
      
      # For Rust debugging
      vscode-extensions.vadimcn.vscode-lldb.adapter
      graphviz
    ];

    extraLuaPackages = luaPkgs: [];

    plugins = builtins.attrValues plugins;

    extraLuaConfig = ''
      ${lib.strings.fileContents ./lua/vim-settings.lua}
      ${lib.strings.fileContents ./lua/keybinds.lua}
    '';
  };
}
