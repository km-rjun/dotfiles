local lint = require("lint")

-- Helper: only register a linter if the binary actually exists on PATH
local function has_bin(name)
    return vim.fn.executable(name) == 1
end

local linters_by_ft = {
    yaml       = { "yamllint" },
    sh         = { "shellcheck" },
    bash       = { "shellcheck" },
    python     = { "pylint" },
    terraform  = { "tflint" },
    dockerfile = { "hadolint" },
}

-- Filter out linters whose binaries are not installed
local filtered = {}
for ft, linters in pairs(linters_by_ft) do
    local available = {}
    for _, linter in ipairs(linters) do
        if has_bin(linter) then
            table.insert(available, linter)
        end
    end
    if #available > 0 then
        filtered[ft] = available
    end
end

lint.linters_by_ft = filtered

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
    group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
    callback = function()
        lint.try_lint()
    end,
})

vim.keymap.set("n", "<leader>cl", function()
    lint.try_lint()
end, { desc = "Trigger linting" })
