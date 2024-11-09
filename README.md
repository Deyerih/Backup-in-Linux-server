# Backup-in-Linux-server
There are two files to backing up some files from Linux Debian server to remote Ubuntu server. The Python script sends a message to email in case of success or failure. In turn, the Bash script is responsible for the actual backup process, along with logging, creating zip archives to save memory on the device, and cleaning old backup files. (You dont need to run python skript, its just for setin up sending emails)

For use this program you must do the following steps:
  1. You must create and set up google account. Turn on two-step verification and generate sixteen character password in order for the script to be able to send an email without the need to enter a password and other verification steps (You should find many video's about this)
  2. Set up SSH connection between devices.
  3. Generate SSH-key In order for Bash script to be able to login with SSH to target system without the need to enter a pass.
  4. Change the variable values ​​in both scripts to your own
  5. If necessary, configure the automatic execution of the BASH script. Use crontab. 
