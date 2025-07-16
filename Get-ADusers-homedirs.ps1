# Import the AD module
Import-Module ActiveDirectory

# Get all enabled users with selected properties
Get-ADUser -Filter 'Enabled -eq $true' -Properties Name, UserPrincipalName, HomeDirectory |
    Select-Object Name, UserPrincipalName, HomeDirectory |
    Format-Table -AutoSize 
