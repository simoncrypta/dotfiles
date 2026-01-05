return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        graphql = {
          filetypes = { "graphql", "gql", "typescriptreact", "typescript", "javascriptreact", "javascript" },
          settings = {
            graphql = {
              graphqlFilePatterns = {
                "**/*.graphql",
                "**/*.gql",
              },
            },
          },
        },
      },
    },
  },
}
