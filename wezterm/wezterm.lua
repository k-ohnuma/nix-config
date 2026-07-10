local config_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
if config_dir then
  package.path = config_dir .. "?.lua;" .. package.path
end

return require("darwin")
