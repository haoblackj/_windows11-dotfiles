Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# winget install -e --id Google.JapaneseIME
winget settings --enable InstallerHashOverride
winget install -e --id Google.JapaneseIME --ignore-security-hash
winget install -e --id valinet.ExplorerPatcher --ignore-security-hash
winget install -e --id Microsoft.Office --ignore-security-hash
winget install -e --id Microsoft.WindowsADK --ignore-security-hash
while ($true) {
    $home_terminal = Read-Host -Prompt "����[���ł����H (Yes/No)"

    if ($home_terminal -ieq 'Yes') {
        Write-Host "����̐ݒ�����s���܂��B"
        winget install -e --id LINE.LINE --ignore-security-hash
        winget install -e --id Amazon.Kindle --ignore-security-hash
        winget install -e --id OBSProject.OBSStudio --ignore-security-hash
        winget install -e --id Anki.Anki --ignore-security-hash
        winget install -e --id Mozilla.Firefox --ignore-security-hash
        break
    }
    elseif ($home_terminal -ieq 'No') {
        Write-Host "����ȊO�̐ݒ�����s���܂��B"
        # �����Ɏ���ȊO�̒[���p�̐ݒ�X�N���v�g�����Ă��������B
        break
    }
    else {
        Write-Host "�����ȓ��͂ł��BYes��No����͂��Ă��������B"
    }
}

pause
Restart-Computer
