Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
winget install --id Microsoft.DevHome -e
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
Add-AppxPackage -Path winget.msixbundle
rm winget.msixbundle
# Get-AppxPackage -OutVariable apps | ForEach-Object { Get-AppxPackage -Name $_.Name -OutVariable app; if ($app.SignatureKind -eq 'Store') { Get-AppxPackageUpdate -Name $_.Name | Update-AppxPackage } }
# Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# winget install -e --id Google.JapaneseIME
# winget upgrade --id Microsoft.Winget.Source
Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
pause
# Restart-Computer
