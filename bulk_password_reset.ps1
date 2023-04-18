# Load the Active Directory module
Import-Module ActiveDirectory

 

# Define the path and name for the CSV file
$csvFile = "C:\ResetUsers.csv"

 

# Define the distinguished name of the OU where you want to reset user passwords
$ouDN = "OU=TestOU,DC=example,DC=com"

 

# Get all active user accounts from the specified OU
$users = Get-ADUser -Filter {Enabled -eq $true} -SearchBase $ouDN -Properties *

 

# Create an array to store the list of users and their new passwords
$newUsers = @()

 

# Create a password generator function
function Generate-Password {
    $length = 12
    $alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-="
    $password = -join ($alphabet.ToCharArray() | Get-Random -Count $length)
    return $password
    }

    # Loop through each user in the specified OU and generate a random password
    foreach ($user in $users) {
        $newPassword = Generate-Password

        # Set the new password for the user
         Set-ADAccountPassword -Identity $user -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force) -Reset

        # Set the PasswordNeverExpires flag to false and the ChangePasswordAtLogon flag to true
        Set-ADUser -Identity $user -PasswordNeverExpires $false -ChangePasswordAtLogon $true

        # Add the user and their new password to the array
        $newUsers += [PSCustomObject]@{
            Name = $user.Name
            SamAccountName = $user.SamAccountName
            Password = $newPassword
        }
    }

    # Export the list of users and their new passwords to a CSV file
    $newUsers | Export-Csv $csvFile -NoTypeInformation
