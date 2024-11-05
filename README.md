# arc-windowsattest
Software Assurance Attestation for Azure Arc Windows Servers


 The script uses the  query.kusto  file to get the list of Arc-enabled servers that are eligible for Software Assurance. The script then attests the servers by setting the  softwareAssuranceCustomer  property to  true . 
 The  Set-Attestation  function is used to attest the servers. The function takes the subscription ID, resource group name, machine name, and location as parameters. The function then sends a PUT request to the  /Microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default  endpoint to attest the server. 
 The script then loops through the list of servers and attests each server by calling the  Set-Attestation  function. 
 Run the script 
 To run the script, open a PowerShell window and run the following command: 
 .\attestArcServers.ps1
 
 The script will get the list of Arc-enabled servers that are eligible for Software Assurance and attest the servers by setting the  softwareAssuranceCustomer  property to  true . 
 Summary 
 In this article, you learned how to attest Arc-enabled servers for Software Assurance using PowerShell. You created a script that gets the list of Arc-enabled servers that are eligible for Software Assurance and attests the servers by setting the  softwareAssuranceCustomer  property to  true . 
 The script uses the  query.kusto  file to get the list of Arc-enabled servers that are eligible for Software Assurance. The script then attests the servers by setting the  softwareAssuranceCustomer  property to  true . 
 The  Set-Attestation  function is used to attest the servers. The function takes the subscription ID, resource group name, machine name, and location as parameters. The function then sends a PUT request to the  /Microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default  endpoint to attest the server. 
 The script then loops through the list of servers and attests each server by calling the  Set-Attestation  function. 
 I hope this article will help you to attest Arc-enabled servers for Software Assurance using PowerShell. 
 The post  How to attest Arc-enabled servers for Software Assurance using PowerShell appeared firstjson appeared first on  Techcoil Blog. 
]]>