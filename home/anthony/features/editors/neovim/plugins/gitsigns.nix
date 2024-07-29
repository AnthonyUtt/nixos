{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.gitsigns-nvim;
  type = "lua";
  config = ''
    require('gitsigns').setup({
      on_attach = function(bufnr)
        gs = package.loaded.gitsigns
        local wk = require("which-key")
        wk.add({
          {
            '<leader>gb',
            function()
              gs.blame_line({ full = true })
            end,
            desc = "git blame line",
            buffer = bufnr,
            silent = true,
          }
        })
      end,
    })
  '';
}
