$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Invoke-VeraAction" {

    Connect-Vera "hostname"

    Mock Invoke-VeraAPI -ModuleName PSVera

    It "Calls with id action" {
        $parameters = Invoke-VeraAction
        Assert-MockCalled -CommandName Invoke-VeraAPI -ModuleName PSVera -Scope It -ParameterFilter {
            $Id -and $Id -eq "action"
        }
    }

    It "Action name provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo"
        Assert-MockCalled -CommandName Invoke-VeraAPI -ModuleName PSVera -Scope It -ParameterFilter {
            $Id -and $Id -eq "action" -and
            $action -and $Action -eq "foo"
        }
    }

    It "Action name and service provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId"
        Assert-MockCalled -CommandName Invoke-VeraAPI -ModuleName PSVera -Scope It -ParameterFilter {
            $Id -and $Id -eq "action" -and
            $action -and $Action -eq "foo" -and
            $serviceid -and $serviceid -eq "AServiceId"
        }
    }

    It "Action name, devicenum and service provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId" -DeviceNum 6
        Assert-MockCalled -CommandName Invoke-VeraAPI -ModuleName PSVera -Scope It -ParameterFilter {
            $Id -and $Id -eq "action" -and
            $action -and $Action -eq "foo" -and
            $serviceid -and $serviceid -eq "AServiceId" -and
            $DeviceNum -and $DeviceNum -eq 6
        }

    }

    It "Action parameters provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId" -DeviceNum 6 -ActionParameters @{
            "NewValue" = 3
        }
        Assert-MockCalled -CommandName Invoke-VeraAPI -ModuleName PSVera -Scope It -ParameterFilter {
            $Id -and $Id -eq "action" -and
            $action -and $Action -eq "foo" -and
            $serviceid -and $serviceid -eq "AServiceId" -and
            $DeviceNum -and $DeviceNum -eq 6 -and
            $AdditionalParameters -and $AdditionalParameters.ContainsKey("NewValue") -and
            $AdditionalParameters["NewValue"] -eq 3
        }
    }
}
