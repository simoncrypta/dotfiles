-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- TypeScript configuration for LeftLane monorepo
vim.g.lazyvim_typescript_opts = {
  preferences = {
    importModuleSpecifier = "non-relative",
    includeInlayParameterNameHints = "literals",
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = false,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
  },
}

-- Monorepo root detection
vim.g.root_spec = {
  { ".git", "package.json", "nx.json", "redwood.toml" },
  "cwd",
}

-- Editor settings matching VS Code
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Trim trailing whitespace on write
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Disable nvim-oxc for this project as we use oxlint directly
if pcall(require, "nvim-oxc") then
  require("nvim-oxc").disable()
end
