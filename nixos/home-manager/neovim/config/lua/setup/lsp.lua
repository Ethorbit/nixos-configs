require("mason").setup()
require("mason-lspconfig").setup()
require("lint")
require("formatter").setup()

local lspconfig = require("lspconfig")

local function add(name, config)
    lspconfig[name].setup(config or {})
end

add("nil_ls")

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
add("ts_ls")
add("lua_ls")
add("phpactor")
add("svelte")
add("pylsp", {
    plugins = {
        flake8 = { enabled = true },
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = true },
        pycodestyle = { enabled = true },
        pylsp_mypy = { enabled = true },
        pyls_isort = { enabled = true },
    }
})
add("intelephense")
add("dockerls")
add("docker_compose_language_service")
add("csharp_ls")
add("qmlls")
add("gdscript")
