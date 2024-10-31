Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
# irm get.scoop.sh -outfile 'scoop-install.ps1'

# .\scoop-install.ps1

scoop install git aria2 7zip

git config --system filter.lfs.clean "git-lfs clean -- %f"
git config --system filter.lfs.smudge "git-lfs smudge -- %f"
git config --system filter.lfs.process "git-lfs filter-process"
git config --system filter.lfs.required true

git config --system user.name "haoblackj"
git config --system user.email "17177994+haoblackj@users.noreply.github.com"

git config --system core.autocrlf false
git config --system core.quotepath false

git config --system alias.cob "checkout -b"
git config --system alias.co "checkout"

git config --system ghq.root "~/repo"

git config --system credential.helperselector.selected manager
git config --system credential.helper manager

scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

git config --global --add safe.directory $env:USERPROFILE\scoop\bucket\main
git config --global --add safe.directory $env:USERPROFILE\scoop\bucket\extras
git config --global --add safe.directory $env:USERPROFILE\scoop\bucket\versions
git config --global --add safe.directory $env:USERPROFILE\scoop\bucket\nerd-fonts

scoop install sumatrapdf everything powertoys autohotkey1.1 vscode wezterm teraterm main/gh bitwarden slack honeyview
