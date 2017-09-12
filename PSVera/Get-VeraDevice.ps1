function Get-VeraDevice {

    param(
        [switch]$HasSwitch,
        [switch]$HasDimmer,
        [string]$HasService
    )

    if ($PSBoundParameters.Keys.Count -eq 0 -or $HasService){
        $response = Invoke-VeraAPI -ID "device"
        $devices = $response.root.device.deviceList.device.devicelist.device    
        if ($HasService){
            $devices  | Where-Object {
                Test-VeraService -Device $_ -ServiceId $HasService
            }
        }
        else {
            $devices
        }
    }

    if ($HasSwitch){
        Get-VeraDevice -HasService $SwitchServiceId     
    }

    if ($HasDimmer){
        Get-VeraDevice -HasService $DimmingServiceId    
    }
}
