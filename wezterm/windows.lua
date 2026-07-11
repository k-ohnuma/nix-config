local wezterm = require("wezterm")
local config = require("common")

local distro = "ubuntu26"

config.default_domain = "WSL:" .. distro

local function key(key, mods, action)
  table.insert(config.keys, { key = key, mods = mods, action = action })
end

key("u", "SUPER", wezterm.action.ActivateTabRelative(1))
key("y", "SUPER", wezterm.action.ActivateTabRelative(-1))
key("+", "SUPER|SHIFT", wezterm.action.IncreaseFontSize)
key("w", "SUPER", wezterm.action.CloseCurrentPane({ confirm = false }))

key("h", "SUPER|CTRL|SHIFT", wezterm.action.AdjustPaneSize({ "Left", 8 }))
key("j", "SUPER|CTRL|SHIFT", wezterm.action.AdjustPaneSize({ "Down", 8 }))
key("k", "SUPER|CTRL|SHIFT", wezterm.action.AdjustPaneSize({ "Up", 8 }))
key("l", "SUPER|CTRL|SHIFT", wezterm.action.AdjustPaneSize({ "Right", 8 }))

return config
