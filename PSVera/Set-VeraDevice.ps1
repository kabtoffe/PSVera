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
            Invoke-VeraAction `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:upnp-org:serviceId:SwitchPower1" `
            -ActionName "SetTarget" `
            -ActionParameters @{
                "newTargetValue" = $SwitchStateCode
            }
        }
        
        
        if ($PSBoundParameters.ContainsKey("Dimmer")){    
            Invoke-VeraAction `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:upnp-org:serviceId:Dimming1" `
            -ActionName "SetLoadLevelTarget" `
            -ActionParameters @{
                "NewLoadLevelTarget" = $Dimmer
            }
        }

        if ($PSBoundParameters.ContainsKey("Hue")){
            Invoke-VeraAction `
            -DeviceNum $DeviceNum `
            -ServiceId "urn:micasaverde-com:serviceId:PhilipsHue1" `
            -ActionName "SetHueAndSaturation" `
            -ActionParameters @{
                "Hue" = $Hue
                "Saturation" = $Saturation
            }
        }
    }

}
