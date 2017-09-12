$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force


Describe "Get-VeraDevice" {

    Connect-Vera -VeraHost "hostname"

    Mock Invoke-RestMethod -ModuleName PSVera {
        #Didn't come up with way to pass testdir to module scope mock
        [xml](Get-Content -Raw "C:\Users\Kristoffer\Onedrive\PSVera\Tests\TestData\AllDeviceData.xml")
    }

    
    It "When provided with no device id get all devices" {
            $Result = Get-VeraDevice
            $Result.Count | should be 32
    }

    It "When provided with swich HasSwitch get all devices that can be switched"{
        $Result = Get-VeraDevice -HasSwitch
        $Result.Count | Should Be 24
    }

    It "When provided with a service get all devices that can be switched"{
        $Result = Get-VeraDevice -HasService "urn:upnp-org:serviceId:SwitchPower1"
        $Result.Count | Should Be 24
    }

    It "When provided with switch HasDimmer get all devices that have Dimmer"{
        $Result = Get-VeraDevice -HasDimmer
        $Result.Count | Should Be 20
    }

}
