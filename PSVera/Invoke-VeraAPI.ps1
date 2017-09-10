function Invoke-VeraAPI {
    param(
        $id,
        $DeviceNum,
        $serviceId,
        $action,        
        $newTargetValue,
        $newLoadlevelTarget,
        $Hue,
        $Saturation,
        $outputformat="xml"
    )
    $BaseUrl = "http://$($script:VeraHost):3480/data_request?"

    $PSBoundParameters.Keys | ForEach-Object {
        $BaseUrl += "$($_)=$($PSBoundParameters[$_])&" 
    }

    Invoke-RestMethod -Uri "$($BaseUrl)output_format=$OutputFormat"
}
