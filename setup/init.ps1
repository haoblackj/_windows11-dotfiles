Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install-development-tools.ps1'))
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
reg.exe add "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /f /ve
winget install -e --id Google.JapaneseIME
while ($true) {
    $home = Read-Host -Prompt "����[���ł����H (Yes/No)"

    if ($home -ieq 'Yes') {
        Write-Host "����̐ݒ�����s���܂��B"
        winget install -e --id Google.Drive
        winget install -e --id LINE.LINE
        winget install -e --id Amazon.Kindle
        break
    }
    elseif ($home -ieq 'No') {
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
