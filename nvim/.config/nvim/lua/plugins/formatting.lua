return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        prisma = { "prisma" },
      },
      formatters = {
        prettier = {
          condition = function(_, ctx)
            return vim.fs.find({
              "prettier.config.js",
              "prettier.config.cjs",
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.toml",
              "prettier.config.toml",
            }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prisma = {
          command = function(ctx)
            local local_bin = vim.fn.fnamemodify("./node_modules/.bin/prisma", ":p")
            if (vim.uv or vim.loop).fs_stat(local_bin) then
              return local_bin
            end
            return "prisma"
          end,
          args = function(ctx)
            return { "format", "--schema", ctx.filename }
          end,
          stdin = false,
        },
      },
    },
  },
}
