-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format on save matching VS Code settings: oxc always, eslint explicit
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("leftlane_format_on_save", { clear = true }),
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.graphql", "*.gql", "*.prisma" },
  callback = function()
    local conform = package.loaded["conform"]
    if conform then
      require("conform").format({ timeout_ms = 3000, lsp_format = "fallback" })
    end
  end,
})


-- Redwood types regeneration hints
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("leftlane_redwood_types", { clear = true }),
  pattern = "*/api/db/schema.prisma",
  callback = function()
    vim.notify("Prisma schema changed. Run `yarn migratedb` to update types.", vim.log.levels.INFO, { title = "LeftLane" })
  end,
})

-- Nx project detection
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("leftlane_nx_detection", { clear = true }),
  callback = function()
    local cwd = vim.fn.getcwd()
    local nx_json = vim.fn.findfile("nx.json", cwd .. ";")
    if nx_json ~= "" then
      vim.g.nx_workspace = true
      vim.g.project_root = vim.fn.fnamemodify(nx_json, ":h")
    end
  end,
})

