require("mason").setup()
require("mason-lspconfig").setup()
require("lint")
require("formatter").setup()

local lspconfig = require("lspconfig")

local function add(name, config)
    lspconfig[name].setup(config or {})
end

add("eslint", {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

add("html")
add("jsonls")
add("tsserver")
add("lua_ls")
add("phpactor")
add("intelephense")
add("dockerls")
add("docker_compose_language_service")
add("csharp_ls")
add("qmlls")

-- Godot Engine
add("gdscript")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gd", "gdscript", "gdscript3" },
    group = vim.api.nvim_create_augroup("gdscript-lsp-start", {}),
    callback = function()
        vim.lsp.start {
            name = "gdscript",
            cmd = { "curl", "127.0.0.1:6005" },
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
        }
    end,
})
