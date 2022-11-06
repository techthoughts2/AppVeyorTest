@{
    ModuleVersion     = '0.0.1'
    RootModule        = 'AppVeyorVault.Extension.psm1'
    FunctionsToExport = @('Set-Secret', 'Get-Secret', 'Remove-Secret', 'Get-SecretInfo', 'Test-SecretVault')
}

