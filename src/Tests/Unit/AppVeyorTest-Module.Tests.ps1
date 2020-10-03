#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'AppVeyorTest'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
$PathToModule = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psm1")
#-------------------------------------------------------------------------
Describe 'Module Tests' -Tag Unit {
    Context "Module Tests" {
        $script:manifestEval = $null
        It 'Passes Test-ModuleManifest' {
            { $script:manifestEval = Test-ModuleManifest -Path $PathToManifest } | Should Not throw
            $? | Should Be $true
        }#manifestTest
        It 'root module AppVeyorTest.psm1 should exist' {
            $PathToModule | Should Exist
            $? | Should Be $true
        }#psm1Exists
        It 'manifest should contain AppVeyorTest.psm1' {
            $PathToManifest |
            Should -FileContentMatchExactly "AppVeyorTest.psm1"
        }#validPSM1
        It 'should have a matching module name in the manifest' {
            $script:manifestEval.Name | Should Be $ModuleName
        }#name
        It 'should have a valid description in the manifest' {
            $script:manifestEval.Description | Should Not BeNullOrEmpty
        }#description
        It 'should have a valid author in the manifest' {
            $script:manifestEval.Author | Should Not BeNullOrEmpty
        }#author
        It 'should have a valid version in the manifest' {
            $script:manifestEval.Version -as [Version] | Should Not BeNullOrEmpty
        }#version
        It 'should have a valid guid in the manifest' {
            { [guid]::Parse($script:manifestEval.Guid) } | Should Not throw
        }#guid
        It 'should not have any spaces in the tags' {
            foreach ($tag in $script:manifestEval.Tags) {
                $tag | Should Not Match '\s'
            }
        }#tagSpaces
        It 'should have a valid project Uri' {
            $script:manifestEval.ProjectUri | Should -Not -BeNullOrEmpty
        }#uri
    }#context_ModuleTests
}#describe_ModuleTests
