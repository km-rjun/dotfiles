require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua        = { "string" },
        javascript = { "template_string" },
    },
    fast_wrap = {
        map               = '<A-e>',
        chars             = { '{', '[', '(', '"', "'" },
        pattern           = [=[[%'%"%>%]%)%}%,]]=],
        end_key           = '$',
        before_key        = 'h',
        after_key         = 'l',
        cursor_pos_before = true,
        keys              = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position   = true,
        highlight         = 'Search',
        highlight_grey    = 'Comment',
    },
})

-- blink.cmp has its own autopairs integration, no cmp event hook needed
