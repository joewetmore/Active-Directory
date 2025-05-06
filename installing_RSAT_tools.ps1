On Windows 10/11

How to install RSAT tools on Windows 10

https://www.itechguides.com/rsat-windows-10/

DISM.exe /Online /Get-Capabilities | find "Rsat"

DISM /Online /Add-Capability /CapabilityName:Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.BitLocker.Recovery.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.CertificateServices.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.DHCP.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.Dns.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.FailoverCluster.Management.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.FileServices.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.IPAM.Client.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.LLDP.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.NetworkController.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.NetworkLoadBalancing.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.RemoteAccess.Management.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.RemoteDesktop.Services.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.ServerManager.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.Shielded.VM.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.StorageMigrationService.Management.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.StorageReplica.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.SystemInsights.Management.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.VolumeActivation.Tools~~~~0.0.1.0
DISM /Online /Add-Capability /CapabilityName:Rsat.WSUS.Tools~~~~0.0.1.0

To download and install Easy365Manager
https://www.easy365manager.com/


On Windows Server

How to Quickly List Installed Roles and Features using PowerShell - Active Directory Pro

get-windowsfeature
Get-WindowsFeature | Where-Object {$_. installstate -eq "installed"}
Get-WindowsFeature | Where-Object {$_. installstate -eq "installed"} | select Name,Installstate
Get-WindowsFeature -ComputerName dc1 | Where-Object {$_. installstate -eq "installed"} | select Name,Installstate
get-windowsfeature *ad*
‘dc1′,’dc2’ | %{Get-WindowsFeature *ad* -ComputerName $_ | ? {$_.installstate -eq “installed”}}
