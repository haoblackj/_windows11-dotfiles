@echo off
setlocal

:: �Ǘ��Ҍ����Ŏ��s����Ă��邩���m�F
net session >nul 2>&1
if %errorlevel% == 0 (
    echo �Ǘ��Ҍ����Ŏ��s����Ă��܂��B
) else (
    echo �Ǘ��Ҍ����Ŏ��s����Ă��܂���B�Ǘ��Ҍ����ōĎ��s���Ă��������B
    :: ���̃X�N���v�g���Ǘ��Ҍ����ōĎ��s
    powershell -Command "Start-Process cmd -ArgumentList '/c %~0' -Verb runAs" >nul
    exit /b
)

:: �o�b�`�t�@�C�������݂���f�B���N�g�����擾
set "script_dir=%~dp0"

:: �V���{���b�N�����N���쐬����WezTerm�̐ݒ�t�@�C���̃p�X���擾
set "link_target=%script_dir%.wezterm.lua"

:: .wezterm.lua�t�@�C�������݂��邩�`�F�b�N
if not exist "%link_target%" (
    echo .wezterm.lua�t�@�C���� %link_target% �ɑ��݂��܂���B
    exit /b
)

:: �V���{���b�N�����N�����ɑ��݂��邩�`�F�b�N���A���݂���ꍇ�͍폜
set "link_name=%USERPROFILE%\.wezterm.lua"
if exist "%link_name%" (
    echo �����̃V���{���b�N�����N���폜���Ă��܂�...
    del "%link_name%"
)

:: �V���{���b�N�����N���쐬
echo �V���{���b�N�����N���쐬���Ă��܂�...
mklink "%link_name%" "%link_target%"

echo �������܂����B
endlocal
