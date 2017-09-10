$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Get-VeraVariable" {

    Context "Dealing with status" {
        
        #Let's use real Vera for this
        Connect-Vera "192.168.1.188"

    
        It "Gets a variable" {
            $result = Get-VeraVariable -DeviceNum 26 -ServiceId "urn:micasaverde-com:serviceId:PhilipsHue1" -VariableName "BulbModelID"
            $result | Should Be "LCT010"
        }

    }   
}
