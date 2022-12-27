require("toggleterm").setup(
  {
    size = 12,
    shade_filetypes = {},
    hide_numbers = true,
    shade_terminals = true,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    persist_size = true,
    persist_mode = false,
    close_on_exit = true,
    direction = "horizontal",
    shading_factor = require("toggleterm.constants").shading_amount,
    shell = vim.o.shell,
    autochdir = false,
    auto_scroll = true,
    winbar = {
      enabled = false,
      name_formatter = function(term) return string.format("%d:%s", term.id, term:_display_name()) end,
    },
    float_opts = {
      winblend = 0,
    },
  }
)
