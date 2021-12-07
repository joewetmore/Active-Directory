$dhcpservername = 'app-dc-100.corp.global.ads'
$dhcpserverIP = '10.144.110.9'
$sitenetwork = '144'

Install-WindowsFeature DHCP -IncludeManagementTools

Add-DhcpServerInDC -DnsName $dhcpservername -IPAddress $dhcpserverIP
Get-DhcpServerInDC

Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

Set-DhcpServerv4DnsSetting -ComputerName $dhcpservername -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

Set-DhcpServerv4OptionValue -ComputerName $dhcpservername -DnsDomain corp.global.ads -DnsServer $dhcpserverIP,10.100.110.100

Add-DhcpServerv4Scope -name "Workstations (VLAN 120)" -StartRange "10.$sitenetwork.120.51" -EndRange "10.$sitenetwork.120.250" -SubnetMask 255.255.255.0 -State InActive
Set-DhcpServerv4OptionValue -OptionID 3 -Value "10.$sitenetwork.120.1" -ScopeID "10.$sitenetwork.120.0" -ComputerName $dhcpservername
#Add-DhcpServerv4ExclusionRange -ScopeID 10.0.0.0 -StartRange 10.0.0.1 -EndRange 10.0.0.15

Add-DhcpServerv4Scope -name "WiFi (VLAN 140)" -StartRange "10.$sitenetwork.140.51" -EndRange "10.$sitenetwork.140.250" -SubnetMask 255.255.255.0 -State InActive -LeaseDuration 0.03:00:00
Set-DhcpServerv4OptionValue -OptionID 3 -Value "10.$sitenetwork.140.1" -ScopeID "10.$sitenetwork.140.0" -ComputerName $dhcpservername 

Add-DhcpServerv4Scope -name "Management (VLAN 100)" -StartRange "10.$sitenetwork.100.51" -EndRange "10.$sitenetwork.100.250" -SubnetMask 255.255.255.0 -State InActive
Set-DhcpServerv4OptionValue -OptionID 3 -Value "10.$sitenetwork.100.1" -ScopeID "10.$sitenetwork.100.0" -ComputerName $dhcpservername

Add-DhcpServerv4Scope -name "Voice (VLAN 130)" -StartRange "10.$sitenetwork.130.51" -EndRange "10.$sitenetwork.130.250" -SubnetMask 255.255.255.0 -State InActive
Set-DhcpServerv4OptionValue -OptionID 3 -Value "10.$sitenetwork.130.1" -ScopeID "10.$sitenetwork.130.0" -ComputerName $dhcpservername
