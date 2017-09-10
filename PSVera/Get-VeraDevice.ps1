function Get-VeraDevice {

    param(
        [switch]$HasSwitch
    )

    $response = Invoke-VeraAPI -ID "device"
    $devices = $response.root.device.deviceList.device.devicelist.device

    if ($HasSwitch){
        $devices = $devices  | Where-Object {
            Test-VeraService -Device $_ -ServiceId "urn:upnp-org:serviceId:SwitchPower1"
        }
    }

    $devices
}
