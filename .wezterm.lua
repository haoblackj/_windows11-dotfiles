local wezterm = require 'wezterm'

local config = {}

front_end = "OpenGL"

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
  {
    label = "ArchLinux - zsh",
    args = {"wsl.exe", "--distribution", "ArchLinux", "--cd", "/home/yagu001", "--exec", "/bin/zsh", "-l"}
  },
  {
    label = "ArchLinux - bash",
    args = {"wsl.exe", "--distribution", "ArchLinux", "--cd", "/home/yagu001", "--exec", "/bin/bash", "-l"}
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


config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 9.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}


config.window_close_confirmation = 'NeverPrompt'

config.window_decorations="INTEGRATED_BUTTONS|RESIZE"

-- 背景の設定
config.window_background_opacity = 0.5

config.window_background_image = "C:\\WorkTmp\\mMeyexn.jpeg"
config.window_background_image_hsb = {
  -- 背景画像の明るさ
  -- 1.0で元画像から変更なし
  brightness = 0.5,
  -- 色相の設定
  -- 1.0で元画像から変更なし
  hue = 1.0,
  -- 彩度の調整
  -- 1.0で元画像から変更なし
  saturation = 1.0,
}

return config
