<#
    .SYNOPSIS
    Get-LAPSPasswords.ps1

    .DESCRIPTION
    Export Windows LAPS Passwords to CSV file with PowerShell.

    .LINK
    www.alitajran.com/export-windows-laps-passwords-report/

    .NOTES
    Written by: ALI TAJRAN
    Website:    www.alitajran.com
    LinkedIn:   linkedin.com/in/alitajran

    .CHANGELOG
    V1.00, 07/23/2024 - Initial version
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$Path, # Mandatory parameter for the CSV file path
    [string]$OU # Optional parameter to specify the OU
)

# Determine the base for the search
if ($OU) {
    # If OU is provided, get computers from the specified OU
    $computers = Get-ADComputer -Filter * -SearchBase $OU -Properties OperatingSystem | Select-Object Name, OperatingSystem
}
else {
    # If OU is not provided, get computers from all OUs
    $computers = Get-ADComputer -Filter * -Properties OperatingSystem | Select-Object Name, OperatingSystem
}

# Initialize a List to store the data
$Report = [System.Collections.Generic.List[Object]]::new()

# Loop through each computer and get the LAPS password and additional details
foreach ($computer in $computers) {
    try {
        # Attempt to get the LAPS password for the computer
        $passwordObject = Get-LapsADPassword $computer.Name -AsPlainText
        $password = $passwordObject.Password
        $adminaccount = $passwordObject.Account
        $expirationTimestamp = $passwordObject.ExpirationTimestamp

        # Store the computer name, password, expiration timestamp, local admin account, and operating system in a custom object
        $ReportLine = [PSCustomObject]@{
            ComputerName      = $computer.Name
            LapsPassword      = $password
            ExpirationTime    = $expirationTimestamp
            LocalAdminAccount = "$adminaccount"
            OperatingSystem   = $computer.OperatingSystem
        }
        $Report.Add($ReportLine)
    }
    catch {
        # If there's an error, output a warning
        Write-Host "Failed to get details for $($computer.Name): $_" -ForegroundColor Red
    }
}

# Output the results in a grid view
$Report | Sort-Object ComputerName | Out-GridView -Title LapsPasswords

# Export the results to a CSV file
$Report | Sort-Object ComputerName | Export-Csv -Path $Path -Encoding UTF8 -NoTypeInformation
