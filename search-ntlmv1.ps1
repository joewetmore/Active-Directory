# Collect NTLMv1 authentication events and extract unique clients
$Events = Get-WinEvent -LogName Security -FilterXPath `
   "Event[System[(EventID=4624)]] and Event[EventData[Data[@Name='LmPackageName']='NTLM V1']]" |
   Select-Object @{
       Name='Time';Expression={$_.TimeCreated.ToString('g')}
   }, @{
       Name='UserName';Expression={$_.Properties[5].Value}
   }, @{
       Name='WorkstationName';Expression={$_.Properties[11].Value}
   } |
   Sort-Object WorkstationName -Unique
# Export results to CSV
$Events | Export-Csv -NoTypeInformation -Path ".\NTLMv1_UniqueClients.csv"
Write-Host "NTLMv1 unique client list saved to NTLMv1_UniqueClients.csv"
