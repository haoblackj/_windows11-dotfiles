Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
Get-AppxPackage -OutVariable apps | ForEach-Object { Get-AppxPackage -Name $_.Name -OutVariable app; if ($app.SignatureKind -eq 'Store') { Get-AppxPackageUpdate -Name $_.Name | Update-AppxPackage } }
# Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# winget install -e --id Google.JapaneseIME
# winget upgrade --id Microsoft.Winget.Source
winget settings --enable InstallerHashOverride
winget install -e --id Google.JapaneseIME --ignore-security-hash
winget install -e --id Google.Chrome --ignore-security-hash
winget install -e --id Bitwarden.Bitwarden --ignore-security-hash
winget install -e --id voidtools.Everything --ignore-security-hash
winget install -e --id stnkl.EverythingToolbar --ignore-security-hash
winget install -e --id Bandisoft.Honeyview --ignore-security-hash
winget install -e --id SumatraPDF.SumatraPDF --ignore-security-hash
winget install -e --id valinet.ExplorerPatcher --ignore-security-hash
winget install -e --id Microsoft.Office --ignore-security-hash
winget install -e --id Microsoft.WindowsADK --ignore-security-hash
winget install -e --id AutoHotkey.AutoHotkey --ignore-security-hash
while ($true) {
    $home_terminal = Read-Host -Prompt "自宅端末ですか？ (Yes/No)"

    if ($home_terminal -ieq 'Yes') {
        Write-Host "自宅の設定を実行します。"
        winget install -e --id AdGuard.AdGuard --ignore-security-hash
        winget install -e --id File-New-Project.EarTrumpet --ignore-security-hash
        winget install -e --id CubeSoft.CubePDF --ignore-security-hash
        winget install -e --id Amazon.Kindle --ignore-security-hash
        winget install -e --id OBSProject.OBSStudio --ignore-security-hash
        winget install -e --id Anki.Anki --ignore-security-hash
        winget install -e --id Mozilla.Firefox --ignore-security-hash
        winget install -e --id DigitalScholar.Zotero --ignore-security-hash
        winget install -e --id Synology.ActiveBackupForBusinessAgent --ignore-security-hash
        winget install -e --id ogdesign.Eagle --ignore-security-hash
        break
    }
    elseif ($home_terminal -ieq 'No') {
        Write-Host "自宅以外の設定を実行します。"
        # ここに自宅以外の端末用の設定スクリプトを入れてください。
        break
    }
    else {
        Write-Host "無効な入力です。YesかNoを入力してください。"
    }
}

pause
Restart-Computer
