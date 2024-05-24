 # Define the root folder to start the search
$rootFolder = "C:\PermissionTest"

# Define the security group
$securityGroup = "ETHER\Household"


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
            Set-ReadOnlyPermission -folderPath $dir.FullName -securityGroup $securityGroup
        }
    }
}

# Start the recursive search
Search-And-SetPermission -currentFolder $rootFolder
 
