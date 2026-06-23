vim.g.mapleader = ' '              -- space as leader key
vim.g.maplocalleader = ' '         -- space as leader key
vim.g.python3_host_prog = 'python' -- set python host
vim.g.copilot_enabled = true       -- enable copilot

-- Prepend Mason bin path to PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
