{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.gitsigns-nvim;
  type = "lua";
  config = ''
    require('gitsigns').setup({
      on_attach = function(bufnr)
        gs = package.loaded.gitsigns
        local wk = require("which-key")
        wk.register({
          ['<leader>gb'] = {
            function()
              gs.blame_line({ full = true })
            end,
            "git blame line"
          }
        }, { buffer = bufnr, silent = true })
      end,
    })
  '';
}
