vim.o.number = true -- show line numbers
vim.o.tabstop = 2 -- number of spaces that a <Tab> in the file counts for
vim.o.softtabstop = 2 -- number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
vim.o.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.o.expandtab = true -- in Insert mode: Use the appropriate number of spaces to insert a <Tab>
vim.o.swapfile = false -- don't use swapfile for a buffer
vim.o.backup = false -- don't write backups for a buffer
vim.o.undofile = true -- automatically saves undo history
vim.o.clipboard = 'unnamedplus' -- use system clipboard (provedor definido no fim do arquivo)
vim.o.signcolumn = 'yes' -- show sign columns (even blank)
vim.o.shortmess = vim.o.shortmess .. 'I' -- don't show nvim intro message
vim.o.termguicolors = true -- enables 24-bit RGB color in the TUI
vim.o.showmode = false -- show mode in last line
vim.o.showbreak = '↪' -- string to put at the start of lines that have been wrapped
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.shiftround = true -- round indent to multiple of 'shiftwidth'.  Applies to > and < commands
vim.o.updatetime = 100 -- if this many milliseconds nothing is typed the swap file will be written to disk. Also used for the CursorHold autocommand event
vim.o.scrolloff = 12 -- minimal number of screen lines to keep above and below the cursor
vim.o.incsearch = true -- while typing a search command, show where the pattern, as it was typed so far, matches.
vim.o.breakindent = true -- enable break indent
vim.opt.ruler = false -- Don't show the ruler
vim.opt.showcmd = false -- Don't show the command in the last line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- mostly just for cmp

-- Set filetype detection for alphaTex/alphaTab files on startup
vim.filetype.add({
  extension = {
    atex = 'alphatex',
    alphatex = 'alphatex',
    alphatab = 'alphatex',
  },
})

-- Clipboard: via SSH, ou sem display (TTY, tmux sem DISPLAY), não há
-- xclip/wl-copy utilizável. Nesses casos, copia via OSC 52: o terminal do
-- cliente recebe o texto e o põe no clipboard local, mesmo atravessando SSH
-- (dentro do tmux, precisa de `set -g set-clipboard on`). Ler o clipboard via
-- OSC 52 trava ou é bloqueado em muitos terminais, então "+p/"*p devolvem o
-- último yank. Para colar o clipboard local, use o paste do terminal
-- (Ctrl+Shift+V / Cmd+V).
-- Com display local, o nvim escolhe sozinho (wl-copy no Wayland, senão xclip).
local sem_display = not (vim.env.WAYLAND_DISPLAY or vim.env.DISPLAY)
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION or sem_display then
  local osc52 = require('vim.ui.clipboard.osc52')
  local function ultimo_yank()
    return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
  end
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
    paste = { ['+'] = ultimo_yank, ['*'] = ultimo_yank },
  }
end
