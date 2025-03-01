return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = require "configs.avante",
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for copilot provider
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
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
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                targetDir = "./.rust-analyzer"
              }
            }
          }
        }
      }
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
