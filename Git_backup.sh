#!/bin/bash

#Set main variables
SOURCE_DIR="/root/Backup"
TARGET_USER="yehor"
TARGET_IP="192.168.0.2"
TARGET_DIR="/home/yehor/Backups"
DATE=$(date +%d-%m-%Y_%H:%M:%S)
LOG_FILE="/root/logs/Backup_$DATE.log"
BACKUP_NAME="Backup_$DATE.tar.gz"
ARCHIVE_PATH="/root/Archive/$BACKUP_NAME"
cd "$( dirname "$0" )"

#Creating log file
touch "$LOG_FILE"

#Creating comprosed archive
tar -czf "$ARCHIVE_PATH" "$SOURCE_DIR" >> "$LOG_FILE" 2>&1


#SSH connection for deleting all files older than 14 days
ssh "$TARGET_USER@$TARGET_IP" "find $TARGET_DIR -type f -mtime +14 -exec rm -f {} /;" >> "$LOG_FILE" 2>&1 

#SSH connection for deletion all empty directories
ssh "$TARGET_USER@$TARGET_IP" "find $TARGET_DIR -type d -mtime +14 -exec rmdir {} /;" >> "$LOG_FILE" 2>&1

#Sending archive to the target dir of host
rsync -avz --delete "$ARCHIVE_PATH" "$TARGET_USER@$TARGET_IP:$TARGET_DIR" >> "$LOG_FILE" 2>&1


#Cheking for an errors and sending mail
if [ $? -eq 0 ]
then
	/usr/bin/python3 "$( dirname "$0" )Git_backup.py" "Backup $DATE SUCCESS" "Backup is finished succsesfully. Data is safe. Chek files at the server"
else
	/usr/bin/python3 "$( dirname "$0" )Git_backup.py" "Backup $DATE FAIL" "Backup is finished with some error. Chek file at server"
fi

