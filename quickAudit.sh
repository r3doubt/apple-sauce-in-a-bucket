+#!/bin/bash
+#code to ensure commands are run using "sudo"
+if [ "$(id -u)" != "0" ]; then
+	echo "Sorry, you must be root."
+	exit 1
+fi
+
+#audit list of setuid and setgid for third-party binaries
+find / -user root -perm -04000 -ls >quickAuditLog.txt 2>/dev/null
+find / -user root -perm -02000 -ls >>quickAuditLog.txt 2>/dev/null
+#quick list of services scheduled to run from launchd
+launchctl list >>quickAuditLog.txt
+#check your loginwindow gui plist (or any other plist)
+/usr/libexec/PlistBuddy -c print /Library/Preferences/com.apple.loginwindow.plist >>quickAuditLog.txt
+	exit 1