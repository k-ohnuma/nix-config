local wezterm = require("wezterm")
local config = require("common")

config.macos_window_background_blur = 0

table.insert(config.keys, { key = "u", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) })
table.insert(config.keys, { key = "y", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) })
table.insert(config.keys, { key = "+", mods = "CMD|SHIFT", action = wezterm.action.IncreaseFontSize })
table.insert(config.keys, { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) })
table.insert(config.keys, { key = "h", mods = "CMD|CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 8 }) })
table.insert(config.keys, { key = "j", mods = "CMD|CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 8 }) })
table.insert(config.keys, { key = "k", mods = "CMD|CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 8 }) })
table.insert(
  config.keys,
  { key = "l", mods = "CMD|CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 8 }) }
)

return config
