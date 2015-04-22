#!/bin/bash -e

# Create an ignorelist file at /tmp to list all the files and folders
# you don't want to be backed up by rsync.

# Don't forget to change the destination path to match where you want 
# to save the backup to.

DESTINATION="/run/media/$USER/ext4-linux/home/"

echo "backing up $USER directory..."
rsync -aP --exclude-from=/tmp/ignorelist /home/$USER/ $DESTINATION

echo "backing up /opt/ directory..."
rsync -aP --exclude-from=/tmp/ignorelist /opt/ $DESTINATION
