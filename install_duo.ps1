#!ps
#timeout=9000000
#maxlength=9000000
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; curl https://dl.duosecurity.com/duo-win-login-latest.exe -o C:\temp\duo-win-login-latest.exe ; C:\temp\duo-win-login-latest.exe /S /V" /qn IKEY="########" SKEY="#######" HOST="########.duosecurity.com" AUTOPUSH="#1" FAILOPEN="#0""


[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; curl https://dl.duosecurity.com/duo-win-login-latest.exe -o C:\temp\duo-win-login-latest.exe ; C:\temp\duo-win-login-latest.exe /S /V" /qn IKEY="########" SKEY="#######" HOST="########.duosecurity.com" AUTOPUSH="#1" FAILOPEN="#1""
