function Convert-XmlConfigToSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [xml]
        $XmlConfig
    )

    foreach ($appSetting in $XmlConfig.configuration.appSettings.add){
#         $segment = @"
# {
#     "name": "SitePath",
#     "value": "[parameters('configSitePath')]"
# },
# "@      
        Write-Host "app setting key $($appSetting.key)"
        Write-Host "app setting key $($appSetting.value)"
    }

    


}
