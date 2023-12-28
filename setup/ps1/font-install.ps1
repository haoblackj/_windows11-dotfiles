function DownloadLatestReleaseZip {
    param(
        [string]$owner,
        [string]$repo,
        [string]$filenamePrefix,
        [string]$filenamePostfix,
        [string]$savePath
    )

    # GitHub API���g�p���čŐV�̃����[�X�����擾���܂�
    $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/releases/latest"

    # �ŐV�̃����[�X�^�O���擾���܂�
    $latestTag = $latestRelease.tag_name

    # ZIP�t�@�C����URL���쐬���܂�
    $zipUrl = "https://github.com/$owner/$repo/releases/download/$latestTag/$filenamePrefix$latestTag$filenamePostfix.zip"

    # ZIP�t�@�C�����_�E�����[�h���܂�
    Invoke-WebRequest -Uri $zipUrl -OutFile $savePath
}

# �J�����g�f�B���N�g�����擾���܂�
$currentDir = Get-Location

# �J�����g�f�B���N�g���� 'C:\WorkTmp' �łȂ���΁A����ɕύX���܂�
if ($currentDir -ne 'C:\WorkTmp') {
    Set-Location -Path 'C:\WorkTmp'
}

# �f�B���N�g���p�X��ݒ肵�܂�
$dirPath = 'C:\WorkTmp\fonts'

# �f�B���N�g�������݂��Ȃ��ꍇ�A�쐬���܂�
if (!(Test-Path -Path $dirPath)) {
    New-Item -ItemType Directory -Path $dirPath
}

Set-Location -path C:\WorkTmp\fonts

DownloadLatestReleaseZip -owner "yuru7" -repo "PlemolJP" -filenamePrefix "PlemolJP_HS_" -filenamePostfix "" -savePath "PlemolJP_HS_latest.zip"
DownloadLatestReleaseZip -owner "yuru7" -repo "Firge" -filenamePrefix "FirgeNerd_" -filenamePostfix "" -savePath "FirgeNerd_latest.zip"

# �����A����pPC�Ȃ�΁Ahome�f�B���N�g����home�p�̃t�H���g���_�E�����[�h���܂�
if ($homeMachine -eq "Yes") {
    if (!(Test-Path -Path 'C:\WorkTmp\fonts\home')) {
        New-Item -ItemType Directory -Path 'C:\WorkTmp\fonts\home'
    }
    Set-Location -path C:\WorkTmp\fonts\home

    DownloadLatestReleaseZip -owner "haoblackj" -repo "dotfiles-private" -filenamePrefix "" -filenamePostfix "" -savePath "home_font_latest.zip"

    set-location -path C:\WorkTmp\fonts
}

# ZIP�t�@�C����W�J���܂�
Expand-Archive -Path "PlemolJP_HS_latest.zip" -DestinationPath "PlemolJP_HS_latest"
Expand-Archive -Path "FirgeNerd_latest.zip" -DestinationPath "FirgeNerd_latest"

# �����A����pPC�Ȃ�΁Ahome�f�B���N�g����home�p�̃t�H���g��W�J���܂�
if ($homeMachine -eq "Yes") {
    Set-Location -path C:\WorkTmp\fonts\home
    Expand-Archive -Path "home_font_latest.zip" -DestinationPath "home_font_latest"
    set-location -path C:\WorkTmp\fonts
}

# ZIP�t�@�C�����폜���܂�
Remove-Item -Path "PlemolJP_HS_latest.zip"
Remove-Item -Path "FirgeNerd_latest.zip"

# �����A����pPC�Ȃ�΁Ahome�f�B���N�g����home�p�̃t�H���g���폜���܂�
if ($homeMachine -eq "Yes") {
    Set-Location -path C:\WorkTmp\fonts\home
    Remove-Item -Path "home_font_latest.zip"
    set-location -path C:\WorkTmp\fonts
}

# �t�H���g���C���X�g�[�����܂�
# �܂��́A�t�H���g�̃C���X�g�[���ɕK�v��PowerShell���W���[�����C���X�g�[������
Install-Module PPoshTools -Force
# �t�H���g���C���X�g�[������
Add-Font -Path C:\WorkTmp\fonts

if ($homeMachine -eq "Yes") {
    Add-Font -Path C:\WorkTmp\fonts\home
}
