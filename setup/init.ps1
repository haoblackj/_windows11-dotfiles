#�������g���_�E�����[�h���A�X�^�[�g�A�b�v�t�H���_�ɔz�u����
#�_�E�����[�h����Ă�����X�L�b�v����
#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

if (Test-Path "$env:USERPROFILE\init.ps1" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "init.ps1�͂��łɑ��݂��Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "init.ps1���_�E�����[�h���ă��[�U�v���t�@�C�����[�g�ɔz�u���܂�"
    curl.exe -L "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1" -o "$env:USERPROFILE\init.ps1"
    # init.ps1�̃V���[�g�J�b�g���쐬����
    Write-Host "init.ps1�̃V���[�g�J�b�g���쐬���܂�"
    # �X�N���v�g���̂̃t���p�X
    $selfPath = "$env:USERPROFILE\init.ps1"

    # �X�^�[�g�A�b�v�t�H���_�̃p�X���擾
    $startupPath = [Environment]::GetFolderPath("Startup")

    # �V���[�g�J�b�g�̍쐬��p�X
    $shortcutPath = Join-Path -Path $startupPath -ChildPath "MyScriptShortcut.lnk"

    # WScript.Shell �I�u�W�F�N�g���쐬
    $shell = New-Object -ComObject WScript.Shell

    # �V���[�g�J�b�g�I�u�W�F�N�g���쐬
    $shortcut = $shell.CreateShortcut($shortcutPath)

    # �V���[�g�J�b�g�̃v���p�e�B��ݒ�
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$selfPath`""
    $shortcut.WorkingDirectory = Split-Path -Path $selfPath
    $shortcut.IconLocation = "powershell.exe"

    # �V���[�g�J�b�g��ۑ�
    $shortcut.Save()

    # COM �I�u�W�F�N�g�̉��
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($shell) | Out-Null

    Write-Host "init.ps1�̃V���[�g�J�b�g���쐬���܂���"

    # init.ps1�V���[�g�J�b�g�̔z�u���I��������m�F����
    if (Test-Path "$startupPath\MyScriptShortcut.lnk" -PathType Leaf) {
        Write-Host "init.ps1�̔z�u���������܂���"
    }
    else {
        Write-Host "init.ps1�̔z�u�����s���܂���"
    }
    Write-Host "=============================="
}

# WindowsUpdate���ŐV�܂œK�p�������ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�Α��s����B
$boolwindowsUpdate = Read-Host "Is Windows Update up to date? (Yes/No)"
if ($boolwindowsUpdate -eq "No") {
    exit
}

# ���s���̃��[�U�R���e�N�X�g��\������
Write-Host "=============================="
Write-Host "���s���̃��[�U�R���e�N�X�g"
Write-Host "=============================="
whoami
Write-Host "=============================="

# �A�v���C���X�g�[���[���C���X�g�[�����Ă��邩�m�F����B
# �C���X�g�[���[�t�@�C��������Α��s����B
# �Ȃ���΃C���X�g�[���[���_�E�����[�h���āA�C���X�g�[������B
if (Test-Path "$env:userprofile\appdata\local\temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "�A�v���C���X�g�[���[�͂��łɑ��݂��Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "�A�v���C���X�g�[���[���_�E�����[�h���ăC���X�g�[�����܂�"
    $latestVersion = (Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-cli/releases/latest").tag_name

    curl.exe -L "https://github.com/microsoft/winget-cli/releases/download/$latestVersion/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -o "$env:userprofile\appdata\local\temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

    # �C���X�g�[���[�̎��s
    Add-AppPackage -Path "$env:userprofile\appdata\local\temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Write-Host "=============================="
    # winget�̃o�[�W�����m�F
    winget --version
    Write-Host "=============================="
    ping localhost -n 5 > $null
}

# .gitconfig�̔z�u���I����Ă��邩�m�F����
# if (Test-Path "$env:USERPROFILE\.gitconfig" -PathType Leaf) {
#     Write-Host "=============================="
#     Write-Host "gitconfig�̔z�u�͊������Ă��܂�"
#     Write-Host "=============================="
# }
# else {
#     Write-Host "=============================="
#     #.gitconfig�̔z�u
#     Write-Host "gitconfig�̃_�E�����[�h�ƃ��[�U�v���t�@�C���ւ̔z�u"
#     wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.gitconfig" -OutFile "$env:USERPROFILE\.gitconfig"
#     # .gitconfig�̔z�u���I��������m�F����
#     if (Test-Path "$env:USERPROFILE\.gitconfig") {
#         Write-Host "gitconfig�̔z�u���������܂���"
#     }
#     else {
#         Write-Host "gitconfig�̔z�u�����s���܂���"
#     }
#     Write-Host "=============================="
# }

# Microsoft Teams���A���C���X�g�[������Ă��邩�m�F����
$teams = Get-AppxPackage -Name MicrosoftTeams
if ($null -eq $teams) {
    Write-Host "=============================="
    Write-Host "Microsoft Teams�̓A���C���X�g�[������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "Microsoft Teams���A���C���X�g�[�����܂�"
    Write-Host "=============================="
    Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
}

# UAC�̌��݂̏�Ԃ��擾
$BeforeuacStatus = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System").EnableLUA

# UAC���L���ȏꍇ�i$uacStatus��1�̏ꍇ�j�A����𖳌��ɂ���
if ($BeforeuacStatus -eq 1) {
    # UAC�𖳌��ɐݒ�
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -Value 0
    # UAC�̖��������������邽�߂ɍċN������
    Write-Host "UAC has been disabled. Restarting the computer..."
    # 5�b�҂�
    ping localhost -n 5 > $null
    # OS���ċN������
    Restart-Computer
    exit
} else {
    # UAC�����ɖ����ȏꍇ
    Write-Host "UAC is already disabled."
}


# WSL�̃C���X�g�[�����������Ă��邩�m�F����
# "$env:USERPROFILE\wslInstalled.log"�����݂��Ă����犮���Ɣ��f����
# WSL�C���X�g�[�����������Ă��Ȃ��ꍇ�́AWSL�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\wslInstalled.log" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "WSL�̃C���X�g�[���͊������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "WSL�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
    Write-Host "=============================="
    # WSL�C���X�g�[�������������ƃ��b�Z�[�W��\������
    Write-Host "WSL�̃C���X�g�[�����������܂���"
    # 5�b�҂�
    ping localhost -n 5 > $null
    # OS���ċN������
    Restart-Computer
    exit
}

# �\�t�g�E�F�A���C���X�g�[�����ꂽ���m�F����
# $env:USERPROFILE\.configuration\winget-install.done�����݂��Ă�����A�C���X�g�[������Ă���Ɣ��f����
# �C���X�g�[������Ă��Ȃ��ꍇ�́Awinget�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\.configuration\winget-install.done" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "�\�t�g�E�F�A�̓C���X�g�[������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "winget�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))
    Write-Host "=============================="
    # 5�b�҂�
    ping localhost -n 5 > $null
    # OS���ċN������
    Restart-Computer
    exit
}

# scoop���C���X�g�[������Ă��邩�m�F����
# scoop���C���X�g�[������Ă��Ȃ��ꍇ�́Ascoop�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\scoop" -PathType Container) {
    Write-Host "=============================="
    Write-Host "scoop�̓C���X�g�[������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "scoop�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    # scoop�C���X�g�[���X�N���v�g�����s����
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/scoop-install.ps1'))
    Write-Host "=============================="
}

# ��ƃf�B���N�g�����쐬����
# ��ƃf�B���N�g�����쐬����Ă���΁A���̃t�F�[�Y�͊����Ƃ���
if (Test-Path "C:\WorkTmp" -PathType Container) {
    Write-Host "=============================="
    Write-Host "��ƃf�B���N�g���͍쐬����Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "��ƃf�B���N�g�����쐬���܂�"
    Write-Host "=============================="
    New-Item -Path "C:\WorkTmp" -ItemType Directory
}

# Git���g���邩�m�F����
# Git���g����ꍇ�́A���L�ӂ��̃��|�W�g�����N���[������
# 1. spzenhan.vim
# 2. _windows11-dotfiles
# �g���Ȃ��ꍇ�̓G���[���b�Z�[�W��\������
# scoop�ŃC���X�g�[������Git���g��
if (Test-Path "C:\Users\$env:USERNAME\scoop\apps\git\current\mingw64\bin\git.exe" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "Git�͎g���܂�"
    Write-Host "=============================="
    # Get the current Windows username
    $username = [System.Environment]::UserName

    # Set the Git Credential Manager path based on the username
    $credentialHelper = "c:\Users\$username\scoop\apps\git\current\mingw64\bin\git-credential-manager.exe"

    git config --global credential.helper $credentialHelper

    Write-Host "=============================="
    Write-Host "���|�W�g�����N���[�����܂�"
    Write-Host "=============================="
    git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim
    git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "Git���g���܂���"
    Write-Host "=============================="
}

# WezTerm�̐ݒ���s��
# WezTerm�̐ݒ肪�������Ă��邩�m�F����
# WezTerm�̐ݒ肪�������Ă��Ȃ��ꍇ�́AWezTerm�ݒ�X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\.wezterm.lua" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "WezTerm�̐ݒ�͊������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "WezTerm�ݒ�X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs
}

# �t�H���g�̃C���X�g�[�����s��
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C�������邩�m�F����
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C��������ꍇ�́A�t�H���g�C���X�g�[���ςƔ��f����
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C�����Ȃ��ꍇ�́A�t�H���g�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\fontInstalled.log" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "�t�H���g�̃C���X�g�[���͊������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "�t�H���g�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    # ���[�J���ɃN���[�������t�H���g�C���X�g�[���X�N���v�g�����s����
    # "C:\WorkTmp\_windows11-dotfiles\setup\ps1\font-install.ps1"�����s����
    # ���炽�߂ă_�E�����[�h�͂��Ȃ�!
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression "C:\WorkTmp\_windows11-dotfiles\setup\ps1\font-install.ps1"
    # �t�H���g�C���X�g�[���ς̃t���O�t�@�C�����쐬
    $fontInstallFlagFile = "$env:USERPROFILE\fontInstalled.log"
    New-Item -Path $fontInstallFlagFile -ItemType File -Force
    Write-Host "=============================="
}

# GitHub CLI�ɃT�C���C�����s��
# GitHub CLI�ɃT�C���C�����������Ă��邩�m�F����
# GitHub CLI�ɃT�C���C�����������Ă��Ȃ��ꍇ�́A�T�C���C�������s����
if (Test-Path "$env:USERPROFILE\.config\gh\hosts.yml" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "GitHub CLI�ɃT�C���C���͊������Ă��܂�"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "GitHub CLI�ɃT�C���C�����s���܂�"
    Write-Host "=============================="
    gh auth login -w
    Set-Location C:\WorkTmp
    gh repo clone haoblackj/AutoHotkey
}

# init.ps1���A�쐬�����t���O�t�@�C���A�V���[�g�J�b�g���폜����
# �X�^�[�g�A�b�v�t�H���_�̃p�X���擾
$startupPath = [Environment]::GetFolderPath("Startup")
Remove-Item -Path "$env:USERPROFILE\init.ps1" -Force
Remove-Item -Path "$env:USERPROFILE\wslInstalled.log" -Force
Remove-Item -Path "$env:USERPROFILE\fontInstalled.log" -Force
Remove-Item -Path "$startupPath\MyScriptShortcut.lnk" -Force

# UAC�̌��݂̏�Ԃ��擾
$AfteruacStatus = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System").EnableLUA

# UAC�������ȏꍇ�i$uacStatus��0�̏ꍇ�j�A�����L���ɂ���
if ($AfteruacStatus -eq 0) {
    # UAC��L���ɐݒ�
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -Value 1

    # ���[�U�[�ɃV�X�e���̍ċN���𑣂�
    Write-Host "UAC has been enabled. Please restart your system for changes to take effect."
    # 5�b�҂�
    ping localhost -n 5 > $null
    # OS���ċN������
    Restart-Computer
    exit
} else {
    # UAC�����ɗL���ȏꍇ
    Write-Host "UAC is already enabled."
}

#pause
# Restart-Computer
