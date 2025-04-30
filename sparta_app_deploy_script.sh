#!/bin/bash

# update 
sudo apt-get update
# upgrade
sudo apt-get upgrade -y
# Check if 'unzip' is installed
if ! command -v unzip &> /dev/null
then
    echo "unzip is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y unzip
else
    echo "unzip is already installed."
fi
#y secure copy of files from 
# Prompt user for the file name
read -p "Enter the name of the file to copy: " SOURCE_FILE
# Check if file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
  echo "Error: File '$SOURCE_FILE' does not exist."
  exit 1
fi

# prompt user to enter IP address
read -p "Enter the name of the IP adress of your VM: " DEST_IP
# Define destination details
DEST_USER="jillisa.thompson"
DEST_PATH="/home/$DEST_USER"
REMOTE_FILE="${DEST_PATH}${SOURCE_FILE}"
# get secure copy
# Copy the file using scp
scp -i ~/.ssh/tech504-shakara-gcp "$SOURCE_FILE" "$DEST_USER@$DEST_IP:$DEST_PATH"

# Extract filename and reuse later
FILENAME=$(basename "$SOURCE_FILE")
echo "Successfully copied: $FILENAME"
#scp -i ~/.ssh/tech504-shakara-gcp nodejs20-sparta-test-app.zip jillisa.thompson@$DEST_IP:/home/jillisa.thompson/sparta_app
# unzipping 
# TODO could use variablename instead of hardcoded name 
unzip nodejs20-sparta-test-app.zip
# download + install and run 
sudo apt-get install nginx
# checking if nginx is active and running
# TODO add exception handling here 
sudo systemctl status nginx
# download + install (required version) node.js
sudo bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"
# download + install node.js
apt-get install node.js -y
# checking installation is complete
# TODO add exception handling 
node --version
# navigate to app directory
cd spart_app/app
# install node app
sudo npm install
# start app
# run directly in the background npm start &
npm start

