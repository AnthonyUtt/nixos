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
    wk.add({
      { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
      { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
      { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
      { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
      { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Find oldfiles" },
      { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
      { "<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "Git commits" },
      { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "Git status" },
    })
  '';
}
