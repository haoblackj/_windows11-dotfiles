# WindowsUpdate���ŐV�܂œK�p�������ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�Α��s����B
$boolwindowsUpdate = Read-Host "Is Windows Update up to date? (Yes/No)"
if ($boolwindowsUpdate -eq "No") {
    exit
}
# Microsoft Store�A�v�����ŐV�܂ōX�V�������ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�Α��s����B
$storeUpdate = Read-Host "Is Microsoft Store up to date? (Yes/No)"
if ($storeUpdate -eq "No") {
    exit
}

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))

Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))

mkdir C:\WorkTmp
git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim

git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles

# WezTerm_Deploy.bat���Ǘ��҂Ƃ��Ď��s
Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/font-install.ps1'))

gh auth login -w

cd C:\WorkTmp

gh repo clone haoblackj/AutoHotkey

#pause
# Restart-Computer
