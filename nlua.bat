@echo off
setlocal

SET PARENT=%~dp0

nvim -u NONE -U NONE -N -i NONE -l %PARENT%/nlua %*

exit /b %ERRORLEVEL%
