function Get-VeraStatus {
    param(
        $DeviceNum
    )

    $parameters = @{
        "id" = "status"
    }

    $parameters += $PSBoundParameters

    $result = (Invoke-VeraAPI @parameters).root

    if ($DeviceNum -ne $null){
        $Attribute = "Device_Num_$DeviceNum"
        $result = $result.$Attribute
    }

    $result

}
