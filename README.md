# apple-sauce-in-a-bucket v0.1.beta
by r3oubt <br />
hardApple v0.1<br />
Implements light version of configs from NIST SP-800-179 and NCSC EUD 10.12,10.13<br />
Consider looking at NCSC provisioning script (10.12) for account setup and disk encrytion<br />
Run the quickAudit script first to check SIP status and get info on stuff you might want to turn off<br />
Boot to recovery, from terminal run "csrutil disable && reboot"<br />
After running script make sure you reboot to recovery and run "csrutil enable && reboot"<br />
Remember to "chmod" to make executable, then run with "sudo ./"<br />
