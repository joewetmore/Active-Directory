# Get all time zones
$timeZones = [System.TimeZoneInfo]::GetSystemTimeZones()

# Display the time zones with numbered list
for ($i = 0; $i -lt $timeZones.Count; $i++) {
    Write-Host "$($i + 1). $($timeZones[$i].Id)"
}

# Prompt the user to select a time zone by number
$selection = Read-Host "Please enter the number corresponding to the desired time zone"

# Convert the input to an integer and validate the selection
if ([int]::TryParse($selection, [ref]$selectedIndex) -and $selectedIndex -gt 0 -and $selectedIndex -le $timeZones.Count) {
    $selectedTimeZone = $timeZones[$selectedIndex - 1]
    Write-Host "You have selected: $($selectedTimeZone.Id)"
    
    # Set the system time zone
    tzutil /s "$($selectedTimeZone.Id)"
    Write-Host "The system time zone has been set to: $($selectedTimeZone.Id)"
} else {
    Write-Host "Invalid selection. Please run the script again and enter a valid number."
}




# Get all time zones
$timeZones = [System.TimeZoneInfo]::GetSystemTimeZones()

# Display the time zones with a numbered list
for ($i = 0; $i -lt $timeZones.Count; $i++) {
    Write-Host "$($i + 1). $($timeZones[$i].Id) - $($timeZones[$i].DisplayName)"
}

# Prompt the user to select a time zone by number
$selection = Read-Host "Please enter the number corresponding to the desired time zone"

# Convert the input to an integer and validate the selection
if ([int]::TryParse($selection, [ref]$selectedIndex) -and $selectedIndex -gt 0 -and $selectedIndex -le $timeZones.Count) {
    $selectedTimeZone = $timeZones[$selectedIndex - 1]
    Write-Host "You have selected: $($selectedTimeZone.Id) - $($selectedTimeZone.DisplayName)"
    
    # Set the system time zone
    Start-Process -FilePath "tzutil.exe" -ArgumentList "/s `"$($selectedTimeZone.Id)`"" -NoNewWindow -Wait
    Write-Host "The system time zone has been set to: $($selectedTimeZone.Id)"
} else {
    Write-Host "Invalid selection. Please run the script again and enter a valid number."
}
