@echo ON

set version=%2

If "%1"=="install" call :Install

If "%1"=="unInstall" call :UnInstall

Set LiensBureau=NON

exit /b 0

:Install
7za -y x "%ZIPFILE%" -o"%systemdrive%\Program Files\"
if "%version%"=="64" (
  call :Rename64
  )
rem Installation des Icones de menu et sur le bureau
if "%LiensBureau%"=="OUI" (
  xcopy /y %Z%\packages\atom\Atom.lnk "%AllUsersDesktop%"
  )
else (
  del /F /Q "%AllUsersDesktop%\Atom.lnk"
  )

mkdir "%AllUsersPrograms%\Informatique\"
xcopy /y %Z%\packages\atom\Atom.lnk "%AllUsersPrograms%\Informatique\"

reg.exe import %Z%\packages\atom\atom_home.reg

rem Install floobits dir
set FLOOPERSISTENT="%systemdrive%\Program Files\Atom\~\floobits"
if not exist "%FLOOPERSISTENT%" (
	echo "ajout du repertoire %FLOOPERSISTENT% pour floobits et atom"
    mkdir %FLOOPERSISTENT%
)
echo "fixer les droits pour floobits et ATOM"
icacls %FLOOPERSISTENT% /grant "tout le monde":(CI)F /T /Q >NUL

exit /b


:Uninstall
rmdir /S /Q "%systemdrive%\Program Files\Atom"
del /F /Q "%AllUsersDesktop%\Atom.lnk"
del /F /Q "%AllUsersPrograms%\Informatique\Atom.lnk"
exit /b

:Rename64
if exist "%systemdrive%\Program Files\Atom" (
  rmdir /S /Q "%systemdrive%\Program Files\Atom"
)
move /Y "%systemdrive%\Program Files\Atom x64" "%systemdrive%\Program Files\Atom"
exit /b
