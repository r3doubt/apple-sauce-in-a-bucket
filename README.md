# apple-sauce-in-a-bucketv0.1
This script by r3doubt hardApple v0.1<br />
Test before you use and modify as needed<br />
Implements light version of NIST SP-800-179 and NCSC EUD for 10.12 10.13 configs<br />
Heavy version to follow later, consider looking at NCSC provisioning script for 10.12 in meantime<br />
Run the quickaudit script first to check SIP status and get info on stuff you might want to turn off<br />
yeah, I know I should move all the default writes to arrays and loops, feel free to contribute<br />
For more info consult the BSides Columbus talk<br />
Boot to recovery, from shell run "csrutil disable && reboot" from shell<br />
After running script make sure you reboot to recovery and run "csrutil enable && reboot"<br />
To run, rename file to end in .sh, "sudo chmod" to make executable, then run with "sudo" ./<br />
