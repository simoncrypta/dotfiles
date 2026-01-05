return {
  "folke/todo-comments.nvim",
  opts = {
    highlight = {
      pattern = {
        [[.*<(KEYWORDS)\s*:]],
        [[.*<(KEYWORDS)>]],
      },
    },
    search = {
      pattern = [[\b(KEYWORDS):]],
    },
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      UPSTACK = { icon = " ", color = "hint" },
      FUTURE = { icon = " ", color = "info" },
      QUESTION = { icon = " ", color = "warning" },
    },
  },
}
