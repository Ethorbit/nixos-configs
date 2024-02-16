local get_option_val = vim.api.nvim_get_option_value
local set_option_val = vim.api.nvim_set_option_value 
local options = {}

-- Some vim-styled options:
vim.cmd [[
let g:ranger_replace_netrw = 1
]]

ranger_replace_netrw = 1

options.nvim = {
    autochdir = true,
    confirm = true,
    clipboard = "unnamedplus",
    mouse = "",
    number = true,
    autoindent = true,
    smartindent = false,
    cindent = false,
    expandtab = true,
    softtabstop = 0, 
    shiftwidth = 0,
    tabstop = 4,
    backspace = "indent,eol,start",
    list = true,
    listchars = {["tab"] = "▷⋮"},
    shellcmdflag="-ic",
    backupdir = "$HOME/.config/nvim/tmp/backup"
}

local cpopts = get_option_val("cpoptions", {})
set_option_val("cpoptions", cpopts .. "I", {})

for _,tbl in pairs(options) do 
    for k,v in pairs(tbl) do 
        vim.opt[k] = v
    end
end 
