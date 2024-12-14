winget upgrade Microsoft.AppInstaller
New-Item -Path $env:USERPROFILE\.configuration -ItemType Directory
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-desktop-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
# winget configure $env:USERPROFILE\.configuration\configuration.dsc.yaml
winget install Google.JapaneseIME --source winget
winget install Microsoft.PowerShell --source winget
winget install Biscuit.Biscuit --source winget
winget install Google.Chrome --source winget
winget install Mozilla.Firefox --source winget
winget install Microsoft.Powertoys --source winget --scope machine
winget install 8bitSolutionsLLC.Bitwarden --source winget
winget install Bandisoft.Honeyview --source winget
winget install voidtools.Everything --source winget
winget install SumatraPDF.SumatraPDF --source winget
winget install TeraTermProject.teraterm5 --source winget
# ����pPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-configuration.dsc.yaml��K�p����B
$homeMachine = Read-Host "Is this home PC? (Yes/No)"
if ($homeMachine -ieq "Yes" -or $homeMachine -ieq "y") {
    # winget configure $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
    winget install AdGuard.AdGuard --source winget
    winget install CubeSoft.CubePDF --source winget
    # �f�X�N�g�b�vPC���ǂ����AYes/No�Ŏ��₷��BYes�Ȃ�΁Ahome-desktop-configuration.dsc.yaml��K�p����B
    $desktopMachine = Read-Host "Is this home desktop PC? (Yes/No)"
    if ($desktopMachine -ieq "Yes" -or $desktopMachine -ieq "y") {
        # winget configure $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
        winget install HermannSchinagl.LinkShellExtension --source winget
    }
}
# ��LIf��������ɏI��������A�t���O�t�@�C���������o��
New-Item -Path $env:USERPROFILE\.configuration\winget-install.done -ItemType File