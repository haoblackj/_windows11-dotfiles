winget upgrade Microsoft.AppInstaller
# New-Item -Path $env:USERPROFILE\.configuration -ItemType Directory
# Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\configuration.dsc.yaml
# Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
# Invoke-WebRequest https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.configuration/home-desktop-configuration.dsc.yaml -OutFile $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
# winget configure $env:USERPROFILE\.configuration\configuration.dsc.yaml
pause
winget install Google.JapaneseIME
winget install Microsoft.PowerShell
winget install Biscuit.Biscuit
winget install Google.Chrome
winget install Mozilla.Firefox
winget install Microsoft.Powertoys --scope machine
winget install Bitwarden.Bitwarden
winget install Bandisoft.Honeyview
winget install voidtools.Everything
winget install SumatraPDF.SumatraPDF
# winget install OliverSchwendener.ueli
# 自宅用PCかどうか、Yes/Noで質問する。Yesならば、home-configuration.dsc.yamlを適用する。
$homeMachine = Read-Host "Is this home PC? (Yes/No)"
if ($homeMachine -ieq "Yes" -or $homeMachine -ieq "y") {
    # winget configure $env:USERPROFILE\.configuration\home-configuration.dsc.yaml
    winget install AdGuard.AdGuard
    winget install neelabo.NeeView
    # winget install CubeSoft.CubePDF
    # デスクトップPCかどうか、Yes/Noで質問する。Yesならば、home-desktop-configuration.dsc.yamlを適用する。
    $desktopMachine = Read-Host "Is this home desktop PC? (Yes/No)"
    if ($desktopMachine -ieq "Yes" -or $desktopMachine -ieq "y") {
        # winget configure $env:USERPROFILE\.configuration\home-desktop-configuration.dsc.yaml
        winget install HermannSchinagl.LinkShellExtension
        winget install qBittorrent.qBittorrent
        # winget install clawSoft.clawPDF
    }
}
# 上記If文が正常に終了したら、フラグファイルを書き出す
# New-Item -Path $env:USERPROFILE\.configuration\winget-install.done -ItemType File