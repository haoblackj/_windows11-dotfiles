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
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/chocolatey-install.ps1'))

Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))

mkdir C:\WorkTmp
git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim

git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles

# WezTerm_Deploy.bat���Ǘ��҂Ƃ��Ď��s
Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs

# �t�H���g�̃_�E�����[�h
Invoke-WebRequest "https://github.com/haoblackj/dotfiles-private/releases/latest/download/v1.3.0.zip" -OutFile "fonts.zip"

Expand-Archive -Path fonts.zip -DestinationPath C:\WorkTmp\fonts

# �_�E�����[�h����*.ttf�t�@�C�����C���X�g�[������
# �܂��́A�t�H���g�̃C���X�g�[���ɕK�v��PowerShell���W���[�����C���X�g�[������
Install-Module PPoshTools -Force
# �t�H���g���C���X�g�[������
Add-Font -Path C:\WorkTmp\fonts\common

if ($homeMachine -eq "Yes") {
    Add-Font -Path C:\WorkTmp\fonts\home
}

gh auth login -w

cd C:\WorkTmp

gh repo clone haoblackj/AutoHotkey

#pause
# Restart-Computer
