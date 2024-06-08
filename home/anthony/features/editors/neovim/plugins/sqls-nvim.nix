{ pkgs, lib }:
let
  pluginFromGit = repo: ref: rev: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in
{
  plugin = (pluginFromGit "nanotee/sqls.nvim" "main" "4b1274b5b44c48ce784aac23747192f5d9d26207");
  type = "lua";
  config = ''
    require('lspconfig').sqls.setup{
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end
    }
  '';
}
