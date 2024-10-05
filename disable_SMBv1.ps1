<#
The computer will restart after you run the PowerShell commands to disable or enable SMBv1

https://learn.microsoft.com/en-us/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3?tabs=server
#>

#detect
Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
# without elevation
Get-SmbServerConfiguration | Format-List EnableSMB1Protocol

#disable
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

#enable
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
