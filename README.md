# Setup
## Windows編
1. WindowsUpdateを実行し、最新の状態にする。
```
usoclient startscan
usoclient startdownload
usoclient scaninstallwait
usoclient startinteractivescan
start ms-settings:windowsupdate
start ms-settings:windowsupdate-action
```
1. Microsoft Storeからストアアプリをアップデートする。
1. 管理者権限でPowerShellを起動し実行。
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1'))
```

2. manually_settings.txtを参考に手動でセットアップを進める。

## WSL編
1. WSL上で実行。
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply haoblackj
```
