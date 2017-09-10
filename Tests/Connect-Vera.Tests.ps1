$moduledir = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduledir = (Get-Item "$moduledir\..\PSVera").FullName

Import-Module "$moduledir\PSVera.psm1" -Force

InModuleScope PSVera { 
    Describe "Connect-Vera" {
        It "Changing host works" {
            $script:VeraHost | Should Be $null
            Connect-Vera "192.168.1.188"
            $script:VeraHost | Should Be "192.168.1.188"
        }
    }
}
