# Configure_gMSA_forSQL.ps1 
# Group Managed Service Accounts for MS SQL

# run these commands from a member server that has the AD management tools installed. 
Import-Module ActiveDirectory

# test if a root key already exists
Test-KdsRootKey -KeyId (Get-KdsRootKey).KeyId

# if a key does not exist, create one. this takes 10 hours for the key to be completed, so run it in advance of your planned deployment.
Add-KdsRootKey -EffectiveImmediately

# or, immediately create a key (this is not recommended in production environments)
Add-KdsRootKey –EffectiveTime ((get-date).addhours(-10))

# create a security group and add members
New-ADGroup -Name gsg_SQLgMSA -Description “Security group for SQLgMSA computers” -GroupCategory Security -GroupScope Global
Add-ADGroupMember -Identity gsg_SQLgMSA -Members sql2022$,sql2023$

# create the new gMSA accounts
New-ADServiceAccount -Name SQLgMSA -PrincipalsAllowedToRetrieveManagedPassword gsg_SQLgMSA  -Enabled:$true -DNSHostName SQLgMSA.ether.local  -SamAccountName SQLgMSA -ManagedPasswordIntervalInDays 30
New-ADServiceAccount -Name SQLAgMSA -PrincipalsAllowedToRetrieveManagedPassword gsg_SQLgMSA -Enabled:$true -DNSHostName SQLAgMSA.ether.local -SamAccountName SQLAgMSA -ManagedPasswordIntervalInDays 30

# manual steps
# add gMSA account to local administrators group on both nodes
# add gMSA account to SQL logins with sysadmin role

# allow the machines to receive passwords from the domain controllers
Set-ADServiceAccount -Identity SQLgMSA -PrincipalsAllowedToRetrieveManagedPassword sql2022$
Set-ADServiceAccount -Identity SQLgMSA -PrincipalsAllowedToRetrieveManagedPassword sql2023$
Set-ADServiceAccount -Identity SQLAgMSA -PrincipalsAllowedToRetrieveManagedPassword sql2022$
Set-ADServiceAccount -Identity SQLAgMSA -PrincipalsAllowedToRetrieveManagedPassword sql2023$

# manual steps
# configure SQL Server service and SQL Server Agent service on both nodes to run with the gMSA accounts 
