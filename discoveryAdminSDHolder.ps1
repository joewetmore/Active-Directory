Import-Module ActiveDirectory

$DomainDN = (Get-ADDomain).DistinguishedName
$AdminSDHolder = "AD:\CN=AdminSDHolder,CN=System,$DomainDN"

(Get-Acl $AdminSDHolder).Access |
    Sort-Object IdentityReference |
    Format-Table IdentityReference,
                 ActiveDirectoryRights,
                 AccessControlType,
                 IsInherited,
                 InheritanceType -AutoSize



(Get-Acl $AdminSDHolder).Access |
    Where-Object {$_.IdentityReference -match 'Everyone'} |
    Format-List *



$ACL = Get-Acl $AdminSDHolder
$ACL.Sddl
$ACL.Sddl | Out-File C:\Temp\AdminSDHolder-Before.sddl
