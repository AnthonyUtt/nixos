return {
  "AnthonyUtt/lspcontainers.nvim",
  "ethanholz/nvim-lastplace",
  "onsails/lspkind.nvim",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = require "configs.copilot",
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    opts = {
      font = "ComicShannsMono Nerd Font=34",
      to_clipboard = true,
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        mode = function(str)
          return "\\<" .. str
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig").config()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "configs.nvimtree".opts
    end,
    init = function()
      require("configs.nvimtree").init()
    end,
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "dot",
        "gdscript",
        "gdshader",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "graphql",
        "hlsl",
        "html",
        "javascript",
        "json",
        "kdl",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "ruby",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsv",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
  		},
  	},
  },
}
