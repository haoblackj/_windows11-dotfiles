@echo off
setlocal enabledelayedexpansion

:: 管理者権限で実行されているかを確認
net session >nul 2>&1
if %errorlevel% == 0 (
    echo 管理者権限で実行されています。
) else (
    echo 管理者権限で実行されていません。管理者権限で再実行してください。
    :: このスクリプトを管理者権限で再実行
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb runAs" >nul
    exit /b
)

:: バッチファイルが存在するディレクトリを取得
set "script_dir=%~dp0"

:: .weztermフォルダのシンボリックリンクを作成
set "wezterm_dir=%USERPROFILE%\.wezterm"
if exist "!wezterm_dir!" (
    :: シンボリックリンクかどうかを確認
    dir "!wezterm_dir!" | find "<SYMLINKD>" >nul
    if %errorlevel% == 0 (
        echo 既存のシンボリックリンクを削除しています: !wezterm_dir!
        rmdir "!wezterm_dir!"
    ) else (
        echo 既存のフォルダが存在しますが、シンボリックリンクではありません: !wezterm_dir!
        exit /b
    )
)
echo .weztermフォルダのシンボリックリンクを作成しています: !wezterm_dir!
mklink /D "!wezterm_dir!" "%script_dir%.wezterm"

:: .luaファイルをループ処理
for %%f in ("%script_dir%*.lua") do (
    :: シンボリックリンクの名前を設定
    set "link_name=%USERPROFILE%\%%~nxf"

    :: シンボリックリンクが既に存在するかチェックし、存在する場合は削除
    if exist "!link_name!" (
        :: シンボリックリンクかどうかを確認
        dir "!link_name!" | find "<SYMLINK>" >nul
        if %errorlevel% == 0 (
            echo 既存のシンボリックリンクを削除しています: !link_name!
            del "!link_name!"
        ) else (
            echo 既存のファイルが存在しますが、シンボリックリンクではありません: !link_name!
            exit /b
        )
    )

    :: シンボリックリンクを作成
    echo シンボリックリンクを作成しています: !link_name!
    mklink "!link_name!" "%%~ff"
)

echo 完了しました。
pause
endlocal