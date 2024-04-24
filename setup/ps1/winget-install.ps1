New-Item -Path $env:USERPROFILE\.configuration -ItemType Directory
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-desktop-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
winget configure $env:USERPROFILE\.configuration\configuration.dsc.yaml
# ����pPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-configuration.dsc.yaml��K�p����B
$homeMachine = Read-Host "Is this home PC? (Yes/No)"
if ($homeMachine -ieq "Yes" -or $homeMachine -ieq "y") {
    winget configure $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
    # �f�X�N�g�b�vPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-desktop-configuration.dsc.yaml��K�p����B
    $desktopMachine = Read-Host "Is this home desktop PC? (Yes/No)"
    if ($desktopMachine -ieq "Yes" -or $desktopMachine -ieq "y") {
        winget configure $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
    }
}
