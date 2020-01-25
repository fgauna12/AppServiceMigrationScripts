function Convert-XmlConfigToSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [xml]
        $XmlConfig
    )

    $appSettings = [System.Text.StringBuilder]::new()
    $armTemplateParams = [System.Text.StringBuilder]::new()
    $pipelineOverrides = [System.Text.StringBuilder]::new()
    $configMap = @()
    foreach ($appSetting in $XmlConfig.configuration.appSettings.add){
        
        # Capitalize first letter
        $key = $appSetting.key.substring(0,1).ToUpper() + $appSetting.key.substring(1)

        $armTemplateParamName = "config$key"
        $armTemplateParam = @"
    `"$armTemplateParamName`": {
        "type": "string"
    },
"@
        $pipelineOverride = "-config$($key) `$(Config.$key`)"
        $configMap +=  [PSCustomObject]@{
            Name = "Config.$key"
            Value = $appSetting.value
        }
        $appSetting = @"
{
    "name": "$($appSetting.key)",
    "value": "[parameters('$armTemplateParamName')]"
},
"@
        [void]$appSettings.AppendLine($appSetting)
        [void]$armTemplateParams.AppendLine($armTemplateParam)
        [void]$pipelineOverrides.AppendLine($pipelineOverride)
    }

    [PSCustomObject]@{
        ArmTemplateAppSettings = $appSettings.ToString()
        ArmTemplateParams = $armTemplateParams.ToString()
        PipelineOverrides = $pipelineOverrides.ToString()
        ConfigMap = $configMap
    }
}
