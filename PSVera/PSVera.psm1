. "$PSScriptRoot\Connect-Vera.ps1"
. "$PSScriptRoot\Get-VeraDevice.ps1"
. "$PSScriptRoot\Invoke-VeraAPI.ps1"
. "$PSScriptRoot\Set-VeraDevice.ps1"
. "$PSScriptRoot\Test-VeraService.ps1"
. "$PSScriptRoot\Invoke-VeraAction.ps1"
. "$PSScriptRoot\Get-VeraStatus.ps1"
. "$PSScriptRoot\Get-VeraVariable.ps1"
. "$PSScriptRoot\Get-VeraRoom.ps1"

#ServiceIds
#$script:ZWaveNetworkServiceId = "urn:micasaverde-com:serviceId:ZWaveNetwork1"
#urn:micasaverde-com:serviceId:HaDevice1
#urn:micasaverde-com:serviceId:ZigbeeNetwork1
#urn:micasaverde-com:serviceId:ZigbeeDevice1
#urn:micasaverde-com:serviceId:BluetoothNetwork1
#urn:micasaverde-com:serviceId:SceneController1
#urn:micasaverde-com:serviceId:Color1
$script:SecuritySensorServiceId = "urn:micasaverde-com:serviceId:SecuritySensor1"
#urn:micasaverde-com:serviceId:ZWaveDevice1
$script:SwitchServiceId = "urn:upnp-org:serviceId:SwitchPower1"
$script:TemperatureSensorServiceId = "urn:upnp-org:serviceId:TemperatureSensor1"
$script:LightSensorServiceId = "urn:micasaverde-com:serviceId:LightSensor1"
$script:HumiditySensorServiceId = "urn:micasaverde-com:serviceId:HumiditySensor1"
$script:EnergyMeteringServiceId = "urn:micasaverde-com:serviceId:EnergyMetering1"
$script:DimmingServiceID = "urn:upnp-org:serviceId:Dimming1"
#urn:micasaverde-com:serviceId:EEM-Plugin1
#urn:micasaverde-com:serviceId:VOTS1
$script:PhilipsHueServiceId = "urn:micasaverde-com:serviceId:PhilipsHue1"
$script:GenericSensorServiceId = "urn:micasaverde-com:serviceId:GenericSensor1"