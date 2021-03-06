@echo off

REM
REM	Copyright �2002-2012 Daniel Bullington (dpbullington@gmail.com)
REM	Distributed under the MIT license: http://www.opensource.org/licenses/mit-license.php
REM

set PACKAGE_DIR=.\pkg
set PACKAGE_DIR_EXISTS=%PACKAGE_DIR%\nul
set BUILD_EXE=msbuild.exe

cd "."

rem if "%1" == "" goto pkgUsage
if "%1" == "" goto flavorRelease
if /i %1 == -release       goto flavorRelease
if /i %1 == -debug     goto flavorDebug
goto pkgUsage



:flavorRelease

@echo Using [Release] build flavor directory...
set BUILD_FLAVOR_DIR=Release
set BUILD_TOOL_CFG=Release
goto pkgDir


:flavorDebug

@echo Using [Debug] build flavor directory...
set BUILD_FLAVOR_DIR=Debug
set BUILD_TOOL_CFG=Debug
goto pkgDir





:pkgDir

IF NOT EXIST %PACKAGE_DIR_EXISTS% GOTO noPkgDir
goto delPkgDir

:noPkgDir
@echo Creating pkg directory...
mkdir "%PACKAGE_DIR%"
IF %ERRORLEVEL% NEQ 0 goto pkgError
goto pkgBuild

:delPkgDir
@echo Cleaning pkg directory...
del "%PACKAGE_DIR%\*.*" /Q /S
rem IF %ERRORLEVEL% NEQ 0 goto pkgError
goto pkgBuild





:pkgBuild

@echo BUILD_EXE=%BUILD_EXE%
@echo BUILD_TOOL_CFG=%BUILD_TOOL_CFG%

"%BUILD_EXE%" ".\src\Solder.sln" /t:clean /p:Configuration=%BUILD_TOOL_CFG%
IF %ERRORLEVEL% NEQ 0 goto pkgError

"%BUILD_EXE%" ".\src\Solder.sln" /t:build /p:Configuration=%BUILD_TOOL_CFG%
IF %ERRORLEVEL% NEQ 0 goto pkgError



:pkgCopy

@echo BUILD_FLAVOR_DIR=%BUILD_FLAVOR_DIR%


copy ".\src\Solder.Core\bin\%BUILD_FLAVOR_DIR%\Solder.Core.dll" "%PACKAGE_DIR%\."
IF %ERRORLEVEL% NEQ 0 goto pkgError

copy ".\src\Solder.Core\bin\%BUILD_FLAVOR_DIR%\Solder.Core.xml" "%PACKAGE_DIR%\."
IF %ERRORLEVEL% NEQ 0 goto pkgError

copy ".\src\Solder.Core\bin\%BUILD_FLAVOR_DIR%\Solder.Core.pdb" "%PACKAGE_DIR%\."
IF %ERRORLEVEL% NEQ 0 goto pkgError


copy ".\src\Solder.Core.UnitTests\bin\%BUILD_FLAVOR_DIR%\Solder.Core.UnitTests.dll" "%PACKAGE_DIR%\."
IF %ERRORLEVEL% NEQ 0 goto pkgError

rem copy ".\src\Solder.Core.UnitTests\bin\%BUILD_FLAVOR_DIR%\Solder.Core.UnitTests.xml" "%PACKAGE_DIR%\."
rem IF %ERRORLEVEL% NEQ 0 goto pkgError

copy ".\src\Solder.Core.UnitTests\bin\%BUILD_FLAVOR_DIR%\Solder.Core.UnitTests.pdb" "%PACKAGE_DIR%\."
IF %ERRORLEVEL% NEQ 0 goto pkgError


goto pkgSuccess




:pkgError
echo An error occured.
goto :eof

:pkgSuccess
echo Completed successfully.
goto :eof


:pkgUsage
echo Error in script usage. The correct usage is:
echo     %0 [flavor]
echo where [flavor] is: -release ^| -debug
echo:
echo For example:
echo     %0 -debug
goto :eof