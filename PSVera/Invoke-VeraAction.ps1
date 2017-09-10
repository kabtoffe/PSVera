function Invoke-VeraAction {

    param(
        $DeviceNum,
        $ActionName,
        $ServiceId,
        [hashtable]$ActionParameters = @{}
    )

    Invoke-VeraAPI `
    -ID "action" `
    -DeviceNum $DeviceNum `
    -ServiceId $ServiceId `
    -Action $ActionName `
    -AdditionalParameters $ActionParameters
}
