
param(
    [string]$subscriptionId,
    [string]$tenantId
)

#Kusto query for the Arc Enabled Servers eligible for Software Assurance
$query = Get-Content .\query.kusto


$account       = Connect-AzAccount -Subscription $subscriptionId -Tenant $tenantId
$context       = Set-azContext -Subscription $subscriptionId 
$profile       = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile 
$profileClient = [Microsoft.Azure.Commands.ResourceManager.Common.rmProfileClient]::new( $profile ) 
$token         = $profileClient.AcquireAccessToken($context.Subscription.TenantId) 
$header = @{ 
   'Content-Type'='application/json' 
   'Authorization'='Bearer ' + $token.AccessToken 
}

#Get the Arc Enabled Servers eligible for Software Assurance
$graphuri = [System.Uri]::new( "https://management.azure.com/providers/Microsoft.ResourceGraph/resources?api-version=2022-10-01" )
$contentType = "application/json"  
$data = @{         
    query = "$query"
}; 
$queryjson = $data | ConvertTo-Json; 
$graphResponse = Invoke-RestMethod -Method Post -Uri $graphuri.AbsoluteUri -ContentType $contentType -Headers $header -Body $queryjson; 


#Set the Software Assurance attestation for the Arc Enabled Servers
function Set-Attestation {
    param (
        [string]$subscriptionId,
        [string]$resourceGroupName,
        [string]$machineName,
        [string]$location
        )
    
    try {
        $uri = [System.Uri]::new( "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.HybridCompute/machines/$machineName/licenseProfiles/default?api-version=2023-10-03-preview" ) 
        $contentType = "application/json"
        $data = @{         
            location = $location; 
            properties = @{ 
                softwareAssurance = @{ 
                    softwareAssuranceCustomer= $true; 
                }; 
            }; 
        };  
        $json = $data | ConvertTo-Json; 
        $response = Invoke-RestMethod -Method PUT -Uri $uri.AbsoluteUri -ContentType $contentType -Headers $header -Body $json; 
        $response.properties

    }
    catch {
        "$machineName $_" | Out-File -FilePath .\output.txt -Append
    }

}

#Loop through the Arc Enabled Servers and set the Software Assurance attestation
$counter = 0

$graphResponse.data | ForEach-Object {
    $counter++
        
    Set-Attestation -subscriptionId $_.subscriptionId -resourceGroupName $_.resourceGroup -machineName $_.name -location $_.location
    Write-Progress -Activity "Setting Software Assurance attestation for Arc Enabled Servers" -Status "Processing $_.name" -PercentComplete ($counter / $graphResponse.data.Count * 100)
}


