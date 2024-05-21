#!/bin/sh

###
#
#            Name:  Jamf Protect Location Services Check Permissions.sh
#     Description:  Corrects permissions on the plist controlling Location
#                   Services settings.
#      Created by:  Jono Loveys
#         Version:  1.0

/usr/bin/sudo /usr/bin/defaults write /Library/Preferences/com.apple.locationmenu.plist ShowSystemServices -bool true