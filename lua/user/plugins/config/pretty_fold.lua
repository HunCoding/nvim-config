require("pretty-fold").setup({
    fill_char = " ",
    sections = {
        left = {
            "content",
        },
        right = {
            " ",
            "number_of_folded_lines",
            " ",
            function(config)
                return config.fill_char:rep(3)
            end,
        },
    },
    remove_fold_markers = true,
    keep_indentation = true,
    process_comment_signs = "spaces",
    stop_words = {
        "@brief%s*",
    },
    add_close_pattern = true,
    matchup_patterns = {
        { "{", "}" },
        { "%(", ")" },
        { "%[", "]" },
        { "if%s", "end" },
        { "do%s", "end" },
        { "for%s", "end" },
    },
})
