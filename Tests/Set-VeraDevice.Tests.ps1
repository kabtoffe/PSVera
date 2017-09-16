$ModuleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleDir = (Get-Item "$ModuleDir\..\PSVera").FullName

Import-Module "$ModuleDir\PSVera.psm1" -Force

Describe "Set-VeraDevice" {

    Connect-Vera -VeraHost "hostname"

    Mock Invoke-RestMethod -ModuleName PSVera

    Context "Switches" {
        It "Should send command to turn off" {
            $result = Set-VeraDevice -DeviceNum 26 -SwitchState Off

            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("id=action") -and`
                $Uri.ToString().Contains("DeviceNum=26") -and`
                $Uri.ToString().Contains("serviceId=urn:upnp-org:serviceId:SwitchPower1") -and`
                $Uri.ToString().Contains("action=SetTarget") -and`
                $Uri.ToString().Contains("newTargetValue=0")
            }
        }

        It "Should send command to turn on" {
            $result = Set-VeraDevice -DeviceNum 26 -SwitchState On

            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=26&") -and
                $Uri.ToString().Contains("&serviceId=urn:upnp-org:serviceId:SwitchPower1&") -and
                $Uri.ToString().Contains("&action=SetTarget&") -and
                $Uri.ToString().Contains("&newTargetValue=1&")
            }
        }

        It "Should throw when called with invalid state" {
            { Set-VeraDevice -DeviceNum 26 -SwitchState NotAState } | Should Throw
        }


        It "When provided with a device via pipeline" {
            $result = [pscustomobject]@{
                "Device_Num" = 12
            } | Set-VeraDevice -SwitchState Off
            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=12&") -and
                $Uri.ToString().Contains("&serviceId=urn:upnp-org:serviceId:SwitchPower1&") -and
                $Uri.ToString().Contains("&action=SetTarget&") -and
                $Uri.ToString().Contains("&newTargetValue=0&")
            }
        }

        It "When provided with two devices via pipeline" {
            $result = [pscustomobject]@{
                "Device_Num" = 9
            },[pscustomobject]@{
                "Device_Num" = 22
            } | Set-VeraDevice -SwitchState On
            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=9&") -and
                $Uri.ToString().Contains("&serviceId=urn:upnp-org:serviceId:SwitchPower1&") -and
                $Uri.ToString().Contains("&action=SetTarget&") -and
                $Uri.ToString().Contains("&newTargetValue=1&")
            }
            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=22&") -and
                $Uri.ToString().Contains("&serviceId=urn:upnp-org:serviceId:SwitchPower1&") -and
                $Uri.ToString().Contains("&action=SetTarget&") -and
                $Uri.ToString().Contains("&newTargetValue=1&")
            }
        }
    }

    Context "Dimmers" {

        It "Calling with valid value" {
            $result = Set-VeraDevice -DeviceNum 4 -Dimmer 50
            Assert-MockCalled Invoke-RestMethod -Scope It -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=4&") -and
                $Uri.ToString().Contains("&serviceId=urn:upnp-org:serviceId:Dimming1&") -and
                $Uri.ToString().Contains("&action=SetLoadLevelTarget&") -and
                $Uri.ToString().Contains("&newLoadlevelTarget=50&")
            }

        }

    }

    Context "Philips Hue" {

        It "Hue and saturation can be set" {
            $result = Set-VeraDevice -DeviceNum 4 -Hue 4000 -Saturation 200
            Assert-MockCalled Invoke-RestMethod -ModuleName PSVera -ParameterFilter {
                $Uri.ToString().Contains("?id=action") -and
                $Uri.ToString().Contains("&DeviceNum=4&") -and
                $Uri.ToString().Contains("&serviceId=urn:micasaverde-com:serviceId:PhilipsHue1&") -and
                $Uri.ToString().Contains("&action=SetHueAndSaturation&") -and
                $Uri.ToString().Contains("&Hue=4000&") -and 
                $Uri.ToString().Contains("&Saturation=200&")
            }
        }

    }

}

