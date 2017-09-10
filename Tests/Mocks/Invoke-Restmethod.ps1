Mock Invoke-RestMethod -ModuleName PSVera {
    $Split = $Uri.ToString().Split("?")
    $Data = @{
        "Hostname" = $Split[0]
    }
    $Split[1].Split("&") | ForEach-Object {
        $Parameter = $_.Split("=")
        $Data.Add($Parameter[0],$Parameter[1])
    }
    $Data
}
