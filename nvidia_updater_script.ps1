# Load necessary assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to show notification using Windows Forms
function Show-Notification {
    param (
        [string]$title,
        [string]$message
    )
    
    # Create a NotifyIcon object
    $notification = New-Object system.windows.forms.notifyicon
    $notification.Icon = [System.Drawing.SystemIcons]::Information
    $notification.BalloonTipTitle = $title
    $notification.BalloonTipText = $message
    $notification.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
    $notification.Visible = $true

    # Show the notification
    $notification.ShowBalloonTip(5000)
    
    # Close the notification after showing it
    Start-Sleep -Seconds 5
    $notification.Dispose()
}

# NVIDIA Driver Update URL
$nvidiaUpdateUrl = "https://www.nvidia.com/Download/processDriverSearch.aspx?psid=1&pfid=815&osid=57&lid=1&whql=0&beta=0&isWHQL=0&ctk=0&dtid=1"

Write-Host "Checking for the latest NVIDIA driver..."

# Download the latest driver page content
$pageContent = Invoke-WebRequest -Uri $nvidiaUpdateUrl

# Output the page content for inspection
Write-Host "Page content retrieved:"
Write-Host $pageContent.Content

# Extract the driver version from the content (fine-tune the regex based on NVIDIA page structure)
$latestDriver = $pageContent.Content -match 'Version: ([0-9]+\.[0-9]+)'

if ($latestDriver) {
    Write-Host "New driver found: $($matches[1])"
    
    # Define the download URL for the driver (you need to update this to the correct URL for the driver)
    $driverUrl = "https://www.nvidia.com/path/to/driver.exe"
    $downloadPath = "$env:TEMP\nvidia_driver.exe"
    
    # Download the driver
    Write-Host "Downloading NVIDIA driver..."
    Invoke-WebRequest -Uri $driverUrl -OutFile $downloadPath
    
    # Verify if the file was downloaded
    if (Test-Path $downloadPath) {
        Write-Host "Download successful. Installing driver..."
        
        # Install the driver silently (modify the arguments if needed for the installer)
        Start-Process -FilePath $downloadPath -ArgumentList "/S" -Wait
        
        # Check if installation succeeded
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Driver installation completed successfully."
            Show-Notification -title "NVIDIA Driver Update" -message "Installation completed successfully."
        } else {
            Write-Host "Driver installation failed."
            Show-Notification -title "NVIDIA Driver Update" -message "Installation failed."
        }
    } else {
        Write-Host "Driver download failed."
        Show-Notification -title "NVIDIA Driver Update" -message "Driver download failed."
    }
} else {
    Write-Host "No new NVIDIA drivers found."
    Show-Notification -title "NVIDIA Driver Update" -message "No new drivers found."
}
