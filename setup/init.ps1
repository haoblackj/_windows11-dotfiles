Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
# winget install --id Microsoft.DevHome -e
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
Add-AppxPackage -Path winget.msixbundle
rm winget.msixbundle
# Get-AppxPackage -OutVariable apps | ForEach-Object { Get-AppxPackage -Name $_.Name -OutVariable app; if ($app.SignatureKind -eq 'Store') { Get-AppxPackageUpdate -Name $_.Name | Update-AppxPackage } }
# Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# winget install -e --id Google.JapaneseIME
# winget upgrade --id Microsoft.Winget.Source
Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
Invoke-WebClient -Uri https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\configuration.dsc.yaml
Invoke-WebClient -Uri https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
Invoke-WebClient -Uri https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-desktop-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
winget configure $env:USERPROFILE\.configuration\configuration.dsc.yaml
# 自宅用PCかどうか、Yes/Noで質問する。Yesならば、home-configuration.dsc.yamlを適用する。
$homeMachine = Read-Host "Is this home PC? (Yes/No)"
if ($homeMachine -eq "Yes") {
    winget configure $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
    # デスクトップPCかどうか、Yes/Noで質問する。Yesならば、home-desktop-configuration.dsc.yamlを適用する。
    $desktopMachine = Read-Host "Is this home desktop PC? (Yes/No)"
    if ($desktopMachine -eq "Yes") {
        winget configure $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
    }
}
#

pause
# Restart-Computer
