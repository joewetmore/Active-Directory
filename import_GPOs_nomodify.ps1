<#
.SYNOPSIS
===========================================================================
Created on:         Sept 9, 2024
Last Updated on:    Nov 27, 2024  
Created by:         Joe Wetmore
Organization:       Comtech
Filename:           import_GPOs_nomodify.ps1
File Version:       1.7.1
===========================================================================

.DESCRIPTION
! PLEASE RUN AS ADMIN to be sure commands complete properly
- Will import 83 GPOs with no conversion needed

.LINK
- 

.NOTES
- GPMC must be installed
- Modifies the GPOs
    Core-PuTTY-Saved Sessions
    Core-QoS-Guardian Core
    Core-Radmin-File Copy-Phonebook
    Core-Security-File Permissions-Guardian Admin Software
    Core-Security-Idle Session Lock-Configuration
    Core-Security-Lithnet Idle Logoff-Configuration
    Core-Security-Logon as Batch Job Rights
    Core-Security-Restrict Interactive Logon to Core Servers
    Core-Security-SCHANNEL-Override to Enable TLS10 for WebTools
    Core-Shortcuts-Desktop-Guardian
    Core-Shortcuts-Desktop-IQAdmin
    Core-Shortcuts-Desktop-Radmin
    Core-Shortcuts-Desktop-Sign Out
    Core-Windows-Disable Shutdown Event Tracker
    Core-Windows-Do Not Launch Server Manager at Logon
    Core-Windows Firewall-Administration Servers
    Core-Windows Firewall-Application Servers
    Core-Windows Firewall-Configure Network Connection Profile
    Core-Windows Firewall-Domain Controllers
    Core-Windows Firewall-Enable WinRM
    Core-Windows Firewall-MIS Servers
    Core-Windows Firewall-WSUS Servers
    Core-Windows System-Kerberos Encryption
    Core-Windows System-NTP Configuration-NTP Server
    Core-Windows System-Powershell-Execution Policy to Allow Running Unsigned Scripts
    Global-Appearance-Taskbar-Do not Group
    Global-Appearance-Windows Desktop and Lock Screen-File Copy
    Global-Appearance-Windows Lock Screen-Configuration
    Global-Internet Settings
    Global-LAPS-Application Configuration
    Global-Network-Disable IPv6
    Global-Printers-Print Spooler-Disable
    Global-Security-Certificates-Trust Chains
    Global-Security-Disable Autorun
    Global-Security-Local Users and Groups-Local Administrator Account-Enable
    Global-Security-Local Users and Groups-Remove Local Users (TC and Temp_User)
    Global-Security-Logon Screen-Configuration
    Global-Security-Password Expiry Warning (Windows Notification for Admin Profile)
    Global-Security-SCHANNEL-Disable Insecure TLS1.1 and older and Cipher Suites
    Global-SNMP Services-Configuration
    Global-Windows-Local Group Policy-Remove all
    Global-Windows Firewall-Base Rules
    Global-Windows Firewall-Configuration
    Global-Windows Firewall-Radmin
    Global-Windows System-Crash Dumps-Enable
    Global-Windows System-Folder Options
    Global-Windows System-Keyboard Accessibility Options-Disable
    Global-Windows System-Navigation Sound-Disable
    Global-Windows System-Power Options-Solacom Power Policy
    Global-Windows System-Powershell-Disabled PSv2 Activate Constrained
    Global-Windows System-Regional Options-CA Locale
    Global-Windows System-Remote Desktop-Disable
    Global-Windows System-Removable Storage-Disable
    Global-Windows System-SMBv1-Disable
    Global-Windows System-Start Menu-Add Logoff Button
    Global-Windows System-Startup Policy Processing-Wait for Network
    Global-Windows Time-Time Zone
    Position-USB Storage-Allow Write to USB Storage and Deny Execution
    PSAP-CyberSecurity-Enable(WinRM)-Inbound-SIEM Collector
    PSAP-CyberSecurity-Spectre & Meltdown-Disable
    PSAP-QoS-Guardian Workstation
    PSAP-QoS-LTR (Recorder)
    PSAP-Radmin-File Copy-Phonebook
    PSAP-Security-Ease of Access-Disable
    PSAP-Security-Mobile Network-Enabled
    PSAP-Security-OS Lockdown
    PSAP-Security-OS Lockdown-Laptop Network-Enabled
    PSAP-Security-OS Lockdown-Mobile Network-Enable
    PSAP-Security-OS Lockdown-Supervisor Users
    PSAP-Security-Search-Disable
    PSAP-Shortcuts-Desktop-Guardian
    PSAP-Shortcuts-Desktop-HigherGround Instant Retrieval
    PSAP-Shortcuts-Desktop-Radmin
    PSAP-Shortcuts-Desktop-Signoff
    PSAP-Shortcuts-Desktop-Workstation Restart
    PSAP-Shortcuts-Download-TEMP Folder
    PSAP-Windows-Fast User Switching and Lock Functionality-Disable
    PSAP-Windows-Multimedia Keyboard-Disable Volume Keys
    PSAP-Windows Firewall-Workstation
    PSAP-Windows System-Removable Storage-Enable
    PSAP-Windows Unquoted Service Path Enumeration Mitigation
    PSAP-Windows System-Remote Desktop-Enable
    _FirewallOFF For Testing Only

#>

Import-Module ActiveDirectory            
Import-Module GroupPolicy  

# Get the domain definition from step02
$domain = Get-Content C:\InstallFiles\AD_Setup\Domain.txt
$domainname = Get-Content C:\InstallFiles\AD_Setup\DomainName.txt
$tld = Get-Content C:\InstallFiles\AD_Setup\tld.txt
$hostname = hostname
$customername = Get-Content C:\InstallFiles\AD_Setup\customername.txt


$GPOName = "Core-PuTTY-Saved Sessions"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-QoS-Guardian Core"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Radmin-File Copy-Phonebook"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-File Permissions-Guardian Admin Software"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-Idle Session Lock-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-Lithnet Idle Logoff-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-Logon as Batch Job Rights"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Domain Controllers,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-Restrict Interactive Logon to Core Servers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Security-SCHANNEL-Override to Enable TLS10 for WebTools"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Shortcuts-Desktop-Guardian"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Shortcuts-Desktop-IQAdmin"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Shortcuts-Desktop-Radmin"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Shortcuts-Desktop-Sign Out"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows-Disable Shutdown Event Tracker"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows-Do Not Launch Server Manager at Logon"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-Administration Servers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name "$GPOName" -Target "OU=Administration,OU=Core-A,OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes
New-GPLink -Name "$GPOName" -Target "OU=Administration,OU=Core-B,OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-Application Servers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-Configure Network Connection Profile"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-Domain Controllers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "OU=Domain Controllers,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-Enable WinRM"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-MIS Servers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows Firewall-WSUS Servers"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows System-Kerberos Encryption"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Domain Controllers,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows System-NTP Configuration-NTP Server"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=Datacenters,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Core-Windows System-Powershell-Execution Policy to Allow Running Unsigned Scripts"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "OU=Domain Controllers,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Appearance-Taskbar-Do not Group"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Appearance-Windows Desktop and Lock Screen-File Copy"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Appearance-Windows Lock Screen-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Internet Settings"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-LAPS-Application Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Network-Disable IPv6"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Printers-Print Spooler-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Certificates-Trust Chains"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Disable Autorun"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Local Users and Groups-Local Administrator Account-Enable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
# New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Local Users and Groups-Remove Local Users (TC and Temp_User)"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Logon Screen-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-Password Expiry Warning (Windows Notification for Admin Profile)"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Security-SCHANNEL-Disable Insecure TLS1.1 and older and Cipher Suites"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-SNMP Services-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows-Local Group Policy-Remove all"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows Firewall-Base Rules"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows Firewall-Configuration"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows Firewall-Radmin"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Crash Dumps-Enable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Folder Options"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Keyboard Accessibility Options-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Navigation Sound-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Power Options-Solacom Power Policy"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Powershell-Disabled PSv2 Activate Constrained"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Regional Options-CA Locale"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Remote Desktop-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
#New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Removable Storage-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-SMBv1-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Start Menu-Add Logoff Button"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows System-Startup Policy Processing-Wait for Network"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Global-Windows Time-Time Zone"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "Position-USB Storage-Allow Write to USB Storage & Deny Execution"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
# Link as needed
#New-GPLink -Name $GPOName -Target "TBD" -LinkEnabled Yes

$GPOName = "PSAP-CyberSecurity-Enable(WinRM)-Inbound-SIEM Collector"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-CyberSecurity-Spectre & Meltdown-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-QoS-Guardian Workstation"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-QoS-LTR (Recorder)"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Radmin-File Copy-Phonebook"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-Ease of Access-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name "$GPOName" -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-Mobile Network-Enabled"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-OS Lockdown"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-OS Lockdown-Laptop Network-Enabled"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-OS Lockdown-Mobile Network-Enable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-OS Lockdown-Supervisor Users"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Security-Search-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Desktop-Guardian"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Desktop-HigherGround Instant Retrieval"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Desktop-Radmin"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name "$GPOName" -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Desktop-Signoff"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Desktop-Workstation Restart"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Shortcuts-Download-TEMP Folder"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows-Fast User Switching and Lock Functionality-Disable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows-Multimedia Keyboard-Disable Volume Keys"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows Firewall-Workstation"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows System-Removable Storage-Enable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows Unquoted Service Path Enumeration Mitigation"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
New-GPLink -Name $GPOName -Target "OU=PSAPs,DC=$domain,DC=$tld" -LinkEnabled Yes

$GPOName = "PSAP-Windows System-Remote Desktop-Enable"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
# Link as needed
#New-GPLink -Name $GPOName -Target "TBD" -LinkEnabled Yes

$GPOName = "_FirewallOFF For Testing Only"
$GPOFolderName = "C:\InstallFiles\AD_setup\gpoimport\convert_no\$GPOName"
import-gpo -BackupGPOname $GPOName -TargetName $GPOName -path $GPOFolderName -CreateIfNeeded
# Link as needed
