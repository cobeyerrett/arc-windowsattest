# Software Assurance Attestation for Azure Arc Windows Servers


 The script uses the  query.kusto  file to get the list of Arc-enabled servers that are eligible for Software Assurance. The script then attests the servers by setting the  softwareAssuranceCustomer  property to  true . 
 
 The  Set-Attestation  function is used to attest the servers. The function takes the subscription ID, resource group name, machine name, and location as parameters. The function then sends a PUT request to the  Azure Arc API endpoint to attest the server. 
 
 
 To run the script, open a PowerShell window and run the following command: 
 .\attestArcServers.ps1
 
 The script will get the list of Arc-enabled servers that are eligible for Software Assurance and attest the servers by setting the  softwareAssuranceCustomer  property to  true . 
