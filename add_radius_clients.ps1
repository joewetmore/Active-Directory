 Import-Csv "c:\scripts\rad_client_list.csv" | Foreach-Object
 {
     $DeviceName = $_."Name"
     $IPAddress = $_."IP"
     $SecretPass = $_."SecretKey"
     New-NpsRadiusClient -Address $IPAddress -Name $DeviceName -SharedSecret $SecretPass -VendorName "RADIUS Standard" -AuthAttributeRequired $True
 }
 
 
 
 # CSV sample
 Name,IP,SecretKey
 WAP114,10.10.255.82,ocmaradiusss
 WAP115,10.10.255.83,ocmaradiusss
 
 # REF https://learn.microsoft.com/en-us/answers/questions/358638/how-to-add-bulk-radius-client-in-nps-using-powersh.html
 
 
 
