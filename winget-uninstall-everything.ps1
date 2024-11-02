# Ensure you run this script with administrator privileges

# Check if the WinGet module is installed
if (-not (Get-Module -ListAvailable -Name Microsoft.WinGet.Client)) {
    Write-Host "Microsoft.WinGet.Client module is not installed. Installing it now..."
    try {
        Install-Module -Name Microsoft.WinGet.Client -Scope CurrentUser -Force -AllowClobber -ErrorAction Stop
        Write-Host "Module installed successfully."
    } catch {
        Write-Host "Failed to install Microsoft.WinGet.Client module: $_"
        exit
    }
}

# Import the module
Import-Module Microsoft.WinGet.Client

# Get the list of installed applications and their IDs
$appLines = Get-WinGetPackage | Select-Object Name, Id

# Loop through each application and attempt to uninstall it
foreach ($app in $appLines) {
    try {
        Write-Host "Uninstalling $($app.Name), ID: $($app.Id)..."
        winget uninstall $app.Id --silent
    } catch {
        Write-Host "Failed to uninstall $($app.Name): $_"
    }
}
