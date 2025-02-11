
# Define the webhook URL
$webhookUrl = "https://api.instatus.com/v3/integrations/webhook/******************"

# Define the path to the status file
$statusFilePath = "C:\Temp\DiskStatus.txt"

# Function to get the current disk status
function Get-CurrentDiskStatus {
    $physicalDisks = Get-PhysicalDisk
    $allHealthy = $true
    foreach ($disk in $physicalDisks) {
        if ($disk.OperationalStatus -ne "OK" -or $disk.HealthStatus -ne "Healthy") {
            $allHealthy = $false
            break
        }
    }
    return $allHealthy
}

# Function to read the previous status from file
function Get-PreviousDiskStatus {
    if (Test-Path $statusFilePath) {
        return Get-Content $statusFilePath
    } else {
        return $null
    }
}

# Function to save the current status to file
function Save-DiskStatus ($status) {
    Set-Content -Path $statusFilePath -Value $status
}

# Get the current and previous disk status
$currentStatus = Get-CurrentDiskStatus

# Print the result immediately after getting the current status
if ($currentStatus) {
    Write-Output "All physical disks are healthy." -ForegroundColor Green
} else {
    Write-Output "One or more physical disks are not healthy." -ForegroundColor Red
}

$previousStatus = Get-PreviousDiskStatus

# Determine if the status has changed
$statusChanged = $true
if ($previousStatus -ne $null) {
    $statusChanged = ($currentStatus.ToString() -ne $previousStatus)
}

# If the status has changed, send the webhook
if ($statusChanged) {
    $payload = @{
        trigger = if ($currentStatus) { "up" } else { "down" }
    }

    # Convert the payload to JSON
    $jsonPayload = $payload | ConvertTo-Json

    # Send the JSON payload to the webhook and wait for the response
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $jsonPayload -ContentType "application/json"

    # Print the webhook response
    Write-Output "Webhook Response: $response"

    # Save the current status to file
    Save-DiskStatus $currentStatus.ToString()
} else {
    Write-Output "No status change. No webhook sent." -ForegroundColor Yellow
}

# Small delay so user can see the console output
Start-Sleep -Seconds 3
