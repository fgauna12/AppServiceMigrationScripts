$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Convert-XmlConfigToSiteConfig" {
    It "Converts to app service app settings" {
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

        $doc | Convert-XmlConfigToSiteConfig
        
    }
}
