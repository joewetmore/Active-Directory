Start-Transcript ADdiscovery.txt

# Forest identification
Get-ADForest

# Domain identification
Get-ADDomain

# Get Domain Functional Level:
Get-ADDomain | fl Name,DomainMode

# Get Forest Functional Level:
Get-ADForest | fl Name,ForestMode

# Get the Active Directory Schema version with PS
Get-ADObject (Get-ADRootDSE).schemaNamingContext -Property objectVersion

# List DCs and roles
Get-ADDomainController -filter *

Stop-Transcript
