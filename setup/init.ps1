#自分自身をダウンロードし、スタートアップフォルダに配置する
#ダウンロードされていたらスキップする
if (Test-Path "$env:USERPROFILE\init.ps1" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "init.ps1はすでに存在しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "init.ps1をダウンロードしてユーザプロファイルルートに配置します"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1" -OutFile "$env:USERPROFILE\init.ps1"
    # init.ps1のショートカットを作成する
    Write-Host "init.ps1のショートカットを作成します"
    # スクリプト自体のフルパス
    $selfPath = "$env:USERPROFILE\init.ps1"

    # スタートアップフォルダのパスを取得
    $startupPath = [Environment]::GetFolderPath("Startup")

    # ショートカットの作成先パス
    $shortcutPath = Join-Path -Path $startupPath -ChildPath "MyScriptShortcut.lnk"

    # WScript.Shell オブジェクトを作成
    $shell = New-Object -ComObject WScript.Shell

    # ショートカットオブジェクトを作成
    $shortcut = $shell.CreateShortcut($shortcutPath)

    # ショートカットのプロパティを設定
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$selfPath`""
    $shortcut.WorkingDirectory = Split-Path -Path $selfPath
    $shortcut.IconLocation = "powershell.exe"

    # ショートカットを保存
    $shortcut.Save()

    # COM オブジェクトの解放
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($shell) | Out-Null

    Write-Host "init.ps1のショートカットを作成しました"

    # init.ps1ショートカットの配置が終わったか確認する
    if (Test-Path "$startupPath\MyScriptShortcut.lnk" -PathType Leaf) {
        Write-Host "init.ps1の配置が完了しました"
    }
    else {
        Write-Host "init.ps1の配置が失敗しました"
    }
    Write-Host "=============================="
}

# WindowsUpdateを最新まで適用したかどうか、Yes/Noで質問する。Yesならば続行する。
$boolwindowsUpdate = Read-Host "Is Windows Update up to date? (Yes/No)"
if ($boolwindowsUpdate -eq "No") {
    exit
}
# アプリインストーラーをインストールしているか確認する。
# インストーラーファイルがあれば続行する。
# なければインストーラーをダウンロードして、インストールする。
if (Test-Path "" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "アプリインストーラーはすでに存在しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "アプリインストーラーをダウンロードしてインストールします"
    $latestVersion = (Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-cli/releases/latest").tag_name

    Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/$latestVersion/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "$env:userprofile\appdata\local\temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"
    # インストーラーの実行
    Add-AppPackage -Path "$env:userprofile\appdata\local\temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"
    Write-Host "=============================="
    # wingetのバージョン確認
    winget --version
    Write-Host "=============================="
    ping localhost -n 5 > $null
}

# .gitconfigの配置が終わっているか確認する
if (Test-Path "$env:USERPROFILE\.gitconfig" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "gitconfigの配置は完了しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    #.gitconfigの配置
    Write-Host "gitconfigのダウンロードとユーザプロファイルへの配置"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.gitconfig" -OutFile "$env:USERPROFILE\.gitconfig"
    # .gitconfigの配置が終わったか確認する
    if (Test-Path "$env:USERPROFILE\.gitconfig") {
        Write-Host "gitconfigの配置が完了しました"
    }
    else {
        Write-Host "gitconfigの配置が失敗しました"
    }
    Write-Host "=============================="
}

# Microsoft Teamsがアンインストールされているか確認する
$teams = Get-AppxPackage -Name MicrosoftTeams
if ($null -eq $teams) {
    Write-Host "=============================="
    Write-Host "Microsoft Teamsはアンインストールされています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "Microsoft Teamsをアンインストールします"
    Write-Host "=============================="
    Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
}

# WSLのインストールが完了しているか確認する
# "$env:USERPROFILE\wslInstalled.log"が存在していたら完了と判断する
# WSLインストールが完了していない場合は、WSLインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\wslInstalled.log" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "WSLのインストールは完了しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "WSLインストールスクリプトを実行します"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
    Write-Host "=============================="
    # 5秒待つ
    ping localhost -n 5 > $null
    # OSを再起動する
    Restart-Computer
}

# ソフトウェアがインストールされたか確認する
# $env:USERPROFILE\.configurationが存在していたら、インストールされていると判断する
# インストールされていない場合は、wingetインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\.configuration" -PathType Container) {
    Write-Host "=============================="
    Write-Host "ソフトウェアはインストールされています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "wingetインストールスクリプトを実行します"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))
    Write-Host "=============================="
    # 5秒待つ
    ping localhost -n 5 > $null
    # OSを再起動する
    Restart-Computer
}

# 作業ディレクトリを作成する
# 作業ディレクトリが作成されていれば、このフェーズは完了とする
if (Test-Path "C:\WorkTmp" -PathType Container) {
    Write-Host "=============================="
    Write-Host "作業ディレクトリは作成されています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "作業ディレクトリを作成します"
    Write-Host "=============================="
    New-Item -Path "C:\WorkTmp" -ItemType Directory
}

# Gitが使えるか確認する
# Gitが使える場合は、下記ふたつのリポジトリをクローンする
# 1. spzenhan.vim
# 2. _windows11-dotfiles
# 使えない場合はエラーメッセージを表示する
if (Test-Path "C:\Program Files\Git" -PathType Container) {
    Write-Host "=============================="
    Write-Host "Gitは使えます"
    Write-Host "=============================="
    Write-Host "=============================="
    Write-Host "リポジトリをクローンします"
    Write-Host "=============================="
    git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim
    git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "Gitが使えません"
    Write-Host "=============================="
}

# WezTermの設定を行う
# WezTermの設定が完了しているか確認する
# WezTermの設定が完了していない場合は、WezTerm設定スクリプトを実行する
if (Test-Path "C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "WezTermの設定は完了しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "WezTerm設定スクリプトを実行します"
    Write-Host "=============================="
    Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs
}

# フォントのインストールを行う
# フォントインストール済のフラグファイルがあるか確認する
# フォントインストール済のフラグファイルがある場合は、フォントインストール済と判断する
# フォントインストール済のフラグファイルがない場合は、フォントインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\fontInstalled.log" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "フォントのインストールは完了しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "フォントインストールスクリプトを実行します"
    Write-Host "=============================="
    # ローカルにクローンしたフォントインストールスクリプトを実行する
    # "C:\WorkTmp\_windows11-dotfiles\setup\ps1\font-install.ps1"を実行する
    # あらためてダウンロードはしない!
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression "C:\WorkTmp\_windows11-dotfiles\setup\ps1\font-install.ps1"
    # フォントインストール済のフラグファイルを作成
    $fontInstallFlagFile = "$env:USERPROFILE\fontInstalled.log"
    New-Item -Path $fontInstallFlagFile -ItemType File -Force
    Write-Host "=============================="
}

# GitHub CLIにサインインを行う
# GitHub CLIにサインインが完了しているか確認する
# GitHub CLIにサインインが完了していない場合は、サインインを実行する
if (Test-Path "$env:USERPROFILE\.config\gh\hosts.yml" -PathType Leaf) {
    Write-Host "=============================="
    Write-Host "GitHub CLIにサインインは完了しています"
    Write-Host "=============================="
}
else {
    Write-Host "=============================="
    Write-Host "GitHub CLIにサインインを行います"
    Write-Host "=============================="
    gh auth login -w
    Set-Location C:\WorkTmp
    gh repo clone haoblackj/AutoHotkey
}

# init.ps1他、作成したフラグファイル、ショートカットを削除する
# スタートアップフォルダのパスを取得
$startupPath = [Environment]::GetFolderPath("Startup")
Remove-Item -Path "$env:USERPROFILE\init.ps1" -Force
Remove-Item -Path "$env:USERPROFILE\wslInstalled.log" -Force
Remove-Item -Path "$env:USERPROFILE\fontInstalled.log" -Force
Remove-Item -Path "$startupPath\MyScriptShortcut.lnk" -Force

#pause
# Restart-Computer
