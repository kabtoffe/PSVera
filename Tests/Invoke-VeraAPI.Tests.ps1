$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$ModuleDir\PSVera.psm1" -Force


Describe "Invoke-VeraAPI" {

    Connect-Vera -VeraHost "hostname"

    Mock Invoke-RestMethod -ModuleName PSVera

    It "No parameters provided" {
        $parameters = Invoke-VeraAPI
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().EndsWith("output_format=xml")
        }
    }

    It "ID parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state"
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().Contains("id=state") -and
            $Uri.ToString().EndsWith("output_format=xml")
        }
    }

    It "ID and action parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state" -Action "rename"
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().Contains("id=state") -and
            $Uri.ToString().Contains("action=rename") -and
            $Uri.ToString().EndsWith("output_format=xml")
        }
    }

    It "ID, action and devicenum parameter provided" {
        $parameters = Invoke-VeraAPI -ID "state" -Action "rename" -DeviceNum 4
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().Contains("id=state") -and
            $Uri.ToString().Contains("action=rename") -and
            $Uri.ToString().Contains("DeviceNum=4") -and
            $Uri.ToString().EndsWith("output_format=xml")
        }
    }

    It "When provided with other output format" {
        $parameters = Invoke-VeraAPI -OutputFormat "json"
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().EndsWith("output_format=json")
        }
    }

    It "When provided with additional parameters" {
        $parameters = Invoke-VeraAPI -id "action" -AdditionalParameters @{ "foo" = "bar"  }
        Assert-MockCalled -CommandName Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
            $Uri.ToString().StartsWith("http://hostname:3480/data_request") -and
            $Uri.ToString().Contains("?id=action&") -and
            $Uri.ToString().Contains("foo=bar") -and
            $Uri.ToString().EndsWith("output_format=xml")
        }
    }
}
