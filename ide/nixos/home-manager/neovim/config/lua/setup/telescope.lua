require("telescope").load_extension('neoclip')
-- Telescope buggy color fix/hack
vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg=LightGrey })
