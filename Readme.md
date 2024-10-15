# NVIDIA Driver Updater Script
A PowerShell script designed to automatically check for the latest NVIDIA GPU drivers, download the newest version if available, and install it silently. This tool helps users keep their NVIDIA drivers up-to-date without the need to manually search for updates or navigate through the NVIDIA website.

## Features
- Automatically checks for the latest NVIDIA drivers.
- Downloads the driver if a new version is available.
- Installs the driver silently.
- Shows notifications for success or failure.

## Requirements
- PowerShell (Windows)
- An internet connection to check for driver updates.

Download or clone the repository to your local machine.
Open PowerShell as an Administrator.
Navigate to the directory where the script is saved.
Run the script using the following command:
powershell


.\nvidia_updater_script.ps1
(Optional) Schedule the Script with Task Scheduler:
Open Task Scheduler by pressing Windows + R, typing taskschd.msc, and pressing Enter.
Click "Create Task..." and give it a name like "NVIDIA Updater Script."
In the General tab, check "Run with highest privileges" to ensure it has the permissions needed for driver updates.

Go to the Actions tab, click "New...", and set the Program/script to:
powershell.exe
Set Add arguments to:
-File "C:\Users\Documents\project_folder\nvidia_updater_script.ps1"

Set a trigger under the Triggers tab to specify when the script should run (e.g., daily).
Click OK to save the task, and enter your password if prompted.
The script will now run automatically according to the schedule you set.
