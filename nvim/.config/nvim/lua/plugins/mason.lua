return {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSP servers (Mason package names)
        "typescript-language-server",
        "vtsls",
        "prisma-language-server",
        "graphql-language-service-cli",

        -- Linters / formatters
        "oxlint",
        "eslint_d",
        "prettier",
      })
    end,
  },
}
