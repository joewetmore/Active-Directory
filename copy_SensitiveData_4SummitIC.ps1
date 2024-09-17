# Define the root paths
$sourceRoot = "\\aapcbhvfs\AADataPROD\Quotes"
$destinationRoot = "\\denfas01\denshare02\AADataPROD\Quotes"

# Get all directories under the source root
$quoteDirectories = Get-ChildItem -Path $sourceRoot -Directory

Start-Transcript

# Loop through each quote directory
foreach ($quoteDir in $quoteDirectories) {
    $quoteNumber = $quoteDir.Name

    # Define the path to the "SensitiveData" folder for this quote
    $sensitiveDataPath = Join-Path -Path "$sourceRoot\$quoteNumber\$quoteNumber - Finalized" -ChildPath "SensitiveData"

    # Check if the "SensitiveData" folder exists
    if (Test-Path -Path $sensitiveDataPath) {

        # Define the destination path for the copied folder
        $destinationPath = Join-Path -Path "$destinationRoot\$quoteNumber\$quoteNumber - Finalized\SensitiveData" -ChildPath "newcopy"

        # Create the destination folder if it doesn't exist
        if (-not (Test-Path -Path $destinationPath)) {
            New-Item -ItemType Directory -Path $destinationPath
        }

        # Copy the "SensitiveData" folder and its contents to the destination
        Copy-Item -Path $sensitiveDataPath -Destination $destinationPath -Recurse -Force

        Write-Host "Copied SensitiveData for Quote Number $quoteNumber to the new location."
    }
    else {
        Write-Host "SensitiveData folder not found for Quote Number $quoteNumber."
    }
}

Stop-Transcript
