function Get-VeraDevice {
    [CmdletBinding()]

    param(
        [switch]$HasSwitch,
        [switch]$HasDimmer,
        [switch]$IsTemperatureSensor,
        [string]$HasService,
        [ValidateSet("Interface","Dimmable Light","Switch","Security Sensor","HVAC","Camera","Door Lock","Window Covering","Remote Control","IR Transmitter","Generic I/O","Generic Sensor","Serial Port","Scene Controller","A/V","Humidity Sensor","Temperature Sensor","Light Sensor","Z-Wave Interface","Insteon Interface","Power Meter","Alarm Panel","Alarm Partition","Siren","Weather","Philips Controller","Appliance","UV Sensor","Mouse Trap")]
        [string]$Category,
        [alias("Category_Num")]
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [int]$CategoryNum,
        [alias("Subcategory_Num")]
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [int]$SubCategoryNum
    )

    if ($PSBoundParameters.ContainsKey("SubCategoryNum") -and !$PSBoundParameters.ContainsKey("CategoryNum")){
        throw "You must provide CategoryNum when using SubCategoryNum"
    }

    if ($PSBoundParameters.Keys.Count -eq 0 -or $HasService -or $PSBoundParameters.ContainsKey("CategoryNum")){
        $response = Invoke-VeraAPI -ID "device"
        $devices = $response.GetElementsByTagName("device")    
        if ($HasService){
            $devices  | Where-Object {
                Test-VeraService -Device $_ -ServiceId $HasService
            }
        }
        elseif ($PSBoundParameters.ContainsKey("CategoryNum")) {
            $devices = $devices | Where-Object {
                $_.Category_Num -eq $CategoryNum
            }
            if ($PSBoundParameters.ContainsKey("SubCategoryNum")) {
                $devices = $devices | Where-Object {
                    $_.Subcategory_Num -eq $SubCategoryNum
                }
            }
            $devices
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

    if ($Category){
        #Get-VeraDevice -CategoryNum (
        #    $LuupDeviceCategories | Where-Object 'Device Type' -eq $Category | Select-Object -ExpandProperty Category -First 1
        #)
        $LuupDeviceCategories | Where-Object 'Device Type' -eq $Category | Select-Object Category_Num -First 1 | Get-VeraDevice
    }
}
