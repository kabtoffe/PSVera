function Invoke-VeraAPI {
    param(
        $id,
        $DeviceNum,
        $serviceId,
        $action,
        $outputformat="xml",
        [hashtable]$AdditionalParameters = @{}
    )
    $BaseUrl = "http://$($script:VeraHost):3480/data_request?"

    $PSBoundParameters.Keys | Where-Object { $_ -ne "AdditionalParameters" } | ForEach-Object {
        $BaseUrl += "$($_)=$($PSBoundParameters[$_])&" 
    }

    $AdditionalParameters.Keys | ForEach-Object {
        $BaseUrl += "$($_)=$($AdditionalParameters[$_])&" 
    }

    Invoke-RestMethod -Uri "$($BaseUrl)output_format=$OutputFormat"
}
