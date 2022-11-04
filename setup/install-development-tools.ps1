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

#選択肢の作成
$typename = "System.Management.Automation.Host.ChoiceDescription"
$yes = new-object $typename("&Yes","実行する")
$no  = new-object $typename("&No","実行しない")

#選択肢コレクションの作成
$assembly= $yes.getType().AssemblyQualifiedName
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]"
$choice.add($yes)
$choice.add($no)

#選択プロンプトの表示
$answer = $host.ui.PromptForChoice("<実行確認>","Officeインストール実行しますか？",$choice,0)

if($answer -eq 0){
  Write-Host "Office インストール"
  choco install office365business --params "'/productid:O365BusinessRetail /exclude:Access Groove Lync OneNote Publisher /language:ja-JP /eula:TRUE'"
  Start-Sleep -Second 5
}Else{
  Write-Host "Office インストールしない"
}

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

# 処理完了後、メッセージボックスを表示
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("セットアップが完了しました。PCを再起動してください。")
