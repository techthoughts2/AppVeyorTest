#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'AppVeyorVault'
$vaultName = 'AppVeyorVault'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------

Describe 'AppVeyorVault Vault Extension Tests' -Tag Unit {
    BeforeAll {
        Import-Module -Name Microsoft.PowerShell.SecretManagement
        Get-SecretVault $vaultName -ErrorAction Ignore | Unregister-SecretVault -ErrorAction Ignore
        Register-SecretVault -Name $vaultName -ModuleName $PathToManifest
    } #beforeAll

    AfterAll {
        Unregister-SecretVault -Name $vaultName -ErrorAction Ignore
    } #afterAll

    Context 'Your First Vault Test' {
        <#
            It 'should ...' {

            }#it
        #>
    } #context_FunctionName
} #describe_vaultExtension
