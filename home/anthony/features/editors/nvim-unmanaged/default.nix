{ pkgs, inputs, config, secrets, ... }: 
let
  rubyDeps = pkgs.ruby_3_1.withPackages (p: with p; [
    solargraph
  ]);

  mcpServersConfig = import ../../desktop/common/ai-tooling/mcp-servers.nix {
    inherit pkgs inputs config secrets;
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    extraPackages = with pkgs; [
      gcc
      gnumake
      curl
      git
      typescript
      silicon

      # Language servers
      nodejs_20
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      docker-compose-language-service
      dockerfile-language-server-nodejs
      dot-language-server
      emmet-ls
      nodePackages.eslint
      lua-language-server
      nodePackages.prettier
      rubyDeps
      rust-analyzer
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
      sqls
      tailwindcss-language-server
      nodePackages.typescript-language-server
      glsl_analyzer
      
      # For Rust debugging
      # vscode-extensions.vadimcn.vscode-lldb.adapter
      # graphviz

      # AI stuff
      aider-chat
      inputs.mcp-hub.packages."${pkgs.system}".default 
    ];
  };

  xdg.configFile = {
    nvim = {
      source = ./nvim;
      recursive = true;
    };

    "mcphub/servers.json".source = mcpServersConfig;
  };
}
