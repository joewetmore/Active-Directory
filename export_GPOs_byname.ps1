<#
.SYNOPSIS
===========================================================================
Created on:         Sept 9, 2024
Last Updated on:    Oct 6, 2024  
Created by:         Joe Wetmore
Organization:       Comtech
Filename:           export_GPOs_byname.ps1
File Version:       1.0.0.1
===========================================================================

.DESCRIPTION
! PLEASE RUN AS ADMIN to be sure commands complete properly
- Will export all GPOs with human-readable directory names

.LINK
- 

.NOTES
- GPMC must be installed

#>


Get-GPO -All | % {
  $name = $_.DisplayName
  $dir = New-Item "C:\InstallFiles\AD_setup\gpoimport\convert_notneeded\_fix\rexport\$name" -Type Directory
  Backup-GPO -Guid $_.Id -Path $dir
}

