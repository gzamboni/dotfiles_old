-- n, v, i, t = mode names

local default_options = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", default_options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local maps = {}

maps.general = {
  i = {
    ["<C-c>"] = { "<Esc>", "alternative escape" },
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
  },

  n = {

    ['Q'] = { "q", "Disable quit" },
    ['q'] = { '<Nop>', 'Disable quit'},
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
    ["<C-h>"] = { "<C-w>h", "move to left window" },
    ["<C-j>"] = { "<C-w>j", "move to bottom window" },
    ["<C-k>"] = { "<C-w>k", "move to top window" },
    ["<C-l>"] = { "<C-w>l", "move to right window" },
    ["<C-q>"] = { "<cmd>qa<CR>", "quit" },
    ["<D-r>"] = { "<cmd>Bd<CR>", "quit mac style" },
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },
    ["<C-u>"] = { "<C-u>zz", "go up and cursor center" },
    ["<C-d>"] = { "<C-d>zz", "go down and cursor center" },

    -- new buffer
    ["<leader>n"] = { "<cmd>enew<CR>", "new buffer" },
    -- close current buffer
    ["<leader>x"] = { "<cmd>Bd<CR>", "close buffer" },
    -- close all buffers
    ["<leader>X"] = { "<cmd>Bd!<CR>", "close all buffers" },
    -- next buffer
    ["<leader>l"] = { "<cmd>bn<CR>", "next buffer" },
    -- previous buffer
    ["<leader>h"] = { "<cmd>bp<CR>", "previous buffer" },

    -- Clipboard
    ["<leader>y"] = { '"+y', "copy to clipboard" },
    ["<leader>Y"] = { '"+Y', "copy to clipboard more" },

    -- Move lines
    ["<A-j>"] = { ":m .+1<CR>==", "move line down" },
    ["<A-k>"] = { ":m .-2<CR>==", "move line up" },
    ["<leader>f"] = { vim.lsp.buf.format, "format buffer" },
    ["<leader>s"] = { [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], "search replace" },
  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    ["<Up>"] = { 'v:count || mode(-2)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["J"] = { ":m '>+1<CR>gv=gv", "move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "move line up" },
    -- Clipboard
    ["<leader>y"] = { '"+y', "copy to clipboard" },
    ["<leader>Y"] = { '"+Y', "copy to clipboard more" },

    -- stay in indent mode
    ["<"] = { "<gv", "stay in indent mode" },
    [">"] = { ">gv", "stay in indent mode" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

maps.lsp = {
  plugin = true,
  n = {
    ["gd"] = { vim.lsp.buf.definition, "go to definition" },
    ["gD"] = { vim.lsp.buf.declaration, "go to declaration" },
    ["gr"] = { vim.lsp.buf.references, "go to references" },
    ["gi"] = { vim.lsp.buf.implementation, "go to implementation" },
    ["K"] = { vim.lsp.buf.hover, "show hover" },
    ["<leader>rn"] = { vim.lsp.buf.rename, "rename symbol" },
    ["<leader>ca"] = { vim.lsp.buf.code_action, "code action" },
    ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
    ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
    ["<leader>wl"] = { vim.lsp.buf.list_workspace_folders, "list workspace folders" },
    ["<leader>di"] = { vim.lsp.diagnostic.show_line_diagnostics, "show line diagnostics" },
    ["<leader>dn"] = { vim.lsp.diagnostic.goto_next, "next diagnostic" },
    ["<leader>dp"] = { vim.lsp.diagnostic.goto_prev, "previous diagnostic" },
  },
}

maps.telescope = {
  plugin = true,
  n = {
    ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", "find files" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<CR>", "live grep" },
    ["<leader>fb"] = { "<cmd>Telescope buffers<CR>", "buffers" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<CR>", "help tags" },
    ["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<CR>", "document symbols" },
    ["<leader>fw"] = { "<cmd>Telescope lsp_workspace_symbols<CR>", "workspace symbols" },
    ["<leader>fr"] = { "<cmd>Telescope lsp_references<CR>", "references" },
    ["<leader>fd"] = { "<cmd>Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
    ["<leader>fc"] = { "<cmd>Telescope commands<CR>", "commands" },
    ["<leader>fm"] = { "<cmd>Telescope marks<CR>", "marks" },
    ["<leader>fo"] = { "<cmd>Telescope vim_options<CR>", "vim options" },
    ["<leader>ft"] = { "<cmd>Telescope treesitter<CR>", "treesitter" },
    ["<leader>fq"] = { "<cmd>Telescope quickfix<CR>", "quickfix" },
    ["<leader>fl"] = { "<cmd>Telescope loclist<CR>", "loclist" },
    ["<leader>fa"] = { "<cmd>Telescope autocommands<CR>", "autocommands" },
    ["<leader>fv"] = { "<cmd>Telescope vim_options<CR>", "vim options" },
    ["<leader>fk"] = { "<cmd>Telescope keymaps<CR>", "keymaps" },
    ["<leader>fn"] = { "<cmd>Telescope filetypes<CR>", "filetypes" },
    ["<leader>fe"] = { "<cmd>Telescope file_browser<CR>", "file browser" },
    ["<leader>fp"] = { "<cmd>Telescope projects<CR>", "projects" },
    ["<C-p>"] = { "<cmd>Telescope git_files<CR>", 'git files' },
  },
}

maps.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = { function()
      local view = require("nvim-tree.view")
      if view.is_visible() then
        vim.cmd.NvimTreeFocus()
      else
        vim.cmd.NvimTreeToggle()
      end
    end }
  },
}

maps.gitsigns = {
  plugin = true,
  n = {
    ["<leader>hs"] = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "stage hunk" },
    ["<leader>hu"] = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "undo stage hunk" },
    ["<leader>hr"] = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "reset hunk" },
    ["<leader>hp"] = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "preview hunk" },
    ["<leader>hb"] = { "<cmd>lua require('gitsigns').blame_line()<CR>", "blame line" },
  },
  o = {
    ["<leader>hs"] = { "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "stage hunk" },
    ["<leader>hu"] = { "<cmd>lua require('gitsigns').undo_stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
      "undo stage hunk" },
    ["<leader>hr"] = { "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "reset hunk" },
    ["<leader>hp"] = { "<cmd>lua require('gitsigns').preview_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
      "preview hunk" },
  },
}

maps.bufferline = {
  plugin = true,
  n = {
    ["<leader>1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "go to buffer 1" },
    ["<leader>2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "go to buffer 2" },
    ["<leader>3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "go to buffer 3" },
    ["<leader>4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "go to buffer 4" },
    ["<leader>5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "go to buffer 5" },
    ["<leader>6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "go to buffer 6" },
    ["<leader>7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "go to buffer 7" },
    ["<leader>8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "go to buffer 8" },
    ["<leader>9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "go to buffer 9" },
    ["<leader>0"] = { "<cmd>BufferLineGoToBuffer 10<CR>", "go to buffer 10" },
    ["<leader>-"] = { "<cmd>BufferLineCyclePrev<CR>", "previous buffer" },
    ["<leader>="] = { "<cmd>BufferLineCycleNext<CR>", "next buffer" },
    ["<leader>["] = { "<cmd>BufferLineMovePrev<CR>", "move buffer left" },
    ["<leader>]"] = { "<cmd>BufferLineMoveNext<CR>", "move buffer right" },
    ["<leader>bd"] = { "<cmd>BufferLinePickClose<CR>", "close buffer" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<CR>", "close buffer" },
    ["<leader>bn"] = { "<cmd>BufferLinePick<CR>", "pick buffer" },
    ["<leader>bp"] = { "<cmd>BufferLinePick<CR>", "pick buffer" },
  },
}

maps.nvim_comment = {
  plugin = true,
  n = {
    ["<D-c>"] = { "<cmd>CommentToggle<CR>", "toggle comment" },
  },
  v = {
    ["<D-c>"] = { "<cmd>CommentToggle<CR>", "toggle comment" },
  },
}


maps.renamer = {
  plugin = true,
  i = {
    ['<F2>'] = { '<cmd>lua require("renamer").rename()<cr>', opts = default_options }
  },
  n = {
    ['<leader>rn'] = { '<cmd>lua require("renamer").rename()<cr>', opts = default_options }
  },
  v = {
    ['<leader>rn'] = { '<cmd>lua require("renamer").rename()<cr>', opts = default_options }
  },
}

return maps
