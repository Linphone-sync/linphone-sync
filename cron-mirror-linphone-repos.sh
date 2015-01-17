#!/bin/sh
# Linphone-Sync (https://github.com/Linphone-sync)
# This script is executed by cron
# Mirror every Linphone repo to GitHub and push the result log file to GitHub

LOGFILE=mirror-linphone-repos.log

./mirror-linphone-repos.sh >> ${LOGFILE} 2>&1
git add ${LOGFILE}

git commit -m"Linphone mirror log created at `date`"
git push origin master
