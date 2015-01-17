#!/bin/bash
# Linphone-Sync (https://github.com/Linphone-sync)
# Mirror Linphone source codes from the official upstream repositories to GitHub

DATE=/bin/date
LOCAL_REPO_PATH=/opt/src/linphone-sync


function log {
DATE_FORMAT=+%Y-%m-%d_%H:%M:%S

	echo `${DATE} ${DATE_FORMAT}:` $1
}

function die {
	log "$@"
	exit 1
}

LINPHONE_REPOS=(
	'antlr3.git'
	'axmlrpc.git'
	'bcg729.git'
	'belle-sip.git'
	'bzrtp.git'
	'cunit.git'
	'gsm.git'
	'libilbc-rfc3951.git'
	'linphone-android.git'
	'linphone.git'
	'linphone-iphone.git'
	'mediastreamer2.git'
	'msamr.git'
	'msilbc.git'
	'msopenh264.git'
	'mssilk.git'
	'mswebrtc.git'
	'msx264.git'
	'ortp.git'
	'polarssl.git'
	'speex.git'
	'srtp.git'
	'webrtc.git'
)



echo "===== Starting to mirror Linphone repositories from the official Belledonne's git servers to GitHub ====="

COUNT=0
while [ "x${LINPHONE_REPOS[COUNT]}" != "x" ]
do
	GITREPO=${LOCAL_REPO_PATH}/${LINPHONE_REPOS[COUNT]}
	cd ${GITREPO}

	REMOTE_ORIGIN_URL=`git config --get remote.origin.url`
	REMOTE_ORIGIN_PUSHURL=`git config --get remote.origin.pushurl`

	log "Starting to mirror changes from [${GITREPO}] repository"
	log "Fetching remote changes from [${REMOTE_ORIGIN_URL}]"
	git fetch -p origin
	if [ $? -ne 0 ]; then
		log "git fetch failed."
	fi

	log "Pushing changes (--mirror) to [${REMOTE_ORIGIN_PUSHURL}]"
	git push --mirror
	if [ $? -ne 0 ]; then
		log "git push --mirror failed."
	fi

	log "[${GITREPO}] mirror has been finished"

	COUNT=$(( $COUNT + 1 ))
done

log "===== Changes have been pushed to GitHub successfully ====="
