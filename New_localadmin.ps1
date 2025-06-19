# Define variables
$Username = "LocalAdminUser"
$Password = "P@ssw0rd123!"  # Change this to a secure password
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Check if the user already exists
if (-not (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue)) {
    # Create the local user account
    New-LocalUser -Name $Username -Password $SecurePassword -FullName "Local Administrator Account" -Description "Local admin account created via script" -PasswordNeverExpires -AccountNeverExpires

    Write-Output "User '$Username' created successfully."
} else {
    Write-Output "User '$Username' already exists."
}

# Add the user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $Username

Write-Output "User '$Username' added to the Administrators group."
