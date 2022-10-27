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
cinst -y packages.config
cup all -y

del /q packages.config

wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/install_vscode_extensions.ps1" -OutFile "install_vscode_extensions.ps1"
wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/vscode-extensions_list.txt" -OutFile "vscode-extensions_list.txt"

powershell -ExecutionPolicy RemoteSigned -File ".\install_vscode_extensions.ps1" "vscode-extensions_list.txt"

del /q install_vscode_extensions.ps1
del /q vscode-extensions_list.txt

wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/Microsoft.PowerShell_profile.ps1" -OutFile "Microsoft.PowerShell_profile.ps1"

$MyDocumentsDir = [System.Environment]::GetFolderPath("MyDocuments")
copy-item "Microsoft.PowerShell_profile.ps1" "$MyDocumentsDir\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

del /q Microsoft.PowerShell_profile.ps1

Write-Host ""
Write-Host "... Install is complete"
Write-Host ""

# 処理完了後、メッセージボックスを表示
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("セットアップが完了しました。PCを再起動してください。")
