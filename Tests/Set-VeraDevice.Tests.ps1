$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Set-VeraDevice" {

    Connect-Vera -VeraHost "hostname"

    Mock Invoke-RestMethod -ModuleName PSVera {
        $Split = $Uri.ToString().Split("?")
        $LocalData = @{
            "Hostname" = $Split[0]
        }
        $Split[1].Split("&") | ForEach-Object {
            $Parameter = $_.Split("=")
            $LocalData.Add($Parameter[0],$Parameter[1])
        }
        $LocalData
    }

    Context "Switches" {
        It "Should send command to turn off" {
            $Response = Set-VeraDevice -DeviceNum 26 -SwitchState Off
            $Response["id"] | Should Be "action"
            $Response["devicenum"] | should be "26"
            $Response["serviceId"] | Should Be "urn:upnp-org:serviceId:SwitchPower1"
            $Response["action"] | Should Be "SetTarget"
            $Response["newTargetValue"] | Should Be 0
        }

        It "Should send command to turn on" {
            $Response = Set-VeraDevice -DeviceNum 26 -SwitchState On
            $Response["id"] | Should Be "action"
            $Response["devicenum"] | should be "26"
            $Response["serviceId"] | Should Be "urn:upnp-org:serviceId:SwitchPower1"
            $Response["action"] | Should Be "SetTarget"
            $Response["newTargetValue"] | Should Be 1
        }

        It "Should throw when called with invalid state" {
            { $Data = Set-VeraDevice -DeviceNum 26 -SwitchState NotAState } | Should Throw
        }


        It "When provided with a device via pipeline" {
            $Response = [pscustomobject]@{
                "Device_Num" = 26
            } | Set-VeraDevice -SwitchState On
            $Response["devicenum"] | Should Be 26
            $Response["newTargetValue"] | Should Be 1
        }

        It "When provided with two devices via pipeline" {
            $Response = [pscustomobject]@{
                "Device_Num" = 26
            },[pscustomobject]@{
                "Device_Num" = 26
            } | Set-VeraDevice -SwitchState On
            $Response[1]["devicenum"] | Should Be 26
            $Response[1]["newTargetValue"] | Should Be 1
        }
    }

    Context "Dimmers" {

        It "Calling with valid value" {
            $result = Set-VeraDevice -DeviceNum 4 -Dimmer 50
            $result["action"] | Should Be "SetLoadLevelTarget"
            $result["serviceid"] | Should Be "urn:upnp-org:serviceId:Dimming1"
            $result["NewLoadLevelTarget"] | Should Be 50

        }

    }

    Context "Philips Hue" {

        It "Hue and saturation can be set" {
            $result = Set-VeraDevice -DeviceNum 4 -Hue 4000 -Saturation 200
            $result["ServiceId"] | Should Be "urn:micasaverde-com:serviceId:PhilipsHue1"
            $result["action"] | Should Be "SetHueAndSaturation"
            $result["Hue"] | Should Be 4000
            $result["Saturation"] | Should Be 200
        }

    }

}

