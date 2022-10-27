
<#
    .SYNOPSIS
    bitwarden CLIのセッションを開始します。
    .Description
    bitwarden CLI で保管庫をアンロックし、発行されたセッションキーを環境変数に設定します。
#>
function Start-BwSession {
    # bitwardenのステータスを取得
    $status = bw.exe status | ConvertFrom-Json
    $session = $null
    # 未ログインの場合
    if ($status.status -eq "unauthenticated") {
        Write-Host "bitwardenにloginします"
        $session = bw.exe login
    }
    # ロック状態の場合
    elseif ($status.status -eq "locked") {
        Write-Host "保管庫をUnlockします"
        $session = bw.exe unlock
    }
    # ログイン済みの場合は何もしない

    # login、unlock成功時
    if ($null -ne $session) {
        # login、unlockから帰ってくる文字列から、セッションキーのみを取り出す
        $key = $session`
        | Where-Object { $_.StartsWith("> `$env:BW_SESSION=") } `
        | Foreach-Object { $_.Replace("> `$env:BW_SESSION=", "").Trim('"') }
        # 環境変数にセッションキーを設定する
        $env:BW_SESSION = $key
        Write-Host "セッションキーを環境変数にセットしました"
    }
    Write-Host "準備完了です"
}