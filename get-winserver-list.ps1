# example usage
# .\Get-ServerComputers.ps1 -DomainFqdn "contoso.com"
# export to CSV
# ... | Export-Csv "WindowsServerComputers.csv" -NoTypeInformation -Encoding UTF8


param(
    [Parameter(Mandatory)]
    [string]$DomainFqdn
)

Import-Module ActiveDirectory

# Query the specified domain’s default naming context
$rootDse = Get-ADRootDSE -Server $DomainFqdn
$searchBase = $rootDse.DefaultNamingContext

Get-ADComputer -Server $DomainFqdn `
    -SearchBase $searchBase `
    -LDAPFilter "(operatingSystem=*Server*)" `
    -Properties OperatingSystem, OperatingSystemVersion, DNSHostName, Enabled, LastLogonDate |
Select-Object Name, DNSHostName, Enabled, OperatingSystem, OperatingSystemVersion, LastLogonDate |
Sort-Object Name
``
