$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Invoke-VeraAction" {

    Connect-Vera "hostname"

    . "$testdir\Mocks\Invoke-Restmethod.ps1"

    It "Calls with id action" {
        $parameters = Invoke-VeraAction
        $parameters["id"] | Should Be "action"
    }

    It "Action name provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo"
        $parameters["id"] | Should Be "action"
        $parameters["action"] | Should Be "Foo"
    }

    It "Action name and service provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId"
        $parameters["id"] | Should Be "action"
        $parameters["action"] | Should Be "Foo"
        $parameters["serviceid"] | Should Be "AServiceId"
    }

    It "Action name, devicenum and service provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId" -DeviceNum 6
        $parameters["id"] | Should Be "action"
        $parameters["action"] | Should Be "Foo"
        $parameters["serviceid"] | Should Be "AServiceId"
        $parameters["DeviceNum"] | Should Be 6
    }

    It "Action parameters provided" {
        $parameters = Invoke-VeraAction -ActionName "Foo" -ServiceId "AServiceId" -DeviceNum 6 -ActionParameters @{
            "NewValue" = 3
        }
        $parameters["id"] | Should Be "action"
        $parameters["action"] | Should Be "Foo"
        $parameters["serviceid"] | Should Be "AServiceId"
        $parameters["DeviceNum"] | Should Be 6
        $parameters["NewValue"] | Should Be 3
    }
}
