#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'AppVeyorTest'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
$manifestContent = Test-ModuleManifest -Path $PathToManifest
$moduleExported = Get-Command -Module $ModuleName | Select-Object -ExpandProperty Name
#-------------------------------------------------------------------------

Describe $ModuleName {

    Context 'Exported Commands' -Fixture {

        Context 'Number of commands' -Fixture {
            It -Name 'Exports the same number of public funtions as what is listed in the Module Manifest' -Test {
                $manifestExported = ($manifestContent.ExportedFunctions).Keys
                $manifestExported.Count | Should -BeExactly $moduleExported.Count
            }
        }

        Context 'Explicitly exported commands' -ForEach $moduleExported {
            foreach ($command in $moduleExported) {
                BeforeAll {
                    $command = $_
                    $ModuleName = 'AppVeyorTest'
                    $PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
                    $manifestContent = Test-ModuleManifest -Path $PathToManifest
                    $moduleExported = Get-Command -Module $ModuleName | Select-Object -ExpandProperty Name
                    $manifestExported = ($manifestContent.ExportedFunctions).Keys
                }
                It -Name "Includes the $command in the Module Manifest ExportedFunctions" -Test {
                    $manifestExported -contains $command | Should -BeTrue
                }
            }
        }
    }

    Context 'Command Help' -ForEach $moduleExported {
        foreach ($command in $moduleExported) {
            BeforeAll {
                $help = Get-Help -Name $_ -Full
            }
            Context $command -Fixture {
                $help = Get-Help -Name $command -Full

                It -Name 'Includes a Synopsis' -Test {
                    $help.Synopsis | Should -Not -BeNullOrEmpty
                }

                It -Name 'Includes a Description' -Test {
                    $help.description.Text | Should -Not -BeNullOrEmpty
                }

                It -Name 'Includes an Example' -Test {
                    $help.examples.example | Should -Not -BeNullOrEmpty
                }
            }
        }
    }
}
