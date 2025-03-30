return {
  "sphamba/smear-cursor.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.3      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false,
    cterm_cursor_colors = { 240, 245, 250, 255 },
    cterm_bg = 235,
    smear_insert_mode = false,
  },
}
