function Test-VeraService {
    param(
        $Device,

        $ServiceId
    )

    $Device.servicelist.service.serviceId -contains $ServiceId
    
}
