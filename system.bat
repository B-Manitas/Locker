cls
@echo off
title SYSTEM

set path_folder=Locker
set path_kwrd=%path_folder%/key.txt
set lock_on=false

:: Check the state of the locker
if not exist "%Locker%" md %path_folder%

:: Create key file and Set key
>> %path_kwrd% type nul
set /p k_wrd=< %path_kwrd%

:: Create and Check the state of the locker
attrib %path_folder% | findstr "H" >nul && set lock_on=true
if %lock_on%==false (goto set_lock) else (goto check_pwd)

:: User lock or not the folder
:set_lock
:: Check null key
for /f %%i in ("%path_kwrd%") do (
  if %%~zi==0 (
    echo Warning : The key is null.
    pause
    exit
  )
)

echo Would you want to hide your folder ? [Y/N]
set /p "answer=>"
if %answer%==y set answer=Y
if %answer%==Y (
  attrib +h +s %path_folder%
  attrib +h +s %path_kwrd%
)
exit

:: Check the key to unlock the folder
:check_pwd
set /p "alpha=>"
if %alpha%==%k_wrd% (
    attrib -h -s %path_folder%
    attrib -h -s %path_kwrd%
) else (
  echo Fail
  pause
)
exit