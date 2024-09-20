irm get.scoop.sh -outfile 'scoop-install.ps1'

.\scoop-install.ps1

scoop install git aria2 7zip

scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

scoop install sumatrapdf everything powertoys autohotkey1.1 vscode wezterm teraterm main/gh bitwarden slack honeyview
