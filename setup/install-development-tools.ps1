Write-Host "Install Development Tools"
Write-Host "=============================="

try {
  # choco�̃C���X�g�[���m�F
  get-command choco -ErrorAction Stop
}
catch [Exception] {
  # choco�̃C���X�g�[��
  Write-Host "Install choco"
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  choco upgrade chocolatey
}

# �K�v�Ȃ���S�b�\��
cinst https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/packages_common.config
cup all -y

Write-Host ""
Write-Host "... Install is complete"
Write-Host ""

# ����������A���b�Z�[�W�{�b�N�X��\��
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("�Z�b�g�A�b�v���������܂����BPC���ċN�����Ă��������B")
