#!/bin/bash
#code to ensure commands are run using "sudo"
if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you must be root."
	exit 1
fi

#audit list of setuid and setgid for third-party binaries
echo "List of setuid and setgid files" >> /Users/admin/Desktop/quickAudit.txt
find / -perm -4000 -o -perm -2000 -type f >> /Users/admin/Desktop/quickAudit.txt 2>/dev/null

#quick list of services scheduled to run from launchd
echo "List of Launchd processes" >> /Users/admin/Desktop/quickAudit.txt
launchctl list >> /Users/admin/Desktop/quickAudit.txt

#check your loginwindow plist (or any other plist)
echo "loginwindow plist contents" >> /Users/admin/Desktop/quickAudit.txt
/usr/libexec/PlistBuddy -c "Print" com.apple.loginwindow.plist >> /Users/admin/Desktop/quickAudit.txt
