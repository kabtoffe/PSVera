function Get-VeraRoom {

    param(
        $Id,

        $Name
    )

    $userdata = Invoke-VeraApi -id "user_data"
    $rooms = $userdata.root.rooms.room
    if ($Id){
        $rooms = $rooms | Where-Object { $_.id -eq $Id}
    }

    if ($Name){
        $rooms = $rooms | Where-Object { $_.name -eq $Name}
    }

    $rooms
}
