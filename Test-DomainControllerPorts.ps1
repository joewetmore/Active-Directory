 function tcpt ([string]$serv, [string]$p) {

 $result = $false

 try {

  $conn = new-object system.net.sockets.tcpclient($serv,$p)

  if ($conn.connected) { $result = $true } else { result = $false }

  $conn.close() 

 } catch {

  $result = $false

 }

 $conn = $null

 return $result

}

#in the test-domainControllerPorts function, the -DomainController parameter can be specified to allow this to work for non-domain joined systems, or to point to domain controllers in other domains

#

function test-DomainControllerPorts {

 param (

  $domainname = (gwmi win32_computersystem).domain,

$domaincontroller = ((nltest /sc_query:$domainname |  where {$_ -match "Trusted DC Name"}).split("\\") |  where {$_ -match $domainname})



 )

 $secureChanneldc = $domaincontroller.trim()

 $functionalports = @()

 $nonFunctionalPorts = @()

 $portsToCheck = ("53", "88", "137", "139", "389", "445", "464", "3268", "636", "3269")

 foreach ($port in $portsToCheck) {

  $portstat = tcpt $secureChannelDC $port

  if ($portstat) {

   $functionalports += $port

  } else {

   $nonfunctionalPorts += $port

  }

 }

 $result = new-object PSObject

 add-member -inp $result NoteProperty DomainController $secureChannelDC

 add-member -inp $result NoteProperty OpenPorts $functionalports

 add-member -inp $result NoteProperty UnOpenPorts $nonfunctionalports

 out-default -inp $result

} 
