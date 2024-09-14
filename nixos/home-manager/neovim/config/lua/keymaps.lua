local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
keymap("n", "<leader>q", ":call confirm_quit#confirm(1, 'always')<cr>", opts)
keymap("n", "<leader>w", ":up!<cr>", opts)
keymap("n", "<C-d><C-q>", "<Nop>", opts) -- Disable close file hotkey, :q is easy enough.
keymap("n", "<leader><C-t>", ":vsplit<cr>:terminal<cr>", opts) -- Open terminal
keymap("n", "<C-d>", ":t.<cr>", opts)

-- Code controls
keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>", opts)
keymap("n", "]d", ":lua vim.diagnostic.goto_next()<cr>", opts)

autocmd("LspAttach", {
    callback = function(ev)
        keymap("n", "gd", ":tab split | lua vim.lsp.buf.definition()<cr>", opts)
    end
})

-- Tab controls
keymap("n", "<C-t><Right>", ":+tabmove<cr>", opts)
keymap("n", "<C-t><Left>", ":-tabmove<cr>", opts)
keymap("n", "<C-t>l", ":tabn<cr>", opts)
keymap("n", "<C-t>h", ":tabp<cr>", opts)
keymap("n", "<leader>t", ":tabnew New<cr>", opts)

-- Buffer controls
keymap("n", "<leader>be", "%bd | e#<cr>", opts)
keymap("n", "<leader>ba", ":up | %bd<cr>", opts)

-- Window controls
   -- Switch active
keymap("n", "<C-l>", "<C-W>l", opts)
keymap("n", "<C-h>", "<C-W>h", opts)
keymap("n", "<C-j>", "<C-W>j", opts)
keymap("n", "<C-k>", "<C-W>k", opts)
   -- Move active 
keymap("n", "<CS-l>", "<C-W>L", opts)
keymap("n", "<CS-h>", "<C-W>H", opts)
keymap("n", "<CS-j>", "<C-W>J", opts)
keymap("n", "<CS-k>", "<C-W>K", opts)
   -- Resize
keymap("n", "<C-v>=", ":resize +10<cr>", opts)
keymap("n", "<C-v>-", ":resize -10<cr>", opts)
keymap("n", "<C-h>=", ":vertical-resize +20<cr>", opts)
keymap("n", "<C-h>-", ":vertical-resize -20<cr>", opts)

-- File browser
keymap("n", "<leader>f", ":RangerEdit<cr>", opts)

-- Godot
autocmd("FileType", {
    pattern = { "gd", "gdscript", "gdscript3" },
    group = vim.api.nvim_create_augroup("gdscript-keymaps", {}),
    callback = function()
        keymap("n", "<F4>", ":GodotRunLast<CR>", opts)
        keymap("n", "<F5>", ":GodotRun<CR>", opts)
        keymap("n", "<F6>", ":GodotRunCurrent<CR>", opts)
        keymap("n", "<F7>", ":GodotRunFZF<CR>", opts)

        --vim.g.godot_executable = "/run/current-system/sw/bin/godot4-mono"
        --vim.lsp.start {
        --    name = "gdscript",
        --    --cmd = { "ncat", "127.0.0.1", "6005" },
        --    cmd = { "curl", "127.0.0.1:6005" },
        --    capabilities = capabilities,
        --    root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
        --}
    end,
})
