# Backup your backups!
This script makes copies of files on one partition and moves them to another. This is useful for making an additional copy of files you have backed up. Storing your second backup seperately from your primary backup makes it harder for you to lose your data.

### Defaults
By default the source location is `/media/$USER/primary/` and the destination is `/media/$USER/secondary/`. You can change the names of the partitions or choose a drive at a different location, like `/mnt`, by changing the `sourcePartition` and `destinationPartition` variables in the script.

This script ignores directories and hidden files. See `exclude.dat` for details and to exclude more files.

### Set up
- This script requires [rsync](https://packages.debian.org/buster/rsync) to move files and check for duplicates.
- Before running the script, make sure the source and destination locations are accessable.
- Run `backup.sh` everytime you want to backup.

### Verify your backup
Once the script has finished, check:
```bash
cd /media/$USER/secondary/
ls -a
```
The output should be the list of files from the original backup.
