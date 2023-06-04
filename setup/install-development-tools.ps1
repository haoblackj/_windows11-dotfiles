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
wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/packages_common.config" -OutFile "packages.config"
choco install -y packages.config
choco upgrade all -y

remove-item "packages.config" -Force

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install_vscode_extensions.ps1" -OutFile "install_vscode_extensions.ps1"
wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/vscode-extensions_list.txt" -OutFile "vscode-extensions_list.txt"

powershell -ExecutionPolicy RemoteSigned -File ".\install_vscode_extensions.ps1" "vscode-extensions_list.txt"

remove-item "install_vscode_extensions.ps1" -Force
remove-item "vscode-extensions_list.txt" -Force

wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/Microsoft.PowerShell_profile.ps1" -OutFile "Microsoft.PowerShell_profile.ps1"

$MyDocumentsDir = [System.Environment]::GetFolderPath("MyDocuments")
copy-item "Microsoft.PowerShell_profile.ps1" "$MyDocumentsDir\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

remove-item "Microsoft.PowerShell_profile.ps1" -Force

Write-Host ""
Write-Host "... Install is complete"
Write-Host ""

# ����������A���b�Z�[�W�{�b�N�X��\��
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("�Z�b�g�A�b�v���������܂����BPC���ċN�����Ă��������B")
