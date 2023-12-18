local wezterm = require 'wezterm'

local config = {}

-- カラースキームの設定
config.color_scheme = 'Tokyo Night Storm (Gogh)'

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
config.font = wezterm.font("Firge35Nerd Console", {weight="Medium", stretch="Normal", style="Normal"})

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

-- 起動メニュー設定
config.launch_menu = {
  -- 既存のWSLの設定をここに追加（必要に応じて）
  {
    label = "Ubuntu (WSL)",
    args = {"wsl.exe", "--distribution", "Ubuntu", "--cd", "/home/yagu001", "--exec", "/bin/zsh", "-l"}
  },
  -- PowerShell 7.4の設定
  {
    label = "PowerShell 7.4",
    args = {"C:\\Program Files\\PowerShell\\7\\pwsh.exe"}
  },
  -- cmdの設定
  {
    label = "Command Prompt",
    args = {"cmd.exe"}
  },
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

config.window_decorations="RESIZE"

return config
