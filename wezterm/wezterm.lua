local wezterm = require("wezterm")

package.path = wezterm.config_dir .. "/?.lua;" .. package.path

return require("darwin")
