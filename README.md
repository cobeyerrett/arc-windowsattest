# Software Assurance Attestation for Azure Arc Windows Servers

## Description



<p>The script uses the  query.kusto  file to get the list of Arc-enabled servers that are eligible for Software Assurance. The script then attests the servers by setting the  softwareAssuranceCustomer  property to  true . It is based on the sciprt published on *[Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-arc/servers/windows-server-management-overview?branch=main&branchFallbackFrom=pr-en-us-216&tabs=powershell#enrollment) . </p>
 
<p>The  *Set-Attestation*  function is used to attest the servers. The function takes the subscription ID, resource group name, machine name, and location as parameters. The function then sends a PUT request to the  Azure Arc API endpoint to attest the server.</p> 

<p>The script will get the list of Arc-enabled servers that are eligible for Software Assurance and attest the servers by setting the  softwareAssuranceCustomer  property to  true . </p>

##Prerequisites


## Running the script 
 
<p>To run the script, open a Powershell (Ideally from CloudShell) window and run the following command:</p> 

- git clone https://github.com/cobeyerrett/arc-windowsattest.git
 
<p>.\arc-windowsattest\attestArcServers.ps1 -subscriptionId YOUR_SUBID -tenantId YOUR_TENANTID</p> 
 
## Resources

## Navigating the source code

This project has the following structure:

File/Folder | Description
---|---
attestservers.ps1 | Main powershell file to attest the Windows Software Assurance for Azure Arc connected machines
query.kusto | The kusto (KQL) query to obtain the Arc-enabled Windows servers to attest 
