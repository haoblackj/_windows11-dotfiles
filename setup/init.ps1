#自分自身をダウンロードし、ユーザプロファイルルートに配置する
#ダウンロードされていたらスキップする
if (Test-Path "$env:USERPROFILE\init.ps1") {
    Write-Host "=============================="
    Write-Host "init.ps1はすでに存在しています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "init.ps1をダウンロードしてユーザプロファイルルートに配置します"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/init.ps1" -OutFile "$env:USERPROFILE\init.ps1"
    # init.ps1の配置が終わったか確認する
    if (Test-Path "$env:USERPROFILE\init.ps1") {
        Write-Host "init.ps1の配置が完了しました"
    } else {
        Write-Host "init.ps1の配置が失敗しました"
    }
    Write-Host "=============================="
}

# WindowsUpdateを最新まで適用したかどうか、Yes/Noで質問する。Yesならば続行する。
$boolwindowsUpdate = Read-Host "Is Windows Update up to date? (Yes/No)"
if ($boolwindowsUpdate -eq "No") {
    exit
}
# Microsoft Storeアプリを最新まで更新したかどうか、Yes/Noで質問する。Yesならば続行する。
$storeUpdate = Read-Host "Is Microsoft Store up to date? (Yes/No)"
if ($storeUpdate -eq "No") {
    exit
}

# .gitconfigの配置が終わっているか確認する
if (Test-Path "$env:USERPROFILE\.gitconfig") {
    Write-Host "=============================="
    Write-Host "gitconfigの配置は完了しています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    #.gitconfigの配置
    Write-Host "gitconfigのダウンロードとユーザプロファイルへの配置"
    wget "https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/.gitconfig" -OutFile "$env:USERPROFILE\.gitconfig"
    # .gitconfigの配置が終わったか確認する
    if (Test-Path "$env:USERPROFILE\.gitconfig") {
        Write-Host "gitconfigの配置が完了しました"
    } else {
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
} else {
    Write-Host "=============================="
    Write-Host "Microsoft Teamsをアンインストールします"
    Write-Host "=============================="
    Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq "MicrosoftTeams" | Remove-AppxProvisionedPackage -Online
}

# WSLのインストールが完了しているか確認する
# "$env:USERPROFILE\wslInstalled.log"が存在していたら完了と判断する
# WSLインストールが完了していない場合は、WSLインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\wslInstalled.log") {
    Write-Host "=============================="
    Write-Host "WSLのインストールは完了しています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "WSLインストールスクリプトを実行します"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/wsl-install.ps1'))
    Write-Host "=============================="
    # 5秒待つ
    Start-Sleep -s 5
    # OSを再起動する
    Restart-Computer
}

# ソフトウェアがインストールされたか確認する
# $env:USERPROFILE\.configurationが存在していたら、インストールされていると判断する
# インストールされていない場合は、wingetインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\.configuration") {
    Write-Host "=============================="
    Write-Host "ソフトウェアはインストールされています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "wingetインストールスクリプトを実行します"
    Write-Host "=============================="
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/haoblackj/_windows11-dotfiles/master/setup/ps1/winget-install.ps1'))
    Write-Host "=============================="
    # 5秒待つ
    Start-Sleep -s 5
    # OSを再起動する
    Restart-Computer
}

# 作業ディレクトリを作成する
# 作業ディレクトリが作成されていれば、このフェーズは完了とする
if (Test-Path "C:\WorkTmp") {
    Write-Host "=============================="
    Write-Host "作業ディレクトリは作成されています"
    Write-Host "=============================="
} else {
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
if (Test-Path "C:\Program Files\Git\cmd\git.exe") {
    Write-Host "=============================="
    Write-Host "Gitは使えます"
    Write-Host "=============================="
    Write-Host "=============================="
    Write-Host "リポジトリをクローンします"
    Write-Host "=============================="
    git clone https://github.com/kaz399/spzenhan.vim.git C:\WorkTmp\spzenhan.vim
    git clone https://github.com/haoblackj/_windows11-dotfiles.git C:\WorkTmp\_windows11-dotfiles
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "Gitが使えません"
    Write-Host "=============================="
}

# WezTermの設定を行う
# WezTermの設定が完了しているか確認する
# WezTermの設定が完了していない場合は、WezTerm設定スクリプトを実行する
if (Test-Path "C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat") {
    Write-Host "=============================="
    Write-Host "WezTermの設定は完了しています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "WezTerm設定スクリプトを実行します"
    Write-Host "=============================="
    Start-Process C:\WorkTmp\_windows11-dotfiles\WezTerm_Deploy.bat -Verb RunAs
}

# フォントのインストールを行う
# フォントインストール済のフラグファイルがあるか確認する
# フォントインストール済のフラグファイルがある場合は、フォントインストール済と判断する
# フォントインストール済のフラグファイルがない場合は、フォントインストールスクリプトを実行する
if (Test-Path "$env:USERPROFILE\fontInstalled.log") {
    Write-Host "=============================="
    Write-Host "フォントのインストールは完了しています"
    Write-Host "=============================="
} else {
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
if (Test-Path "$env:USERPROFILE\.config\gh\hosts.yml") {
    Write-Host "=============================="
    Write-Host "GitHub CLIにサインインは完了しています"
    Write-Host "=============================="
} else {
    Write-Host "=============================="
    Write-Host "GitHub CLIにサインインを行います"
    Write-Host "=============================="
    gh auth login -w
    Set-Location C:\WorkTmp
    gh repo clone haoblackj/AutoHotkey
}

# init.ps1他、作成したフラグファイルを削除する
Remove-Item -Path "$env:USERPROFILE\init.ps1" -Force
Remove-Item -Path "$env:USERPROFILE\wslInstalled.log" -Force
Remove-Item -Path "$env:USERPROFILE\fontInstalled.log" -Force

#pause
# Restart-Computer
