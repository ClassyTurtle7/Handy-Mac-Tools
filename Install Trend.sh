#!/bin/sh

###
#
#            Name:  Install Trend Sensor
#     Description:  This is a sript installs the TrendMicro VisionOne Endpoint Sensor Correctly
#      Created by:  Jono Loveys
#         Version:  1.0
#            Date:  10/05/24

LOCATION="/tmp/Trend Vision One Sensor"
LOG_LOCATION="/var/log/InstallTrend.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Initilaises log file
echo "--------------------------------" >> "${LOG_LOCATION}"
echo $DATE >> "${LOG_LOCATION}"

# Checks that the files installed
if [ -e "${LOCATION}" ]; then
    echo "Files Found Continuing..." >> "${LOG_LOCATION}"
    # Checks that installer is installed on the device
    if ! command -v installer &> /dev/null; then
        echo "The 'installer' command is not available. Please install the macOS Command Line Tools.\nExiting..." >> "${LOG_LOCATION}"
        exit 1
    fi

    # Makes sure the required package is installed
    if ! [ -e "${LOCATION}/endpoint_basecamp.pkg" ]; then
        echo "Error: endpoint_basecamp.pkg not found!\nExiting..." >> "${LOG_LOCATION}"
        exit 1
    fi
    echo "Installing endpoint_basecamp.pkg..." >> "${LOG_LOCATION}"
    sudo installer -pkg "${LOCATION}/endpoint_basecamp.pkg" -target /
    
    # Makes sure the required package is installed    
    if ! [ -e "${LOCATION}/packages/30db417e-c272-427a-83b0-eb8a070c3cc2/xesinstall/EDRPackage.pkg" ]; then
        echo "Error: EDRPackage.pkg not found!\nExiting..." >> "${LOG_LOCATION}"
        exit 1
    fi
    echo "Installing EDRPackage.pkg..." >> "${LOG_LOCATION}"
    sudo installer -pkg "${LOCATION}/packages/30db417e-c272-427a-83b0-eb8a070c3cc2/xesinstall/EDRPackage.pkg" -target /

    # Waits for the Application to install before exiting
    timeout=300  # 5 minutes timeout
    while [ ! -e "/Applications/EDRMainUI.app" ]; do
        sleep 5
        timeout=$((timeout - 5))
        if [ $timeout -le 0 ]; then
            echo "Timeout reached. Application installation failed!\nExiting..." >> "${LOG_LOCATION}"
            exit 1
        fi
    done
    echo "The Trend Micro Sensor is installed!" >> "${LOG_LOCATION}"
    echo "Removing Files" >> "${LOG_LOCATION}"
    rm -r "${LOCATION}"
    if ! [ -e "${LOCATION}" ]; then
        echo "Files removed successfully!" >> "${LOG_LOCATION}"
    else
        echo "Error removing files please check /tmp/Trend Vision One Sensor/" >> "${LOG_LOCATION}"
    fi
else
    echo "Error: Files Don't exist!\nExiting..." >> "${LOG_LOCATION}"
    exit 1
fi