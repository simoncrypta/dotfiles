return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      local cwd = vim.uv.cwd()
      local repo_root = vim.fs.root(cwd, { "nx.json", "redwood.toml", "package.json", ".git" }) or cwd
      local tsdk = vim.fs.find("node_modules/typescript/lib", { path = repo_root, upward = true })[1]
        or (repo_root .. "/node_modules/typescript/lib")

      -- Explicitly disable vtsls (it embeds tsserver and is crashing here).
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, { enabled = false })

      -- Enable ts_ls (typescript-language-server). This wraps tsserver but tends to be
      -- more predictable in monorepos, and supports explicit tsserver path.
      opts.servers.ts_ls = vim.tbl_deep_extend("force", opts.servers.ts_ls or {}, {
        enabled = true,
        root_dir = function(bufnr)
          return vim.fs.root(bufnr, { "nx.json", "redwood.toml", "package.json", ".git" }) or repo_root
        end,
        init_options = {
          hostInfo = "neovim",
          maxTsServerMemory = 8192,
          preferences = {
            importModuleSpecifierPreference = "non-relative",
          },
          tsserver = {
            path = tsdk .. "/tsserver.js",
          },
        },
      })

      -- GraphQL LSP
      opts.servers.graphql = vim.tbl_deep_extend("force", opts.servers.graphql or {}, {
        filetypes = { "graphql", "gql", "typescriptreact", "typescript", "javascriptreact", "javascript" },
      })

      return opts
    end,
  },
}
