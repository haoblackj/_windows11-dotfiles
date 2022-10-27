Write-Host "Windows Settings"
Write-Host "=============================="
Write-Host "WSL�C���X�g�[���Z�N�V����"

#�I�����̍쐬
$typename = "System.Management.Automation.Host.ChoiceDescription"
$yes = new-object $typename("&Yes","���s����")
$no  = new-object $typename("&No","���s���Ȃ�")

#�I�����R���N�V�����̍쐬
$assembly= $yes.getType().AssemblyQualifiedName
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]"
$choice.add($yes)
$choice.add($no)

#�I���v�����v�g�̕\��
$answer = $host.ui.PromptForChoice("<���s�m�F>","���s���܂����H",$choice,0)

if($answer -eq 0){
  Write-Host "WSL �C���X�g�[��"
  wsl --install
}Else{
  Write-Host "WSL �C���X�g�[�����Ȃ�"
}

Write-Host ""
Write-Host "... Setting is complete"
Write-Host ""
