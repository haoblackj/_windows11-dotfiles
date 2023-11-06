local wezterm = require 'wezterm'

local config = {}

-- カラースキームの設定
config.color_scheme = 'Tokyo Night Storm (Gogh)'

-- 背景透過
config.window_background_opacity = 0.85

-- ショートカットキー設定
config.keys = {
  -- Alt+Shift+Fでフルスクリーン切り替え
  {
    key = 'F',
    mods = 'ALT|SHIFT',
    action = wezterm.action.ToggleFullScreen,
  },
  -- Ctrl+Shift+Xでコピーモードの起動
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },
  -- Ctrl+Shift+Vでクリップボードからペースト
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom("Clipboard"),
  },
}

-- フォントの設定
config.font = wezterm.font("PlemolJP HS", {weight="Medium", stretch="Normal", style="Normal"})

-- フォントサイズの設定
config.font_size = 16

-- WSL起動設定
config.default_prog = {
  "wsl.exe",
  "--distribution",
  "Ubuntu",
  "--cd",
  "/home/yagu001",
  "--exec",
  "/bin/zsh",
  "-l"
}

-- マウスの設定
config.mouse_bindings = {
  -- 右クリックでペーストする設定
  {
    event={Up={streak=1, button="Right"}},
    mods="NONE",
    action=wezterm.action{PasteFrom="Clipboard"}
  },
}

-- WSL のタブを閉じる際の挙動を設定
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

config.window_close_confirmation = 'NeverPrompt'


return config
