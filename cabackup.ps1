# Run this as a scheduled task on each Certificate Authority Server
#    How to run powershell scripts from task scheduler
#    https://community.spiceworks.com/how_to/17736-run-powershell-scripts-from-task-scheduler


# Set these variables for your environment. Set CAName on each Certificate Authority Server. 

# Name of this certification authority
$CAname = "MYCASERVER"

# Email address that will receive alerts
$AlertRecip = "josephwetmore@mydomain.com"

# Your SMTP server
$SMTPserver = "smtp.mydomain.com"

# File server path for CA backups
$path = "\\MYFILESERVER\CABackup\$CAName" 


$Date = (Get-Date).ToString("dd-MM-yy hh-mm-ss") 
Mkdir $path\$Date 
$backup = Join-Path $path -ChildPath $date 
Certutil.exe –template > "$backup\templates.txt" 
reg export HKLM\System\CurrentControlSet\Services\CertSvc\Configuration $backup\CAregistery.txt 
Copy-Item "c:\windows\capolicy.inf" -Destination $backup
certutil.exe -backup -p p@ssw0rd  $backup  
$backup1 = Join-Path $path -ChildPath $date\database  


# Uncomment this section to enable email alerts

# if (Test-Path -Path $backup1\"$CAName-CA.edb"){ 
# $subject="Backup is Completed Sucessfully on $CAname" 
# $body="Backup is Completed Sucessfully on $CAname" 
 
# } 
# else 
# { 
# $subject="CA $CAName backup failed. Please check and do run it again" 
# $body="CA $CAName backup failed. Please check and do run it again" 
# } 
 
# Send-MailMessage -From Alerts@mydomain.com -To $AlertRecip
#  -Subject $subject -Body $body -SmtpServer $SMTPserver
# Del $path\$OldDate -Recurse -Force -ErrorAction Continue 
