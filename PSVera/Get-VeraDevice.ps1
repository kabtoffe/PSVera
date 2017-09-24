function Get-VeraDevice {

    param(
        [switch]$HasSwitch,
        [switch]$HasDimmer,
        [switch]$IsTemperatureSensor,
        [string]$HasService
    )

    if ($PSBoundParameters.Keys.Count -eq 0 -or $HasService){
        $response = Invoke-VeraAPI -ID "device"
        $devices = $response.GetElementsByTagName("device")    
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

    if ($IsTemperatureSensor){
        Get-VeraDevice -HasService $TemperatureSensorServiceId  
    }
}
