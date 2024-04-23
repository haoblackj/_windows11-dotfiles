#�������g���_�E�����[�h���A���[�U�v���t�@�C�����[�g�ɔz�u����
#�_�E�����[�h����Ă�����X�L�b�v����
if (Test-Path "$env:USERPROFILE\init.ps1") {
    Write-Host "=============================="
    Write-Host "init.ps1�͂��łɑ��݂��Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "init.ps1���_�E�����[�h���ă��[�U�v���t�@�C�����[�g�ɔz�u���܂�"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1" -OutFile "$env:USERPROFILE\init.ps1"
    # init.ps1�̔z�u���I��������m�F����
    if (Test-Path "$env:USERPROFILE\init.ps1") {
        Write-Host "init.ps1�̔z�u���������܂���"
    } else {
        Write-Host "init.ps1�̔z�u�����s���܂���"
    }
    Write-Host "=============================="
}

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

# .gitconfig�̔z�u���I����Ă��邩�m�F����
if (Test-Path "$env:USERPROFILE\.gitconfig") {
    Write-Host "=============================="
    Write-Host "gitconfig�̔z�u�͊������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    #.gitconfig�̔z�u
    Write-Host "gitconfig�̃_�E�����[�h�ƃ��[�U�v���t�@�C���ւ̔z�u"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.gitconfig" -OutFile "$env:USERPROFILE\.gitconfig"
    # .gitconfig�̔z�u���I��������m�F����
    if (Test-Path "$env:USERPROFILE\.gitconfig") {
        Write-Host "gitconfig�̔z�u���������܂���"
    } else {
        Write-Host "gitconfig�̔z�u�����s���܂���"
    }
    Write-Host "=============================="
}

# Microsoft Teams���A���C���X�g�[������Ă��邩�m�F����
$teams = Get-AppxPackage -Name MicrosoftTeams
if ($null -eq $teams) {
    Write-Host "=============================="
    Write-Host "Microsoft Teams�̓A���C���X�g�[������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "Microsoft Teams���A���C���X�g�[�����܂�"
    Write-Host "=============================="
    Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
}

# WSL�̃C���X�g�[�����������Ă��邩�m�F����
# "$env:USERPROFILE\wslInstalled.log"�����݂��Ă����犮���Ɣ��f����
# WSL�C���X�g�[�����������Ă��Ȃ��ꍇ�́AWSL�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\wslInstalled.log") {
    Write-Host "=============================="
    Write-Host "WSL�̃C���X�g�[���͊������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "WSL�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
    Write-Host "=============================="
    # 5�b�҂�
    Start-Sleep -s 5
    # OS���ċN������
    Restart-Computer
}

# �\�t�g�E�F�A���C���X�g�[�����ꂽ���m�F����
# $env:USERPROFILE\.configuration�����݂��Ă�����A�C���X�g�[������Ă���Ɣ��f����
# �C���X�g�[������Ă��Ȃ��ꍇ�́Awinget�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\.configuration") {
    Write-Host "=============================="
    Write-Host "�\�t�g�E�F�A�̓C���X�g�[������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "winget�C���X�g�[���X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))
    Write-Host "=============================="
    # 5�b�҂�
    Start-Sleep -s 5
    # OS���ċN������
    Restart-Computer
}

# ��ƃf�B���N�g�����쐬����
# ��ƃf�B���N�g�����쐬����Ă���΁A���̃t�F�[�Y�͊����Ƃ���
if (Test-Path "C:\WorkTmp") {
    Write-Host "=============================="
    Write-Host "��ƃf�B���N�g���͍쐬����Ă��܂�"
    Write-Host "=============================="
} else {
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
if (Test-Path "C:\Program Files\Git\cmd\git.exe") {
    Write-Host "=============================="
    Write-Host "Git�͎g���܂�"
    Write-Host "=============================="
    Write-Host "=============================="
    Write-Host "���|�W�g�����N���[�����܂�"
    Write-Host "=============================="
    git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim
    git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "Git���g���܂���"
    Write-Host "=============================="
}

# WezTerm�̐ݒ���s��
# WezTerm�̐ݒ肪�������Ă��邩�m�F����
# WezTerm�̐ݒ肪�������Ă��Ȃ��ꍇ�́AWezTerm�ݒ�X�N���v�g�����s����
if (Test-Path "C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat") {
    Write-Host "=============================="
    Write-Host "WezTerm�̐ݒ�͊������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "WezTerm�ݒ�X�N���v�g�����s���܂�"
    Write-Host "=============================="
    Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs
}

# �t�H���g�̃C���X�g�[�����s��
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C�������邩�m�F����
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C��������ꍇ�́A�t�H���g�C���X�g�[���ςƔ��f����
# �t�H���g�C���X�g�[���ς̃t���O�t�@�C�����Ȃ��ꍇ�́A�t�H���g�C���X�g�[���X�N���v�g�����s����
if (Test-Path "$env:USERPROFILE\fontInstalled.log") {
    Write-Host "=============================="
    Write-Host "�t�H���g�̃C���X�g�[���͊������Ă��܂�"
    Write-Host "=============================="
} else {
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
if (Test-Path "$env:USERPROFILE\.config\gh\hosts.yml") {
    Write-Host "=============================="
    Write-Host "GitHub CLI�ɃT�C���C���͊������Ă��܂�"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "GitHub CLI�ɃT�C���C�����s���܂�"
    Write-Host "=============================="
    gh auth login -w
    Set-Location C:\WorkTmp
    gh repo clone haoblackj/AutoHotkey
}

# init.ps1���A�쐬�����t���O�t�@�C�����폜����
Remove-Item -Path "$env:USERPROFILE\init.ps1" -Force
Remove-Item -Path "$env:USERPROFILE\wslInstalled.log" -Force
Remove-Item -Path "$env:USERPROFILE\fontInstalled.log" -Force

#pause
# Restart-Computer
