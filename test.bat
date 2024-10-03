@echo off
set /p comm="Enter commit message or leave blank: "
IF comm == "" (set comm="auto-load-main")
echo %comm%