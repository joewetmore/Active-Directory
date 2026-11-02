Import-Module ActiveDirectory

#get protected groups & accounts
Get-ADObject -LDAPFilter '(adminCount=1)' -Properties adminCount |
    Select-Object Name,ObjectClass,DistinguishedName |
    Sort-Object ObjectClass,Name



#dump the security descriptor
$DomainDN = (Get-ADDomain).DistinguishedName
$AdminSDHolder = "AD:\CN=AdminSDHolder,CN=System,$DomainDN"
(Get-Acl $AdminSDHolder).Access |
    Sort-Object IdentityReference |
    Format-Table IdentityReference,
                 ActiveDirectoryRights,
                 AccessControlType,
                 IsInherited,
                 InheritanceType -AutoSize


#isolate for 'everyone'
(Get-Acl $AdminSDHolder).Access |
    Where-Object {$_.IdentityReference -match 'Everyone'} |
    Format-List *


#save the complete SDDL
$ACL = Get-Acl $AdminSDHolder
$ACL.Sddl
$ACL.Sddl | Out-File C:\Temp\AdminSDHolder-Before.sddl
