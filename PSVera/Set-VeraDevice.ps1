function Set-VeraDevice {
    [CmdletBinding()]

    param(
        [alias("Device_Num")]
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [int]$DeviceNum,

        [ValidateSet("On","Off")] 
        [string]$SwitchState,

        [int]$Dimmer,

        [int]$Hue,

        [int]$Saturation
    )

    Begin {
        
            $SwitchStateCode = 1
            if ($SwitchState -eq "Off"){
                $SwitchStateCode = 0
            }
    }

    Process {

        if ($PSBoundParameters.ContainsKey("SwitchState")){    
            Invoke-VeraAPI `
            -ID "action" `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:upnp-org:serviceId:SwitchPower1" `
            -Action "SetTarget" `
            -NewTargetValue $SwitchStateCode
        }
        
        
        if ($PSBoundParameters.ContainsKey("Dimmer")){    
            Invoke-VeraAPI `
            -ID "action" `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:upnp-org:serviceId:Dimming1" `
            -Action "SetLoadLevelTarget" `
            -NewLoadLevelTarget $Dimmer
        }

        if ($PSBoundParameters.ContainsKey("Hue")){
            Invoke-VeraAPI `
            -ID "action" `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:micasaverde-com:serviceId:PhilipsHue1" `
            -Action "SetHueAndSaturation" `
            -Hue $Hue `
            -Saturation $Saturation
        }
    }

}
