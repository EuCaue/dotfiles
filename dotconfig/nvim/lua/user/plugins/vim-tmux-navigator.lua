return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "i", "n" } },
        { "<c-h>",  "<cmd>TmuxNavigateLeft<cr>",     mode = { "i", "n" } },
        { "<c-j>",  "<cmd>TmuxNavigateDown<cr>",     mode = { "i", "n" } },
        { "<c-k>",  "<cmd>TmuxNavigateUp<cr>",       mode = { "i", "n" } },
        { "<c-l>",  "<cmd>TmuxNavigateRight<cr>",    mode = { "i", "n" } },
    },
}
