require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

-- Diagnostic signs
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = "",
    })
end

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        style = "minimal",
    },
})

-- Rounded borders for hover & signature help
local function with_border(handler)
    return function(err, result, ctx, config)
        config = config or {}
        config.border = "rounded"
        return handler(err, result, ctx, config)
    end
end

vim.lsp.handlers["textDocument/hover"] =
    with_border(vim.lsp.handlers["textDocument/hover"])
vim.lsp.handlers["textDocument/signatureHelp"] =
    with_border(vim.lsp.handlers["textDocument/signatureHelp"])

-- LSP server configs
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}

vim.lsp.config.rust_analyzer = { capabilities = capabilities }
vim.lsp.config.jdtls         = { capabilities = capabilities }
vim.lsp.config.pyright       = { capabilities = capabilities }
vim.lsp.config.ts_ls         = { capabilities = capabilities }

-- Keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "<space>gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<space>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<space>K",  vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<space>gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<space>D",  vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

