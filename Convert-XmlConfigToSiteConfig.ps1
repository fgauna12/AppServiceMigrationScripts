function Convert-XmlConfigToSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [xml]
        $XmlConfig
    )

    $appSettings = [System.Text.StringBuilder]::new()
    foreach ($appSetting in $XmlConfig.configuration.appSettings.add){
        
        # Capitalize first letter
        $key = $appSetting.key.substring(0,1).ToUpper() + $appSetting.key.substring(1)

        $appSetting = @"
{
    "name": "$($appSetting.key)",
    "value": "[parameters('config$($key)')]"
},
"@
        [void]$appSettings.AppendLine($appSetting)
    }

    Write-Output $appSettings.ToString()
}
