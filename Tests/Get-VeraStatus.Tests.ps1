$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Get-VeraStatus" {

    Mock Invoke-VeraAPI -ModuleName PSVera -MockWith {
        #Didn't come up with way to pass testdir to module scope mock
        [xml](Get-Content -Raw "C:\Users\Kristoffer\Onedrive\PSVera\Tests\TestData\AllDeviceData.xml")
    }

    Mock Invoke-VeraAPI -ModuleName PSVera -ParameterFilter {
        $DeviceNum -and $DeviceNum -eq 26
    } -MockWith {
        #Didn't come up with way to pass testdir to module scope mock
        [xml](Get-Content -Raw "C:\Users\Kristoffer\Onedrive\PSVera\Tests\TestData\PhilipsHueStatusData.xml")
    }

    It "Get all status" {
        Get-VeraStatus
        Assert-MockCalled -CommandName Invoke-VeraAPI -Times 1 -Exactly -ModuleName PSVera
    }

    It "Get one status" {
        Get-VeraStatus -DeviceNum 26
        Assert-MockCalled -CommandName Invoke-VeraAPI -Times 1 -Exactly -ModuleName PSVera  {
            $DeviceNum -and $DeviceNum -eq 26
        }
    }
}
