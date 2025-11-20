# this command gets a list of Win2012 & 2012r2 servers in AD

Get-ADComputer -Filter {OperatingSystem -like "*2012*"} -Property Name, OperatingSystem, DistinguishedName, LastLogonTimestamp |
Select-Object Name, OperatingSystem, DistinguishedName, @{Name='LastLogonTimestamp';Expression={[DateTime]::FromFileTime($_.LastLogonTimestamp)}} |
Export-Csv "C:\Reports\Windows2012Servers.csv" -NoTypeInformation
