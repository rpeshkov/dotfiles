local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'OneDark (base16)'
-- config.color_scheme = 'Windows NT Light (base16)'
config.font = wezterm.font('JetBrainsMono NF', { weight = 'Medium' })
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 12.0
config.line_height = 1.1
config.default_prog = { '/opt/homebrew/bin/tmux', 'new-session', '-A', '-s', 'tmux' }
config.enable_tab_bar = false


config.window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0
}

config.keys = {
    -- tmux splits
    { key = 'd', mods = 'CMD', action = wezterm.action.SendString '\x13\x6c', },
    { key = 'D', mods = 'CMD', action = wezterm.action.SendString '\x13\x6a', },

    -- tmux tabs
    { key = 't', mods = 'CMD', action = wezterm.action.SendString '\x13\x63', },
    { key = '1', mods = 'CMD', action = wezterm.action.SendString '\x13\x31', },
    { key = '2', mods = 'CMD', action = wezterm.action.SendString '\x13\x32', },
    { key = '3', mods = 'CMD', action = wezterm.action.SendString '\x13\x33', },
    { key = '4', mods = 'CMD', action = wezterm.action.SendString '\x13\x34', },
    { key = '5', mods = 'CMD', action = wezterm.action.SendString '\x13\x35', },
    { key = '6', mods = 'CMD', action = wezterm.action.SendString '\x13\x36', },
    { key = '7', mods = 'CMD', action = wezterm.action.SendString '\x13\x37', },
    { key = '8', mods = 'CMD', action = wezterm.action.SendString '\x13\x38', },
}

return config
