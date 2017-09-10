$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force


Describe "Invoke-VeraAPI" {

    Connect-Vera -VeraHost "hostname"

    Mock Invoke-RestMethod -ModuleName PSVera {
        $Split = $Uri.ToString().Split("?")
        $Data = @{
            "Hostname" = $Split[0]
        }
        $Split[1].Split("&") | ForEach-Object {
            $Parameter = $_.Split("=")
            $Data.Add($Parameter[0],$Parameter[1])
        }
        $Data
    }

    It "No parameters provided" {
        $parameters = Invoke-VeraAPI
        $parameters["Hostname"] | Should Be "http://hostname:3480/data_request"
        $parameters["output_format"] | should be "xml"
    }

    It "ID parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state"
        $parameters["output_format"] | should be "xml"
        $parameters["id"] | Should Be "state"
    }

    It "ID and action parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state" -Action "rename"
        $parameters["output_format"] | should be "xml"
        $parameters["id"] | Should Be "state"
        $parameters["action"] | Should Be "rename"
    }

    It "ID, action and devicenum parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state" -Action "rename" -DeviceNum 4
        $parameters["output_format"] | should be "xml"
        $parameters["id"] | Should Be "state"
        $parameters["action"] | Should Be "rename"
        $parameters["DeviceNum"] | Should Be "4"
    }

    It "When provided with other output format" {
        $parameters = Invoke-VeraAPI -OutputFormat "json"
        $parameters["output_format"] | should be "json"
    }
}
