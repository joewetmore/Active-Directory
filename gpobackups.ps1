# gpo-backup.ps1
# 2/10/2024 Joe Wetmore
#
# The purpose of this script is to take full backups of all GPOs on a domain controller and write them to timestamped subdirectories in a designated location


# Variables

# Where should the GPO backups be saved
$folderpath = "C:\GPObackups"

# Define the expiration age of folders in the backup directory. Folders older than this age will be removed. Default = 30
$age = (Get-Date).AddDays(-30)



# Create the backup directory if it does not exist
if (!(Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $folderPath
}

# Backup the GPOs
$Date = (Get-Date).ToString("dd-MM-yy hh-mm-ss") 
Mkdir $folderpath\$Date 
$backup = Join-Path $folderpath -ChildPath $date 
backup-gpo -all -Path $backup

# Remove expired directories
Get-ChildItem $folderpath -directory | foreach{
    # if creationtime is 'le' (less or equal) than X days
    if ($_.CreationTime -le $age){
        Write-Output "Older than the expiration age - $($_.name)"
        # remove the item
        Remove-Item $_.fullname -Force -Verbose
    }else{
        Write-Output "Less than the expiration age - $($_.name)"
        # Do stuff
    }
} 
