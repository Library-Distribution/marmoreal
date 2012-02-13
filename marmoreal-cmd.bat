:: RUN THIS SCRIPT TO EXECUTE marmoreal FROM THE COMMAND LINE WITHOUT COMPILING.

:: do not show the actions done here in the window
@echo off

:: ================================== Config section ==================================
@set AHK_PATH=%PROGRAMFILES%\AutoHotkey_L\AutoHotkeyL.exe
@set MARMOREAL=%CD%\marmoreal.ahk
@set VERSION=0.0.0.1 alpha 1
:: ================================== End of section ==================================

:: create "macro"
doskey marmoreal="%AHK_PATH%" "%MARMOREAL%" $*
:: run a new cmd prompt which inherits the macro
%COMSPEC% /k "echo This is the marmoreal command line v%VERSION%"