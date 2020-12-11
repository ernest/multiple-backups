#!/bin/bash
# This script backs up large files from one drive to another.

if ! [ -x "$(command -v rsync)" ]; then
    echo "Could not find rsync."
    exit 1
fi

declare -r sourcePartition="primary"
declare -r destinationPartition="secondary"
declare -r sourcePath="/media/$USER/$sourcePartition/"
declare -r destinationPath="/media/$USER/$destinationPartition"
declare -r exclusionsFile="exclude.dat"
declare -r excludePath="/media/$USER/$sourcePartition/$exclusionsFile"
dryRunPass=0

echo "Backup your backups!"
echo
echo "Source:         $sourcePath"
echo "Destination:    $destinationPath"
echo "Exclusions in:  $excludePath"
echo
echo "Trying command..."
echo

rsync -av --dry-run --exclude-from="$excludePath" "$sourcePath" "$destinationPath" && dryRunPass=1
echo

if [ $dryRunPass -eq 0 ]; then
    echo "The dry run failed. See command output above."
    exit 1
else
    read -p "Does the output above look correct? [0/1]: " acceptContinue
    echo
    if [ $acceptContinue -eq 1 ]; then
        echo "Continuing..."
        echo
        rsync -av --human-readable --progress --exclude-from="$excludePath" "$sourcePath" "$destinationPath"
        echo
        echo "Rsync command done."
        echo
        echo "End of the program reached."
    else
        echo "The user did not approve the output. Program stopped."
        exit 1
    fi
fi
