$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$here = (Get-Item "$here\..\PSVera").FullName
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"
. "$here\Connect-Vera.ps1"

Describe "Get-VeraDevice" {

    Connect-Vera -VeraHost "hostname"
    $xml = [xml](Get-Content -Raw "$testdir\TestData\AllDeviceData.xml")

    Mock Invoke-RestMethod {
        $xml
    }

    
    It "When provided with no device id get all devices" {
            $Result = Get-VeraDevice
            $Result.Count | should be 32
    }

    It "When provided with swich HasSwitch get all devices that can be switched"{
        $Result = Get-VeraDevice -HasSwitch
        $Result.Count | Should Be 24
    }

}
