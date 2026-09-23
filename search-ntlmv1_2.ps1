#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Searches the local Security event log for NTLMv1 logons
    recorded during the previous 24 hours.

.OUTPUTS
    CSV containing:
      - Timestamp
      - Username
      - WorkstationName
#>

$HoursToSearch = 24
$StartTime     = (Get-Date).AddHours(-$HoursToSearch)
$OutputPath   = "C:\Temp\NTLMv1-Logons-$((Get-Date).ToString('yyyyMMdd-HHmmss')).csv"

# Create the output directory if it does not already exist.
$OutputDirectory = Split-Path -Path $OutputPath -Parent

if (-not (Test-Path -Path $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force | Out-Null
}

Write-Host "Searching the local Security log..." -ForegroundColor Cyan
Write-Host "Start time : $StartTime"
Write-Host "Event ID   : 4624"
Write-Host "Output file: $OutputPath"

$Results = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4624
    StartTime = $StartTime
} -ErrorAction Stop | ForEach-Object {

    $Event = $_
    $Xml   = [xml]$Event.ToXml()

    # Convert the named EventData fields into a hashtable.
    $EventData = @{}

    foreach ($DataItem in $Xml.Event.EventData.Data) {
        $EventData[$DataItem.Name] = [string]$DataItem.'#text'
    }

    # Event ID 4624 uses LmPackageName for:
    # "Package Name (NTLM only)"
    if ($EventData['LmPackageName'] -eq 'NTLM V1') {

        # Exclude anonymous logons because they generally do not identify
        # a useful user or originating workstation.
        if ($EventData['TargetUserName'] -ne 'ANONYMOUS LOGON') {
            [PSCustomObject]@{
                Timestamp       = $Event.TimeCreated
                Username        = if ($EventData['TargetDomainName']) {
                    "$($EventData['TargetDomainName'])\$($EventData['TargetUserName'])"
                }
                else {
                    $EventData['TargetUserName']
                }
                WorkstationName = $EventData['WorkstationName']
            }
        }
    }
}

$Results = @($Results)

if ($Results.Count -gt 0) {
    $Results |
        Sort-Object Timestamp |
        Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

    Write-Host ""
    Write-Host "Found $($Results.Count) NTLMv1 logon event(s)." -ForegroundColor Yellow
    Write-Host "Results exported to: $OutputPath" -ForegroundColor Green

    $Results | Format-Table -AutoSize
}
else {
    Write-Host ""
    Write-Host "No NTLMv1 logons were found during the previous $HoursToSearch hours." `
        -ForegroundColor Green
}
