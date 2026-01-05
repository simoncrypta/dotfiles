return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "graphql",
        "prisma",
        "tsx",
        "typescript",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "yaml",
      })
    end
  end,
}
