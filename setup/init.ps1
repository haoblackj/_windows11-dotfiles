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

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
# winget install --id Microsoft.DevHome -e
# Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
# Add-AppxPackage -Path winget.msixbundle
# rm winget.msixbundle
# Get-AppxPackage -OutVariable apps | ForEach-Object { Get-AppxPackage -Name $_.Name -OutVariable app; if ($app.SignatureKind -eq 'Store') { Get-AppxPackageUpdate -Name $_.Name | Update-AppxPackage } }
# Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# winget install -e --id Google.JapaneseIME
# winget upgrade --id Microsoft.Winget.Source
Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
New-Item -Path $env:USERPROFILE\.configuration -ItemType Directory
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-desktop-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
winget configure $env:USERPROFILE\.configuration\configuration.dsc.yaml
# ����pPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-configuration.dsc.yaml��K�p����B
$homeMachine = Read-Host "Is this home PC? (Yes/No)"
if ($homeMachine -eq "Yes") {
    winget configure $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
    # �f�X�N�g�b�vPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-desktop-configuration.dsc.yaml��K�p����B
    $desktopMachine = Read-Host "Is this home desktop PC? (Yes/No)"
    if ($desktopMachine -eq "Yes") {
        winget configure $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
    }
}
#

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

#pause
# Restart-Computer
