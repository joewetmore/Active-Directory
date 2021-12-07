
Add-WindowsFeature AD-Domain-Services
Add-WindowsFeature rsat-adds

# Join to domain


# New DC in existing domain
Install-ADDSDomainController -InstallDns -DomainName "corp.contoso.com"



# First DC in New forest
Install-ADDSForest
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Win2016" `
 -DomainName "yourdomain.com" `
 -DomainNetbiosName "THEGEEKSTUFF" `
 -ForestMode "Win2016" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true
 
 
 
