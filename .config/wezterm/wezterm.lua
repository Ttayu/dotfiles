local wezterm = require("wezterm")

local env = {}
local launch_menu = {}
local default_prog = { "/bin/zsh", "-l" }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    env["TERM"] = ""
    default_prog = { "wsl.exe" }
    table.insert(launch_menu, { label = "PowerShell", args = {"powershell.exe", "-NoLogo"} })
else
    table.insert(launch_menu, { label = "bash", args = {"bash", "-l"} })
    table.insert(launch_menu, { label = "zsh", args = {"fish", "-l"} })
end

local config = {
    use_ime = true,
    term = "xterm-256color",
    check_for_updates = true,
    default_prog = default_prog,
    font = wezterm.font_with_fallback({
        "Cica",
    }),
    color_scheme = "tokyonight_night",
    color_scheme_dirs = {"~/.config/wezterm/colors/"},
    font_size = 10.0,
    launch_menu = launch_menu,
    set_environment_variables = env,
    disable_default_key_bindings = true,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.95,

    leader = { key="g", mods="CTRL" },
    keys = {
        { key = "-", mods = "LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
        { key = "|", mods = "LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
        { key = "z", mods = "LEADER", action="TogglePaneZoomState" },
        { key = "c", mods = "LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
        { key = "h", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "j", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
        { key = "k", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "l", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
        { key = "n", mods = "LEADER", action=wezterm.action{ActivateTabRelative=1}},
        { key = "p", mods = "LEADER", action=wezterm.action{ActivateTabRelative=-1}},
        { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
        { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
        { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
        { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
        { key = "1", mods = "LEADER", action=wezterm.action{ActivateTab=0}},
        { key = "2", mods = "LEADER", action=wezterm.action{ActivateTab=1}},
        { key = "3", mods = "LEADER", action=wezterm.action{ActivateTab=2}},
        { key = "4", mods = "LEADER", action=wezterm.action{ActivateTab=3}},
        { key = "5", mods = "LEADER", action=wezterm.action{ActivateTab=4}},
        { key = "6", mods = "LEADER", action=wezterm.action{ActivateTab=5}},
        { key = "7", mods = "LEADER", action=wezterm.action{ActivateTab=6}},
        { key = "8", mods = "LEADER", action=wezterm.action{ActivateTab=7}},
        { key = "9", mods = "LEADER", action=wezterm.action{ActivateTab=8}},
        {key="&", mods="LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}},
        {key="x", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=false}}},

        -- Copy (to Clipboard) / Paste (from Clipboard or PrimarySelection)
        {key="C", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},
        {key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
        {key="Insert", mods="SHIFT", action=wezterm.action{PasteFrom="PrimarySelection"}},

        {key="0", mods="LEADER", action="ResetFontSize"},
        {key="_", mods="LEADER|SHIFT", action="DecreaseFontSize"},
        {key="+", mods="LEADER|SHIFT", action="IncreaseFontSize"},

        {key="[", mods="LEADER", action="ActivateCopyMode"},
    }
}

return config
