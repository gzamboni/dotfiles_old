#!/bin/sh

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"
