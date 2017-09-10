function Get-VeraVariable {
    [CmdletBinding()]

    param(
        [alias("Device_Num")]
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [int]$DeviceNum,

        $ServiceId,

        $VariableName
    )
    Process {
        Invoke-VeraAPI -id "variableget" -DeviceNum $DeviceNum -serviceId $ServiceId -AdditionalParameters @{
            "Variable" = $VariableName
        }
    }   

}
