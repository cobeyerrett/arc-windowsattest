$subscriptionId    = 'fca3f21e-c534-44b3-a686-662d24006af9' #Your subscription id 
$resourceGroupName = 'arc-rg' # your Resource Group 
$machineName       = 'ArcBox-Win2K19' # Arc resource name 
$location = "canadacentral" # The region where the test machine is arc enabled.

$account       = Connect-AzAccount 
$context       = Set-azContext -Subscription $subscriptionId 
$profile       = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile 
$profileClient = [Microsoft.Azure.Commands.ResourceManager.Common.rmProfileClient]::new( $profile ) 
$token         = $profileClient.AcquireAccessToken($context.Subscription.TenantId) 
$header = @{ 
   'Content-Type'='application/json' 
   'Authorization'='Bearer ' + $token.AccessToken 
}

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