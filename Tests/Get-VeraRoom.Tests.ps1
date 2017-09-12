$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$testdir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force
Describe "Get-VeraRoom" {
    
    Mock Invoke-RestMethod -ModuleName PSVera {
        #Didn't come up with way to pass testdir to module scope mock
        [xml](Get-Content -Raw "C:\Users\Kristoffer\Onedrive\PSVera\Tests\TestData\User_Data.xml")
    }

    Connect-Vera "hostname"
    
    It "If no parameters get all rooms" {
        $rooms = Get-VeraRoom
        $rooms.Count | Should Be 14
    }

    It "If provided with id return that room"{
        $room = Get-VeraRoom -RoomId 3
        $room.name | Should Be "Vintti"
    }

    It "If provided with name return that room"{
        $room = Get-VeraRoom -Name "Vintti"
        $room.RoomId | Should Be 3
    }

}
