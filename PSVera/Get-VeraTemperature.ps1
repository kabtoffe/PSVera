function Get-VeraTemperature{
    [CmdletBinding()]

    param(
        [alias("Device_Num")]
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [int]$DeviceNum
    )

    Process {
        Get-VeraVariable -DeviceNum $DeviceNum -ServiceId $TemperatureSensorServiceId -VariableName "CurrentTemperature"
    }

}