# certificate_cleanup.ps1

# This script will remove two certificates, based on commonname and thumbprint. 
# Backups of the certificates and a log file will be written to C:\certbackups

# 8/29/2025, Joe Wetmore (joew@nwn.ai)

# Run as Administrator

# Thumbprints (case-insensitive; spaces ignored)
$rootThumb = "93b78267060ce08a51fe23882d04c5e0877ff2aa"
$interThumb = "d7df96e4e96fd17f4821450e847c84631b6c6919"

# Where to search/remove
$targets = @(
    @{ Label = "StChristopherSchool-RootCA01";  Thumb = $rootThumb;  Stores = @("Cert:\LocalMachine\Root", "Cert:\LocalMachine\AuthRoot") }, # Root + Third-Party Root
    @{ Label = "StChristopherSchool-SubCA02";   Thumb = $interThumb; Stores = @("Cert:\LocalMachine\CA") }                                   # Intermediate
)

# Backup settings
$exportBeforeDelete = $true
$backupDir = "C:\CertBackups"
if (-not (Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir | Out-Null }

# Log file
$logFile = Join-Path $backupDir "CertRemoval.log"
"=== Certificate Removal Run $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" | Out-File -FilePath $logFile -Append

# Helper: write both console + log
function Write-Log {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
    $Message | Out-File -FilePath $logFile -Append
}

foreach ($t in $targets) {
    $needle = ($t.Thumb -replace '\s','').ToUpperInvariant()

    foreach ($storePath in $t.Stores) {
        Write-Log "Scanning $storePath for $($t.Label) ($needle) ..." "Cyan"

        $matches = Get-ChildItem -Path $storePath | Where-Object {
            (($_.Thumbprint -replace '\s','').ToUpperInvariant()) -eq $needle
        }

        if (-not $matches) {
            Write-Log "  No match in $storePath" "Yellow"
            continue
        }

        foreach ($cert in $matches) {
            Write-Log ("  Found: {0}  Thumbprint={1}  NotAfter={2}" -f $cert.Subject, $cert.Thumbprint, $cert.NotAfter)

            if ($exportBeforeDelete) {
                $outFile = Join-Path $backupDir ("{0}-{1}.cer" -f $t.Label, $cert.Thumbprint)
                try {
                    Export-Certificate -Cert $cert -FilePath $outFile | Out-Null
                    Write-Log "   Backed up to: $outFile" "Green"
                } catch {
                    Write-Log "   Backup failed: $($_.Exception.Message)" "Red"
                }
            }

            try {
                Remove-Item -Path $cert.PSPath -Force
                Write-Log "   Deleted from $storePath" "Green"
            } catch {
                Write-Log "   Delete failed: $($_.Exception.Message)" "Red"
            }
        }
    }
}

Write-Log "=== Script completed $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ==="
