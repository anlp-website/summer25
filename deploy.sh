#!/bin/sh
echo "\nClosing Dropbox..."
# Call PowerShell to stop Dropbox silently
powershell.exe -NoProfile -Command "Stop-Process -Name Dropbox -ErrorAction SilentlyContinue"

echo "\nClearing old docs..."
rm -rf ./docs
sleep 5

echo "\nBuilding new site with hugo...\n"
hugo

echo "\nDeploying site to Github...\n"
mv ./public ./docs
sleep 5
git pull
git add --all
git commit -a -m "Publishing site build - $(date)"
git push -u origin main --force

echo "\nRe-opening Dropbox..."
# Call PowerShell to restart Dropbox hidden
powershell.exe -NoProfile -Command "Start-Process 'C:\Program Files (x86)\Dropbox\Client\Dropbox.exe' -WindowStyle Hidden"

echo "\nSITE BUILD IS SUCCESSFUL!...\n"
