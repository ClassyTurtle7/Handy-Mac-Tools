# Handy-Mac-Tools
A collection of Mac Scripts/Tools I have created on my journey through life

# Install Trend
I created this script to install the trend micro endpoint sensor through a jamf profile.
- Download the package and script
- Create a new configuration profile as per Trend's documentation [here](https://success.trendmicro.com/dcx/s/solution/000292474?language=en_US&sfdcIFrameOrigin=null)
- Upload the package and script to Jamf (Ensure the script is set to run AFTER other actions
- Create a policy with both the script and package and push to endpoints
