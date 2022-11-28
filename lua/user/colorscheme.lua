-- local colorscheme = "aurora"
-- local colorscheme = "dracula"
-- local colorscheme = "gruvbox"
-- local colorscheme = "lunar"
-- local colorscheme = "matanoia"
-- local colorscheme = "nord"
local colorscheme = "nvcode"
-- local colorscheme = "onedark"
-- local colorscheme = "palenight"
-- local colorscheme = "snazzy"
-- local colorscheme = "xoria"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
