$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Test-VeraService" {

    Mock Invoke-VeraAPI -ModuleName PSVera

    It "Gets temperature" {
        Get-VeraTemperature -DeviceNum 4

        Assert-MockCalled -CommandName Invoke-VeraAPI -Scope It -ModuleName PSVera -ParameterFilter {
            $DeviceNum -and $DeviceNum -eq 4 -and
            $Id -eq "variableget" -and
            $ServiceId -eq "urn:upnp-org:serviceId:TemperatureSensor1" -and
            $AdditionalParameters -and $AdditionalParameters.ContainsKey("Variable") -and
            $AdditionalParameters["Variable"] -eq "CurrentTemperature"
        }

    }
}
