Write-Host "Windows Settings"
Write-Host "PowerShellの実行ポリシー変更"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Write-Host "=============================="
Write-Host "WSLインストールセクション"

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
$answer = $host.ui.PromptForChoice("<実行確認>","実行しますか？",$choice,0)

if($answer -eq 0){
  Write-Host "WSL インストール"
  wsl --install
  Write-Host "Windowsハイパーバイザー インストール"
  dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart
}Else{
  Write-Host "WSL インストールしない"
}

Write-Host ""
Write-Host "... Setting is complete"
Write-Host ""
