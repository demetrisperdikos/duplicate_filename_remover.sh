#!/bin/bash

#basic file checker
if [ -z "$1" ]
then
  echo "Please provide a directory"
  exit 1
fi
#declaring array
declare -A fileArray

while IFS= read -r -d '' file
do
  filename=$(basename "$file")
#checking for file that is duplicate
  if [[ ${fileArray["$filename"]} ]]; then
    echo "Duplicate file found: $file and ${fileArray["$filename"]}"
    #prompting user to see if the duplicate file should be deleted
    read -p "Do you want to delete this file? (Y/N): " confirm < /dev/tty
    if [[ "$confirm" == "Y" || "$confirm" == "y" ]]; then
    #removes file
      rm "$file"
      echo "File deleted."
    fi
  else
    fileArray["$filename"]="$file"
  fi
done < <(find "$1" -type f -print0)

exit 0

