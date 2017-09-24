$data = Import-Excel -Path .\VeraWikiData.xlsx -WorksheetName "Luup_Device_Categories"
$data | ConvertTo-Json | Out-File ..\PSVera\luup_device_categories.json