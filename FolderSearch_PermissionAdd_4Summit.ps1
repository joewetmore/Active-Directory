 # Define the root folder to start the search
$rootFolder = "C:\PermissionTest"

# Define the security group
$securityGroup1 = "aapcb.local\Administrators"
$securityGroup2 = "summit-pcb\Administrators"
$securityGroup3 = "aapcb.local\Accounting Group"
$securityGroup4 = "summit-pcb\den.Accounting.rw"
$securityGroup5 = "aapcb.local\Sales Group"
$securityGroup6 = "summit-pcb\Summit-Denver-Sales Users"
$securityGroup7 = "aapcb.local\Client Services Group"
$securityGroup8 = "summit-pcb\Summit-Denver-Client Service Users"


# Function to set read-only permission
function Set-ReadOnlyPermission {
    param (
        [string]$folderPath,
        [string]$securityGroup
    )
    
    # Get the current ACL (Access Control List) for the folder
    $acl = Get-Acl $folderPath
    
    # Create a new file system access rule
    $readOnlyRule = New-Object System.Security.AccessControl.FileSystemAccessRule($securityGroup, "ReadAndExecute", "ContainerInherit, ObjectInherit", "None", "Allow")
    
    # Add the new rule to the ACL
    $acl.AddAccessRule($readOnlyRule)
    
    # Set the new ACL for the folder
    Set-Acl $folderPath $acl
}

# Function to recursively search for directories named "Special Data"
function Search-And-SetPermission {
    param (
        [string]$currentFolder
    )
    
    # Get all directories in the current folder
    $directories = Get-ChildItem -Path $currentFolder -Directory -Recurse -Force
    
    foreach ($dir in $directories) {
        # Check if the directory name is "Special Data"
        if ($dir.Name -eq "Sensitive Data") {
            Write-Output "Setting read-only permission on: $($dir.FullName)"
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup1
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup2
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup3
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup4
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup5
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup6
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup7
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup8
        }
    }
}

# Start the recursive search
Search-And-SetPermission -currentFolder $rootFolder
 
