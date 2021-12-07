# export tabs from the 'AD discovery & design.v01.xlsx' worksheet to corresponding .CSV files
# newsites.csv, newsubnets.csv, newOUs_corp.csv, newOUs_global.csv, sitelist.csv


# create AD sites
import-csv c:\temp\newsites.csv | New-ADReplicationSite -verbose

# import subnet list
import-csv c:\temp\newsubnets.csv | New-ADReplicationSubnet -verbose



# create OU structure
# in CORP
import-csv C:\temp\newOUs_corp.csv | ForEach-Object {
    New-ADOrganizationalUnit -Name $($_.Name) -Path $($_.Path) -Description $($_.Description)
}

# in GLOBAL
import-csv C:\temp\newOUs_global.csv | ForEach-Object {
    New-ADOrganizationalUnit -Name $($_.Name) -Path $($_.Path) -Description $($_.Description)
}



# create TLA-Regional Admins and TLA-Helpdesk groups

import-csv C:\temp\sitelist.csv | ForEach-Object {
    New-ADGroup -name "$($_.Name)-RegionalAdmins" -SamAccountName "$($_.Name)Admins" -GroupCategory Security -GroupScope Global -DisplayName "$($_.Name)-RegionalAdmins" -Path "OU=Users,OU=Admins,OU=Managed Objects,DC=corp,DC=global,DC=ads" -Description "Members of this group are administrators of $($_.Name) Site Objects"
}

import-csv C:\temp\sitelist.csv | ForEach-Object {
    New-ADGroup -name "$($_.Name)-Helpdesk" -SamAccountName "$($_.Name)Helpdesk" -GroupCategory Security -GroupScope Global -DisplayName "$($_.Name)-Helpdesk" -Path "OU=Users,OU=Admins,OU=Managed Objects,DC=corp,DC=global,DC=ads" -Description "Members of this group are helpdesk staff for the site $($_.Name)"
}

