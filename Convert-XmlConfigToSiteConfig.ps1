function Convert-XmlConfigToSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [xml]
        $XmlConfig
    )

    $appSettings = [System.Text.StringBuilder]::new()
    foreach ($appSetting in $XmlConfig.configuration.appSettings.add){
        $appSetting = @"
{
    "name": "$($appSetting.key)",
    "value": "[parameters('config$($appSetting.key)')]"
},
"@
        [void]$appSettings.AppendLine($appSetting)
    }

    Write-Output $appSettings.ToString()
}
