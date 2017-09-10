$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$here = (Get-Item "$here\..\PSVera").FullName
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Connect-Vera" {
    It "Changing host works" {
        $script:VeraHost | Should Be $null
        Connect-Vera "192.168.1.188"
        $script:VeraHost | Should Be "192.168.1.188"
    }
}
