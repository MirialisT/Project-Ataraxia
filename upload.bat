@echo off
git add *
set /p "comm=Enter commit message or leave blank: " || set "comm=auto-load-main"
git commit -m "%comm%"
git push