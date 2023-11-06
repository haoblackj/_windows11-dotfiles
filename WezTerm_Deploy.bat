@echo off
setlocal

:: 管理者権限で実行されているかを確認
net session >nul 2>&1
if %errorlevel% == 0 (
    echo 管理者権限で実行されています。
) else (
    echo 管理者権限で実行されていません。管理者権限で再実行してください。
    :: このスクリプトを管理者権限で再実行
    powershell -Command "Start-Process cmd -ArgumentList '/c %~0' -Verb runAs" >nul
    exit /b
)

:: バッチファイルが存在するディレクトリを取得
set "script_dir=%~dp0"

:: シンボリックリンクを作成するWezTermの設定ファイルのパスを取得
set "link_target=%script_dir%.wezterm.lua"

:: .wezterm.luaファイルが存在するかチェック
if not exist "%link_target%" (
    echo .wezterm.luaファイルが %link_target% に存在しません。
    exit /b
)

:: シンボリックリンクが既に存在するかチェックし、存在する場合は削除
set "link_name=%USERPROFILE%\.wezterm.lua"
if exist "%link_name%" (
    echo 既存のシンボリックリンクを削除しています...
    del "%link_name%"
)

:: シンボリックリンクを作成
echo シンボリックリンクを作成しています...
mklink "%link_name%" "%link_target%"

echo 完了しました。
endlocal
