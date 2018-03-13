#!/bin/bash
#replace pathway with your desired location for log output
#code to ensure commands are run using "sudo"
if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you must be root."
	exit 1
fi

#audit list of setuid and setgid for third-party binaries
echo "List of setuid and setgid files" >> [insert pathway]/quickAudit.txt
find / -perm -4000 -o -perm -2000 -type f >> [insert pathway]/quickAudit.txt 2>/dev/null

#quick list of services scheduled to run from launchd
echo "List of Launchd processes" >> [insert pathway]/quickAudit.txt
launchctl list >> [insert pathway]/quickAudit.txt

#check your loginwindow plist (or any other plist)
echo "loginwindow plist contents" >> [insert pathway]/quickAudit.txt
/usr/libexec/PlistBuddy -c "Print" /Library/Preferences/com.apple.loginwindow.plist >> [insert pathway]/quickAudit.txt
