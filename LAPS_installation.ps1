<#
Install and configire LAPS (modern)

https://lazyadmin.nl/it/microsoft-laps/

#>

Import-Module AdmPwd.ps
Update-AdmPwdADSchema

Set-AdmPwdComputerSelfPermission -OrgUnit Computers
Set-AdmPwdComputerSelfPermission -OrgUnit "OU=Managed Objects,DC=ether,DC=local"

# AD Security Group for LAPS read/write access
New-ADGroup -name 'LAPS Admins' -GroupCategory Security -GroupScope Global

# AD Security Group for LAPS readonly  access
New-ADGroup -name 'LAPS ReadOnly' -GroupCategory Security -GroupScope Global

# Set permissions
Set-AdmPwdReadPasswordPermission -OrgUnit "OU=Managed Objects,DC=ether,DC=local" -AllowedPrincipals 'LAPS Admins','LAPS ReadOnly'
Set-AdmPwdResetPasswordPermission -OrgUnit "OU=Managed Objects,DC=ether,DC=local" -AllowedPrincipals 'LAPS Admins'

<# 
Setup the GPO
1. On the domain controller, navigate to C:\Windows\PolicyDefinitions
2. Copy the AdmPwd.admx to \\contoso.local\SysVol\contoso.local\Policies\PolicyDefinitions
#>

# Get LAPS password
Get-AdmPwdPassword -ComputerName LA-WIN11-LAB03
# Or to return only the password:
Get-AdmPwdPassword -ComputerName LA-WIN11-LAB03 | Select Password

