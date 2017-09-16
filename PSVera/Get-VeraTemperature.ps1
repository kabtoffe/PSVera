function Get-VeraTemperature{
    [CmdletBinding()]

    param(
        [alias("id")]
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [int]$DeviceNum
    )

    Process {
        Get-VeraVariable -DeviceNum $DeviceNum -ServiceId $TemperatureSensorServiceId -VariableName "CurrentTemperature"
    }

}