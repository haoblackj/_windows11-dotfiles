# Setup
## Windows編
1. 管理者権限でPowerShellを起動し実行。(WSLのインストールが実行される)
```
New-Item -Path "C:\WorkTmp" -ItemType Directory
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
```
2. 管理者権限でPowerShellを起動し実行。(Wingetでインストールが実行される)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))
```
3. 一般権限でPowerShellを起動し実行。(scoopでインストールが実行される)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/scoop-install.ps1'))
```
4. 一般権限でPowerShellを起動し実行。(scoop-homeでインストールが実行される)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/scoop-home-install.ps1'))
```

5. 管理者権限でPowerShellを起動し実行。(フォントの設定が実行される)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/font-install.ps1'))
```

6. 一般権限でPowerShellを起動し実行。(GitHub CLIの設定が実行される)
```
gh auth login -w
Set-Location C:\WorkTmp
gh repo clone haoblackj/AutoHotkey
gh repo clone haoblackj/_windows11-dotfiles
gh repo clone haoblackj/dotfiles
```

7. 一般権限でPowerShellを起動し実行。(chezmoiの設定が実行される)
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply haoblackj
```

## WSL編
1. WSL上で実行。
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply haoblackj
```
