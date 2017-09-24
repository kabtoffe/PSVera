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
            $Result.Count | should be 82
    }

    It "When provided with swich HasSwitch get all devices that can be switched"{
        $Result = Get-VeraDevice -HasSwitch
        $Result.Count | Should Be 25
    }

    It "When provided with a service get all devices that can be switched"{
        $Result = Get-VeraDevice -HasService "urn:upnp-org:serviceId:SwitchPower1"
        $Result.Count | Should Be 25
    }

    It "When provided with switch HasDimmer get all devices that have Dimmer"{
        $Result = Get-VeraDevice -HasDimmer
        $Result.Count | Should Be 20
    }

    It "When provided with switch IsTemperatureSensor" {
        $Result = Get-VeraDevice -IsTemperatureSensor
        $Result.Count | Should Be 7
    }

    It "Using category number" {
        $result = Get-VeraDevice -CategoryNum 17
        $result.Count | Should Be 6 #Virtual temp doesn't honor category
    }

    It "Using subcategory without category should throw"{
        { Get-VeraDevice -SubCategoryNum 17 } | Should throw
    }

    It "Using category and subcategory number (motion sensors)" {
        $result = Get-VeraDevice -CategoryNum 4 -SubCategoryNum 3
        $result.Count | Should Be 6
    }

    It "Using wrong category should throw" {
        { Get-VeraDevice -Category "Happiness Sensor" } | Should throw
    }

    It "Using category Security Sensor" {
        $result = Get-VeraDevice -Category "Security Sensor"
        $result.Count | Should Be 6
    }

}
