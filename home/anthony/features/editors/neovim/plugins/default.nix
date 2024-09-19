{ pkgs, lib }:
let
  themes = import ./themes { inherit pkgs lib; };
in{
  # Select a theme from the files available in ./themes
  theme = themes.pywal;

  # Dependencies
  plenary = import ./plenary.nix { inherit pkgs lib; };
  nui = import ./nui.nix { inherit pkgs lib; };
  which-key = import ./which-key.nix { inherit pkgs lib; };
  nvim-dap = import ./nvim-dap.nix { inherit pkgs lib; };

  # File Tree
  nvim-tree = import ./nvim-tree.nix { inherit pkgs lib; };
  nvim-web-devicons = import ./nvim-web-devicons.nix { inherit pkgs lib; };

  # AI Suggestions
  # codeium = import ./codeium.nix { inherit pkgs lib; };
  # copilot = import ./copilot.nix { inherit pkgs lib; };

  # Syntax Highlighting / Language Support
  treesitter = import ./nvim-treesitter.nix { inherit pkgs lib; };
  lsp = import ./lsp.nix { inherit pkgs lib; };
  lspcontainers = import ./lspcontainers.nix { inherit pkgs lib; };
  rustaceanvim = import ./rustaceanvim.nix { inherit pkgs lib; };
  sqls-nvim = import ./sqls-nvim.nix { inherit pkgs lib; };
  vim-mustache-handlebars = import ./vim-mustache-handlebars.nix { inherit pkgs lib; };
  vim-jinja2-syntax = import ./vim-jinja2-syntax.nix { inherit pkgs lib; };
  vim-glsl = import ./vim-glsl.nix { inherit pkgs lib; };

  # Code Completion
  nvim-cmp = import ./nvim-cmp.nix { inherit pkgs lib; };
  lspkind-nvim = import ./lspkind-nvim.nix { inherit pkgs lib; };
  cmp-nvim-lsp = import ./cmp-nvim-lsp.nix { inherit pkgs lib; };
  cmp-buffer = import ./cmp-buffer.nix { inherit pkgs lib; };
  cmp-path = import ./cmp-path.nix { inherit pkgs lib; };
  smoji-nvim = import ./smoji-nvim.nix { inherit pkgs lib; };

  # Status Line + Tab/Buffer Line
  lualine = import ./lualine.nix { inherit pkgs lib; };
  barbar = import ./barbar.nix { inherit pkgs lib; };

  # Utilities
  comment = import ./comment.nix { inherit pkgs lib; };
  flash = import ./flash.nix { inherit pkgs lib; };
  indent-blankline = import ./indent-blankline.nix { inherit pkgs lib; };
  gitsigns = import ./gitsigns.nix { inherit pkgs lib; };
  nvim-autopairs = import ./nvim-autopairs.nix { inherit pkgs lib; };
  nvim-lastplace = import ./nvim-lastplace.nix { inherit pkgs lib; };
  nvim-ts-autotag = import ./nvim-ts-autotag.nix { inherit pkgs lib; };
  nvim-colorizer = import ./nvim-colorizer.nix { inherit pkgs lib; };
  spelunker = import ./spelunker.nix { inherit pkgs lib; };
  telescope = import ./telescope.nix { inherit pkgs lib; };
  trouble = import ./trouble.nix { inherit pkgs lib; };
  nvim-silicon = import ./nvim-silicon.nix { inherit pkgs lib; };
}
