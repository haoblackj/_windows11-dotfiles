Write-Host "Windows Settings"
Write-Host "PowerShell�̎��s�|���V�[�ύX"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#.gitconfig�̔z�u
Write-Host "gitconfig�̃_�E�����[�h�ƃ��[�U�v���t�@�C���ւ̔z�u"
wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.gitconfig" -OutFile "$env:USERPROFILE\.gitconfig"
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
$answer = $host.ui.PromptForChoice("<���s�m�F>","WSL�C���X�g�[�����s���܂����H",$choice,0)

if($answer -eq 0){
  Write-Host "WSL �C���X�g�[��"
  wsl --install
  # Start-Sleep -Second 5
  # Write-Host "Windows�n�C�p�[�o�C�U�[ �C���X�g�[��"
  # dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart
}Else{
  Write-Host "WSL �C���X�g�[�����Ȃ�"
}

Write-Host ""
Write-Host "... Setting is complete"
Write-Host ""
