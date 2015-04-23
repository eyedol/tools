#!/bin/bash -e

# Create an ignorelist file at /tmp to list all the files and folders
# you don't want to be backed up by rsync.

# Don't forget to change the destination path to match where you want 
# to save the backup to.

# Use the distribution name and version number to create the folder to 
# save the backup in. Replace all whitespaces with `-`
DEST_FOLDER_NAME=$(head -n 1 /etc/issue | tr  ' ' '-')

DESTINATION="/run/media/$USER/ext4-linux/$DEST_FOLDER_NAME/"

# Notification message
NOTIFY_MSG="Backup finished!"

echo "backing up $USER directory..."
rsync -aP --exclude-from=/tmp/ignorelist --relative /home/$USER/ $DESTINATION

echo "backing up /opt/ directory..."
rsync -aP --exclude-from=/tmp/ignorelist --relative /opt/ $DESTINATION

notify-send $NOTIFY_MSG -t 10000
