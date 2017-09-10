function Get-VeraVariable {
    param(
        $DeviceNum,

        $ServiceId,

        $VariableName
    )

    Invoke-VeraAPI -id "variableget" -DeviceNum $DeviceNum -serviceId $ServiceId -AdditionalParameters @{
        "Variable" = $VariableName
    }

}
