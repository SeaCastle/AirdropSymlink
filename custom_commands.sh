#!/bin/bash

# Prepares all necessary files / folders for an Airdrop which
# includes symbolicly linking the Downloads folder to Carli's
# USB so we don't save the photos / videos on the Mac
function airdropPrep()
{

  usbName="/Volumes/CARLIS\ USB"

  # Check to see if the device is mounted. If not return immediately.
  if [ -z "$(mount | grep "on $usbName (")" ];
  then
    printf '\n[ERROR]: %s is not Mounted... \n\nABORTING...\n\n' "$usbName"
    return;
  else
    printf '\n[SUCCESS]: %s is found. prepping for AirDrop\n' "$usbName"



    # Check whether we need to move files from Downloads to OldDownloads before 
    # deleting the Downloads folder
    printf '%s' '-- Checking to see if files are in Downloads folder... '
    sleep 0.5

    if [ -n "$(ls -A ~/Downloads)" ];
    then
      printf 'Files found in Downloads\nPreparing to transfer files from ~/Downloads to ~/OldDownloads\n'
      find ~/Downloads -iname '*.*' | while read filename
      do
        printf 'Moving file %s\n' "$filename"
        mv "$filename" ~/OldDownloads
      done
    else
      printf 'No files in Downloads\n'
    fi

  # Delete the Downloads folder to prepare for symlink to USB with a fake Downloads folder
  printf 'Removing Downloads folder:'
  sudo rmdir ~/Downloads


  # Create a symbolic link from the new 'fake' Downloads folder to the USB folder
  printf 'Setting symLink between USB: %s and ~/Downloads\n' "$usbName"
  ln -s /Volumes/CARLIS\ USB/testDir ~/Downloads
  fi
}

