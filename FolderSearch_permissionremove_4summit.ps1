 # Define the root folder to start the search
$rootFolder = "C:\PermissionTest"

# Define the security group to remove
$securityGroup = "ETHER\Wendy"

# Function to remove permissions for the specified security group
function Remove-Permission {
    param (
        [string]$folderPath,
        [string]$securityGroup
    )
    
    # Get the current ACL (Access Control List) for the folder
    $acl = Get-Acl $folderPath
    
    # Find all access rules for the specified security group
    $accessRules = $acl.Access | Where-Object { $_.IdentityReference -eq $securityGroup }
    
    # Remove each access rule for the specified security group
    foreach ($rule in $accessRules) {
        $acl.RemoveAccessRule($rule)
    }
    
    # Set the updated ACL for the folder
    Set-Acl $folderPath $acl
}

# Function to recursively search for directories named "Sensitive Data"
function Search-And-RemovePermission {
    param (
        [string]$currentFolder
    )
    
    # Get all directories in the current folder
    $directories = Get-ChildItem -Path $currentFolder -Directory -Recurse -Force
    
    foreach ($dir in $directories) {
        # Check if the directory name is "Sensitive Data"
        if ($dir.Name -eq "Sensitive Data") {
            Write-Output "Removing permission for $securityGroup on: $($dir.FullName)"
            Remove-Permission -folderPath $dir.FullName -securityGroup $securityGroup
        }
    }
}

# Start the recursive search
Search-And-RemovePermission -currentFolder $rootFolder
 
