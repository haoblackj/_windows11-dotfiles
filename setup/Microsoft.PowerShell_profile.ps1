
<#
    .SYNOPSIS
    bitwarden CLI�̃Z�b�V�������J�n���܂��B
    .Description
    bitwarden CLI �ŕۊǌɂ��A�����b�N���A���s���ꂽ�Z�b�V�����L�[�����ϐ��ɐݒ肵�܂��B
#>
function Start-BwSession {
    # bitwarden�̃X�e�[�^�X���擾
    $status = bw.exe status | ConvertFrom-Json
    $session = $null
    # �����O�C���̏ꍇ
    if ($status.status -eq "unauthenticated") {
        Write-Host "bitwarden��login���܂�"
        $session = bw.exe login
    }
    # ���b�N��Ԃ̏ꍇ
    elseif ($status.status -eq "locked") {
        Write-Host "�ۊǌɂ�Unlock���܂�"
        $session = bw.exe unlock
    }
    # ���O�C���ς݂̏ꍇ�͉������Ȃ�

    # login�Aunlock������
    if ($null -ne $session) {
        # login�Aunlock����A���Ă��镶���񂩂�A�Z�b�V�����L�[�݂̂����o��
        $key = $session`
        | Where-Object { $_.StartsWith("> `$env:BW_SESSION=") } `
        | Foreach-Object { $_.Replace("> `$env:BW_SESSION=", "").Trim('"') }
        # ���ϐ��ɃZ�b�V�����L�[��ݒ肷��
        $env:BW_SESSION = $key
        Write-Host "�Z�b�V�����L�[�����ϐ��ɃZ�b�g���܂���"
    }
    Write-Host "���������ł�"
}