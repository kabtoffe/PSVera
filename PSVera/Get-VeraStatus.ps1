function Get-VeraStatus {
    [CmdletBinding()]

    param(
        [alias("Device_Num")]
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [int]$DeviceNum
    )

    Process {
        $parameters = @{
            "id" = "status"
        }

        $parameters += $PSBoundParameters

        $result = (Invoke-VeraAPI @parameters).root

        if ($DeviceNum -ne $null){
            $Attribute = "Device_Num_$DeviceNum"
            $result = $result.$Attribute
        }

        $result
    }

}
