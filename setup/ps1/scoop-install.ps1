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

scoop install autohotkey1.1 vscode wezterm main/gh ffmpeg chezmoi komorebi whkd
