#!/bin/bash
## backup script

BACKUPTIME=$(date +%Y-%m-%d_%H-%M-%S)

# Keep number of newest backups
KEEPNO=14

# Directories to backup
BACKUPSOURCES="/home /etc /opt/ /var/www"

# Target directory (no trailing slash!)
BACKUPDIR="/path/to/backups"

BACKUPDEST="${BACKUPDIR}/backup-${BACKUPTIME}.tar.gz"

# Backing up using gzipped tar
tar -cpzf $BACKUPDEST $BACKUPSOURCES
chown pi:pi $BACKUPDEST
cd $BACKUPDIR
find . -maxdepth 1 -name 'backup-*.tar.gz' -type f -printf '%T@ %p\n' | sort -n | sed "s/^[^ ]* //" | head -n -$KEEPNO | xargs rm -vf

# Restore with for example:
# tar -xpzf "/path/to/backups/backup-2020-01-01_03-00-00.tgz"