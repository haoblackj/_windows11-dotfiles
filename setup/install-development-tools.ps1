Write-Host "Install Development Tools"
Write-Host "=============================="

try {
  # chocoのインストール確認
  get-command choco -ErrorAction Stop
}
catch [Exception] {
  # chocoのインストール
  Write-Host "Install choco"
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  choco upgrade chocolatey
}

# 必要なもんゴッソリ
wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/packages_common.config" -OutFile "packages.config"
choco install -y packages.config --ignore-checksums

remove-item "packages.config" -Force

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

Write-Host ""
Write-Host "... Install is complete"
Write-Host ""

