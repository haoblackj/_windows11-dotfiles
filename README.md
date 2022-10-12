# Setup
## Windows編
1. 管理者権限でPowerShellを起動し実行。
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1'))
```

2. manually_settings.txtを参考に手動でセットアップを進める。

## WSL編
1. WSL上で実行。
```
gh repo clone https://github.com/haoblackj/dotfiles.git
dotfiles/install.sh
```
