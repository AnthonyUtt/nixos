{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.telescope-nvim;
  type = "lua";
  config = ''
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { " " },
        },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },
    })

    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        f = {
          f = { "<cmd> Telescope find_files <CR>", "Find files" },
          a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
          w = { "<cmd> Telescope live_grep <CR>", "Live grep" },
          b = { "<cmd> Telescope buffers <CR>", "Find buffers" },
          h = { "<cmd> Telescope help_tags <CR>", "Help page" },
          o = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
          z = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
        },
        cm = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        gt = { "<cmd> Telescope git_status <CR>", "Git status" },
      }
    })
  '';
}
