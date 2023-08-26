Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
reg.exe add "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /f /ve
# winget install -e --id Google.JapaneseIME
while ($true) {
    $home_terminal = Read-Host -Prompt "自宅端末ですか？ (Yes/No)"

    if ($home_terminal -ieq 'Yes') {
        Write-Host "自宅の設定を実行します。"
        Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
        winget install -e --id Google.Drive
        winget install -e --id LINE.LINE
        winget install -e --id Amazon.Kindle
        winget install -e --id OBSProject.OBSStudio
        winget install -e --id Anki.Anki
        winget install -e --id Mozilla.Firefox
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
