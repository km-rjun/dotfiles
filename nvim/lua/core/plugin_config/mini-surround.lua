require("mini.surround").setup({
    -- sa = add surrounding    e.g. saiw" → "word"
    -- sd = delete surrounding e.g. sd"   → word
    -- sr = replace surrounding e.g. sr"' → 'word'
    mappings = {
        add            = "sa",
        delete         = "sd",
        find           = "sf",
        find_left      = "sF",
        highlight      = "sh",
        replace        = "sr",
        update_n_lines = "sn",
    },
})
