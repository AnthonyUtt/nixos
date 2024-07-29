{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.trouble-nvim;
  type = "lua";
  config = ''
    require("trouble").setup()

    local wk = require("which-key")
    wk.add({
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble diagnostics" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
    })
  '';
}
