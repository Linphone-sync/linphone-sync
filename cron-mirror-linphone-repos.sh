#!/bin/sh
# Linphone-Sync (https://github.com/Linphone-sync)
# This script is executed by cron
# Mirror every Linphone repo to GitHub and push the result log file to GitHub

LOGFILE=mirror-linphone-repos.log

# run the mirror script and append the log file
./mirror-linphone-repos.sh >> ${LOGFILE} 2>&1

# refresh the local repo
git pull

# add the new log file, commit and push
git add ${LOGFILE}
git commit -m"Linphone mirror log created at `date`"
git push origin master
