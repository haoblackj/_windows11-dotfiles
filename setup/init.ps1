Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/windows10-dotfiles/master/setup/windows10-settings.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/windows10-dotfiles/master/setup/install-development-tools.ps1'))

Restart-Computer
