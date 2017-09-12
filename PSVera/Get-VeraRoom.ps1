function Get-VeraRoom {

    param(
        $RoomId,

        $Name
    )

    $userdata = Invoke-VeraApi -id "user_data"
    $rooms = $userdata.root.rooms.room
    if ($RoomId){
        $rooms = $rooms | Where-Object { $_.id -eq $RoomId}
    }

    if ($Name){
        $rooms = $rooms | Where-Object { $_.name -eq $Name}
    }

    $rooms | Select-Object @{
        N = "RoomId"
        E = {$_.id}
    },name
}
