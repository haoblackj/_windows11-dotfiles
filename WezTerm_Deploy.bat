@echo off
setlocal enabledelayedexpansion

:: �Ǘ��Ҍ����Ŏ��s����Ă��邩���m�F
net session >nul 2>&1
if %errorlevel% == 0 (
    echo �Ǘ��Ҍ����Ŏ��s����Ă��܂��B
) else (
    echo �Ǘ��Ҍ����Ŏ��s����Ă��܂���B�Ǘ��Ҍ����ōĎ��s���Ă��������B
    :: ���̃X�N���v�g���Ǘ��Ҍ����ōĎ��s
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb runAs" >nul
    exit /b
)

:: �o�b�`�t�@�C�������݂���f�B���N�g�����擾
set "script_dir=%~dp0"

:: .wezterm�t�H���_�̃V���{���b�N�����N���쐬
set "wezterm_dir=%USERPROFILE%\.wezterm"
if exist "!wezterm_dir!" (
    :: �V���{���b�N�����N���ǂ������m�F
    dir "!wezterm_dir!" | find "<SYMLINKD>" >nul
    if %errorlevel% == 0 (
        echo �����̃V���{���b�N�����N���폜���Ă��܂�: !wezterm_dir!
        rmdir "!wezterm_dir!"
    ) else (
        echo �����̃t�H���_�����݂��܂����A�V���{���b�N�����N�ł͂���܂���: !wezterm_dir!
        exit /b
    )
)
echo .wezterm�t�H���_�̃V���{���b�N�����N���쐬���Ă��܂�: !wezterm_dir!
mklink /D "!wezterm_dir!" "%script_dir%.wezterm"

:: .lua�t�@�C�������[�v����
for %%f in ("%script_dir%*.lua") do (
    :: �V���{���b�N�����N�̖��O��ݒ�
    set "link_name=%USERPROFILE%\%%~nxf"

    :: �V���{���b�N�����N�����ɑ��݂��邩�`�F�b�N���A���݂���ꍇ�͍폜
    if exist "!link_name!" (
        :: �V���{���b�N�����N���ǂ������m�F
        dir "!link_name!" | find "<SYMLINK>" >nul
        if %errorlevel% == 0 (
            echo �����̃V���{���b�N�����N���폜���Ă��܂�: !link_name!
            del "!link_name!"
        ) else (
            echo �����̃t�@�C�������݂��܂����A�V���{���b�N�����N�ł͂���܂���: !link_name!
            exit /b
        )
    )

    :: �V���{���b�N�����N���쐬
    echo �V���{���b�N�����N���쐬���Ă��܂�: !link_name!
    mklink "!link_name!" "%%~ff"
)

echo �������܂����B
pause
endlocal