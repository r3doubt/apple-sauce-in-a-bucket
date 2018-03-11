#!/bin/bash
#This script by r3doubt 
#hardApple v0.1
#Test before you use and modify as needed
#Read the readme file
#Implements light version of NIST SP-800-179 and NCSC EUD for 10.12 10.13 configs
#Heavy version to follow later consider looking at NCSC provisioning script for 10.12 in meantime
#yeah, I know I should move all the default writes to arrays and loops, feel free to contribute
#Ensure commands are run using "sudo"
if [ "$(id -u)" != "0" ]; then
 echo "Sorry, you must be root."
 exit 1
fi
#enable automatic updates if you want, just uncomment
softwareupdate --schedule on
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

#disable guest account 
dscl . -create /Users/Guest AuthenticationAuthority ";basic;"
dscl . -create /Users/Guest passwd "*"
dscl . -create /Users/Guest UserShell "/sbin/nologin"
defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled -int 0
#guest access to share folders
defaults write /Library/Preferences/com.apple.AppleFileServer.plist guestAccess -bool false
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist AllowGuestAccess -bool false
#kcpassword file
rm /etc/kcpassword
#login gui settings
defaults write /Library/Preferences/com.apple.loginwindow.plist PowerOffDisabled -bool true 
defaults write /Library/Preferences/loginwindow.plist showInputMenu -bool false
defaults write /Library/Preferences/com.apple.loginwindow.plist RetriesUntilHint -int 0
defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
#screenlock stuff
systemsetup -setdisplaysleep 5
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
#disable autologin
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool true
#Changing the umask setting to 027, only group members to read files and folders
echo "umask 027" >> /etc/launchd.conf
#commands to remove multicast from Bonjour/Zeroconf mDNSResponder service
launchctl unload /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
launchctl unload /System/Library/LaunchDaemons/com.apple.mDNSResponderHelper.plist
defaults write /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist ProgramArguments -array-add "-NoMulticastAdvertisements"
launchctl load /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
launchctl load /System/Library/LaunchDaemons/com.apple.mDNSResponderHelper.plist
#loop to unload unnecessary services using launchctl
#you can also find more and add to the array
array=("com.apple.nis.ypbind.plist" "com.apple.racoon.plist" "com.apple.RemoteDesktop.PrivilegeProxy.plist" "com.apple.RFBEventHelper.plist" "com.apple.UserNotificationCenter.plist" "com.apple.webdavfs_load_kext.plist" "org.postfix.master")
for i in "${array[@]}"
do
launchctl unload -w /System/Library/LaunchDaemons/$i
done
exit 1
#This is a loop to strip setuid bits
array=("/usr/sbin/traceroute" "/usr/sbin/traceroute6")
for i in "${array[@]}"
do
chmod -s $i 
done
exit 1
#This is a loop to strip setgid bit
array=("/usr/bin/wall" "/usr/bin/write" "/usr/sbin/postdrop" "/usr/sbin/postqueue")
for i in "${array[@]}"
do
chmod g-s $i 
done
exit 1
#This section has more network and firewall stuff
#disable IPV6, may require tweak on the network name for different OS versions, use networksetup list command for details
networksetup -setv6off 'Thunderbolt Bridge' && networksetup -setv6off Wi-Fi
#enable PF firewall
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
#/usr/libexec/ApplicationFirewall/socketfilterfw --setblockall on
#Still working on basic firewall settings please manpage PF firewall 
exit 0


