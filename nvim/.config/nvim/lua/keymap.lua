local keymap = function(tbl)
  local opts = { noremap = true, silent = true }
  local mode = tbl["mode"]
  tbl["mode"] = nil
  local bufnr = tbl["bufnr"]
  tbl["bufnr"] = nil

  for k, v in pairs(tbl) do
    if tonumber(k) == nil then
      opts[k] = v
    end
  end

  if bufnr ~= nil then
    vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
  else
    vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
  end
end

nmap = function(tbl)
  tbl["mode"] = "n"
  keymap(tbl)
end

imap = function(tbl)
  tbl["mode"] = "i"
  keymap(tbl)
end

vmap = function(tbl)
  tbl["mode"] = "v"
  keymap(tbl)
end

-- Better indenting
vmap { "<", "<gv", desc = "Indent left and reselect" }
vmap { ">", ">gv", desc = "Indent right and reselect" }

-- Move lines up/down
nmap { "<A-j>", ":m .+1<CR>==", desc = "Move line down" }
nmap { "<A-k>", ":m .-2<CR>==", desc = "Move line up" }
vmap { "<A-j>", ":m '>+1<CR>gv=gv", desc = "Move selection down" }
vmap { "<A-k>", ":m '<-2<CR>gv=gv", desc = "Move selection up" }

-- Better paste behavior
vmap { "<leader>p", [["_dP]], desc = "Paste over selected text" }

-- Quick save and quit
nmap { "<leader>w", ":w<CR>", desc = "Save file" }
nmap { "<leader>q", ":q<CR>", desc = "Quit" }
nmap { "<leader>Q", ":qa!<CR>", desc = "Quit all without saving" }

-- Buffer navigation
nmap { "<S-h>", ":bprevious<CR>", desc = "Previous buffer" }
nmap { "<S-l>", ":bnext<CR>", desc = "Next buffer" }
nmap { "[b", ":bprevious<CR>", desc = "Previous buffer" }
nmap { "]b", ":bnext<CR>", desc = "Next buffer" }
nmap { "<leader>bd", ":bdelete<CR>", desc = "Delete current buffer" }
nmap { "<leader>bn", ":enew<CR>", desc = "New buffer" }

-- Window management
nmap { "<leader>sv", "<C-w>v", desc = "Split window vertically" }
nmap { "<leader>sh", "<C-w>s", desc = "Split window horizontally" }
nmap { "<leader>se", "<C-w>=", desc = "Make splits equal size" }
nmap { "<leader>sx", "<cmd>close<CR>", desc = "Close current split" }

-- Window navigation
nmap { "<C-h>", "<C-w>h", desc = "Go to left window" }
nmap { "<C-j>", "<C-w>j", desc = "Go to lower window" }
nmap { "<C-k>", "<C-w>k", desc = "Go to upper window" }
nmap { "<C-l>", "<C-w>l", desc = "Go to right window" }

-- Quick actions
nmap { "<leader>x", "<cmd>source %<CR>", desc = "Execute the current file" }
nmap { "<leader>r", "<cmd>LspRestart<CR>", desc = "Restart LSP" }

-- LSP keymaps
nmap { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" }
nmap { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show hover information" }
nmap { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" }
nmap { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" }
