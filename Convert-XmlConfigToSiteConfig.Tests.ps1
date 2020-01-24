$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Convert-XmlConfigToSiteConfig" {
    It "Converts app setting with PasCal Case to App Service app setting" {
        $doc = [xml]@'
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <appSettings>
        <!--Website-->
        <add key="SitePath" value="http://google.com" />
        <add key="WebSiteBase" value="dev" />
        <add key="dev_or_prod" value="dev" />
        <add key="Config" value="Dev" />
    </appSettings>
</configuration>
'@

        $output = $doc | Convert-XmlConfigToSiteConfig
        
        
        $output | Should MatchExactly 'SitePath'
        $output | Should MatchExactly 'configSitePath'
        
    }

    It "Converts app setting with Camel Case to App Service app setting" {
        $doc = [xml]@'
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <appSettings>
        <!--Website-->
        <add key="SitePath" value="http://google.com" />
        <add key="WebSiteBase" value="dev" />
        <add key="email" value="hello@google.com" />
        <add key="dev_or_prod" value="dev" />
        <add key="Config" value="Dev" />
    </appSettings>
</configuration>
'@

        $output = $doc | Convert-XmlConfigToSiteConfig
        
        
        $output | Should MatchExactly 'email'
        $output | Should MatchExactly 'configEmail'
        
    }
}
