$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Test-VeraService" {

    $SwitchDevice = ([xml](Get-Content -Raw "$testdir\TestData\SwitchDevice.xml")).device

    It "Device has Switch service" {
        Test-VeraService -Device $SwitchDevice -ServiceId "urn:upnp-org:serviceId:SwitchPower1" | Should Be $true
    }

    It "Device doesn't have Dimmer service" {
        Test-VeraService -Device $SwitchDevice -ServiceId "urn:upnp-org:serviceId:Dimmer1" | Should Be $false
    }
}
