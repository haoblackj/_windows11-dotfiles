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
cinst https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/packages_common.config
cup all -y

Write-Host ""
Write-Host "... Install is complete"
Write-Host ""

# 処理完了後、メッセージボックスを表示
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("セットアップが完了しました。PCを再起動してください。")
