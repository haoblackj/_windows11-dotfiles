function DownloadLatestReleaseZip {
    param(
        [string]$owner,
        [string]$repo,
        [string]$filenamePrefix,
        [string]$filenamePostfix,
        [string]$savePath
    )

    # GitHub APIを使用して最新のリリース情報を取得します
    $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/releases/latest"

    # 最新のリリースタグを取得します
    $latestTag = $latestRelease.tag_name

    # ZIPファイルのURLを作成します
    $zipUrl = "https://github.com/$owner/$repo/releases/download/$latestTag/$filenamePrefix$latestTag$filenamePostfix.zip"

    # ZIPファイルをダウンロードします
    Invoke-WebRequest -Uri $zipUrl -OutFile $savePath
}

# カレントディレクトリを取得します
$currentDir = Get-Location

# カレントディレクトリが 'C:\WorkTmp' でなければ、それに変更します
if ($currentDir -ne 'C:\WorkTmp') {
    Set-Location -Path 'C:\WorkTmp'
}

# ディレクトリパスを設定します
$dirPath = 'C:\WorkTmp\fonts'

# ディレクトリが存在しない場合、作成します
if (!(Test-Path -Path $dirPath)) {
    New-Item -ItemType Directory -Path $dirPath
}

Set-Location -path C:\WorkTmp\fonts

DownloadLatestReleaseZip -owner "yuru7" -repo "PlemolJP" -filenamePrefix "PlemolJP_HS_" -filenamePostfix "" -savePath "PlemolJP_HS_latest.zip"
DownloadLatestReleaseZip -owner "yuru7" -repo "Firge" -filenamePrefix "FirgeNerd_" -filenamePostfix "" -savePath "FirgeNerd_latest.zip"

# もし、自宅用PCならば、homeディレクトリにhome用のフォントをダウンロードします
if ($homeMachine -eq "Yes") {
    if (!(Test-Path -Path 'C:\WorkTmp\fonts\home')) {
        New-Item -ItemType Directory -Path 'C:\WorkTmp\fonts\home'
    }
    Set-Location -path C:\WorkTmp\fonts\home

    DownloadLatestReleaseZip -owner "haoblackj" -repo "dotfiles-private" -filenamePrefix "" -filenamePostfix "" -savePath "home_font_latest.zip"

    set-location -path C:\WorkTmp\fonts
}

# ZIPファイルを展開します
Expand-Archive -Path "PlemolJP_HS_latest.zip" -DestinationPath "PlemolJP_HS_latest"
Expand-Archive -Path "FirgeNerd_latest.zip" -DestinationPath "FirgeNerd_latest"

# もし、自宅用PCならば、homeディレクトリにhome用のフォントを展開します
if ($homeMachine -eq "Yes") {
    Set-Location -path C:\WorkTmp\fonts\home
    Expand-Archive -Path "home_font_latest.zip" -DestinationPath "home_font_latest"
    set-location -path C:\WorkTmp\fonts
}

# ZIPファイルを削除します
Remove-Item -Path "PlemolJP_HS_latest.zip"
Remove-Item -Path "FirgeNerd_latest.zip"

# もし、自宅用PCならば、homeディレクトリにhome用のフォントを削除します
if ($homeMachine -eq "Yes") {
    Set-Location -path C:\WorkTmp\fonts\home
    Remove-Item -Path "home_font_latest.zip"
    set-location -path C:\WorkTmp\fonts
}

# フォントをインストールします
# まずは、フォントのインストールに必要なPowerShellモジュールをインストールする
Install-Module PPoshTools -Force
# フォントをインストールする
Add-Font -Path C:\WorkTmp\fonts

if ($homeMachine -eq "Yes") {
    Add-Font -Path C:\WorkTmp\fonts\home
}
