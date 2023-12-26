# WindowsUpdateを最新まで適用したかどうか、Yes/Noで質問する。Yesならば続行する。
$boolwindowsUpdate = Read-Host "Is Windows Update up to date? (Yes/No)"
if ($boolwindowsUpdate -eq "No") {
    exit
}
# Microsoft Storeアプリを最新まで更新したかどうか、Yes/Noで質問する。Yesならば続行する。
$storeUpdate = Read-Host "Is Microsoft Store up to date? (Yes/No)"
if ($storeUpdate -eq "No") {
    exit
}

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/chocolatey-install.ps1'))

Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))

mkdir C:\WorkTmp
git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim

git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles

# WezTerm_Deploy.batを管理者として実行
Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs

# フォントのダウンロード
Invoke-WebRequest "https://github.com/haoblackj/dotfiles-private/releases/latest/download/v1.3.0.zip" -OutFile "fonts.zip"

Expand-Archive -Path fonts.zip -DestinationPath C:\WorkTmp\fonts

# ダウンロードした*.ttfファイルをインストールする
# まずは、フォントのインストールに必要なPowerShellモジュールをインストールする
Install-Module PPoshTools -Force
# フォントをインストールする
Add-Font -Path C:\WorkTmp\fonts\common

if ($homeMachine -eq "Yes") {
    Add-Font -Path C:\WorkTmp\fonts\home
}

gh auth login -w

cd C:\WorkTmp

gh repo clone haoblackj/AutoHotkey

#pause
# Restart-Computer
