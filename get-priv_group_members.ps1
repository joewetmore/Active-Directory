$groups = 'Domain Admins','Enterprise Admins'
$members =@()
foreach ($group in $groups)
{
$members = Get-ADGroupMember -Identity $group -Recursive | Select-Object distinguishedName, samaccountname, name, @{Label='Group Name';Expression={$group}}
$members
}
