#!/bin/bash
#ensure commands are run using "sudo"
if [ "$(id -u)" != "0" ]; then
 echo "Sorry, you must be root."
 exit 1
fi
#disable guest account 
dscl . -create /Users/Guest AuthenticationAuthority ";basic;"
dscl . -create /Users/Guest passwd "*"
dscl . -create /Users/Guest UserShell "/sbin/nologin"
defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled -int 0
#guest access to share folders
defaults write /Library/Preferences/com.apple.AppleFileServer.plist guestAccess -bool false
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist AllowGuestAccess -bool false
#disable autologin
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool true
