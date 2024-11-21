{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.flutter-tools-nvim;
  type = "lua";
  config = ''
    require("flutter-tools").setup()

    local wk = require("which-key")
    wk.add({
      {
        "<leader>ft",
        require("telescope").extensions.flutter.commands,
        desc = "Flutter Tools Usage"
      }
    })
  '';
}
