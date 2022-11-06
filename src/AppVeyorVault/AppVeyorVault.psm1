<#
This is an entirely optional psm1 which you can leverage to surface up
custom functions to AppVeyorVault.psd1
You could create a specialized wrapper function for Registering/Un-registering your vault.
You could create specialized configuration functions.
You could also register autocompleters here.
A few examples have been included below.
#>

# <#
# .SYNOPSIS
#     Custom function for retrieving configuration details about your vault.
# #>
# function Get-AppVeyorVaultConfiguration {
#     [CmdletBinding()]
#     param (

#     )
# }#Get-AppVeyorVaultConfiguration


<#
.SYNOPSIS
    Custom function for setting configuration details about your vault.
#>
# function Set-AppVeyorVaultConfiguration {
#     [CmdletBinding()]
#     param (

#     )
# }#Get-AppVeyorVaultConfiguration

<#
.SYNOPSIS
    Custom wrapper function for registering your vault.
#>
# function Register-AppVeyorVaultVault {
#     [CmdletBinding()]
#     param (

#     )

#     $params = @{

#     }

#     Register-SecretVault @Params
# }#Register-AppVeyorVaultConfiguration

<#
.SYNOPSIS
    Custom wrapper function for un-registering your vault.
#>
# function Unregister-AppVeyorVaultVault {
#     [CmdletBinding()]
#     param (

#     )

#     $params = @{

#     }

#     Unregister-SecretVault @params
# }#Unregister-AppVeyorVaultConfiguration

<#
.SYNOPSIS
    Entirely custom function for performing some type of connection related to your vault.
#>
# function Connect-AppVeyorVault {
#     [CmdletBinding()]
#     param (

#     )
# }#Connect-AppVeyorVaultConfiguration

<#
.SYNOPSIS
    Entirely custom function for performing some type of disconnect related to your vault.
#>
# function Disconnect-AppVeyorVault {
#     [CmdletBinding()]
#     param (

#     )
# }#Disconnect-AppVeyorVaultConfiguration

<#
Some example of registering argument completers
#>

# $vaultArgCompleter = {
#     param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

#     (Get-SecretVault -Name "*$wordToComplete*") | Select-Object -ExpandProperty Name
# }
# $vaultSplat = @{
#     CommandName   = 'Register-AppVeyorVaultVault'
#     ParameterName = 'Name'
#     ScriptBlock   = $vaultArgCompleter
# }
# Register-ArgumentCompleter @vaultSplat

# $vaultURArgCompleter = {
#     param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

#     (Get-SecretVault -Name "*$wordToComplete*") | Select-Object -ExpandProperty Name
# }
# $vaultURArgSplat = @{
#     CommandName   = 'Unregister-AppVeyorVaultVault'
#     ParameterName = 'Name'
#     ScriptBlock   = $vaultURArgCompleter
# }
# Register-ArgumentCompleter @$vaultURArgSplat

