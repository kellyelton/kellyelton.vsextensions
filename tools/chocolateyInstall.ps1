$packageName = 'kellyelton.vsextensions'

function Get-Batchfile ($file) {
  $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
      $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32()
{
    $BatchFile = join-path $env:VS120COMNTOOLS "vsvars32.bat"
    Get-Batchfile `"$BatchFile`"
}

function curlex($url, $filename) {
  $path = [io.path]::gettemppath() + "\" + $filename

    if( test-path $path ) { rm -force $path }

  (new-object net.webclient).DownloadFile($url, $path)

    return new-object io.fileinfo $path
}

function installsilently($url, $name) {
  echo "Installing $name"

  $extension = (curlex $url $name).FullName

  $result = Start-Process -FilePath "VSIXInstaller.exe" -ArgumentList "/q $extension" -Wait -PassThru;
}

try {

  vsvars32

    installsilently http://visualstudiogallery.msdn.microsoft.com/c8bccfe2-650c-4b42-bc5c-845e21f96328/file/75539/6/EditorConfigPlugin-0.2.5.vsix EditorConfig.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/27077b70-9dad-4c64-adcf-c7cf6bc9970c/file/37502/19/NuGet.Tools.vsix NuGet.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/d0d33361-18e2-46c0-8ff2-4adea1e34fef/file/29666/12/ProPowerTools.vsix ProPowerTools.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/e5f41ad9-4edc-4912-bca3-91147db95b99/file/7088/6/PowerCommands.vsix PowerCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/d491911d-97f3-4cf6-87b0-6a2882120acf/file/25426/68/DPStudio.VSCommands.vsix VsCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/26/VsVim.vsix VsVim.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/63a7e40d-4d71-4fbb-a23b-d262124b8f4c/file/29105/40/GitSccProvider.vsix GitSccProvider.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/fa85b17d-3df2-49b1-bee6-71527ffef441/file/49766/1/PerfWatsonExtension-Signed.vsix PerfWatson.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/7dbae8b3-5812-490e-913e-7bfe17f47f1d/file/29587/13/donmar.devColor.vsix DevColor.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/7c8341f1-ebac-40c8-92c2-476db8d523ce/file/15808/9/SpellChecker.vsix SpellChecker.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f/file/50769/31/WebEssentials.vsix WebEssentials.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/23d11b45-c2ed-4398-9cb5-48ea67878470/file/77232/3/Twitter%20Bootstrap%20MVC.vsix TwitterBootstrapMvc.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/f2ec6478-7fa2-4782-9fc0-e6d9ef8bb3a9/file/79408/4/MvcTwitterBootstrap.vsix MvcTwitterBootstrap.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/2b96d16a-c986-4501-8f97-8008f9db141a/file/53962/24/Mindscape.WebWorkbench.Integration.10.vsix WebWorkbench.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/a15c3ce9-f58f-42b7-8668-53f6cdc2cd83/file/52418/2/Web%20Standards%20Update.msi WebStandardsUpdate.msi
	installsilently http://visualstudiogallery.msdn.microsoft.com/96dabaeb-05e1-4850-a5cc-a6cce79f17c1/file/59058/446/RedGate.Neptune.vsix .NetDemon
	installsilently http://visualstudiogallery.msdn.microsoft.com/7179e851-a263-44b7-a177-1d31e33c84fd/file/32256/26/CodeAlignment.vsix CodeAlignment
	installsilently http://visualstudiogallery.msdn.microsoft.com/7687f71d-49aa-4cbd-b0ad-6f90c9a64572/file/7856/1/GradientSelection.vsix GradientSelection
	installsilently http://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30/file/48932/17/IndentGuide.vsix IndentGuides
	installsilently http://visualstudiogallery.msdn.microsoft.com/69023d00-a4f9-4a34-a6cd-7e854ba318b5/file/55948/14/SlowCheetah.vsix SlowCheetah
	installsilently http://visualstudiogallery.msdn.microsoft.com/32b91d27-2a0f-4a4b-9ad3-caed8b4ced4b/file/47111/5/SharpComments.vsix SharpComments
	Install-ChocolateyPackage 'Resharper' 'msi' '/quiet' 'http://visualstudiogallery.msdn.microsoft.com/EA4AC039-1B5C-4D11-804E-9BEDE2E63ECF/file/4729/11/ReSharperSetup.7.1.1000.900.msi'
	Install-ChocolateyPackage 'NCrunch' 'msi' '/quiet' 'http://downloads.ncrunch.net/NCrunch_VS2012_1.44.0.11.msi'
	Install-ChocolateyPackage 'VS2012Up2CTP2' 'exe' '/SILENT' 'http://download.microsoft.com/download/1/A/5/1A5DD265-6EDF-4609-976A-91E19D47AB29/VS2012.2%20CTP.exe'
	installsilently http://visualstudiogallery.msdn.microsoft.com/abafc7d6-dcaa-40f4-8a5e-d6724bdb980c/file/93137/1/Microsoft.TeamFoundation.Git.Provider.vsix VSToolsForGit
	installsilently http://visualstudiogallery.msdn.microsoft.com/B08B0375-139E-41D7-AF9B-FAEE50F68392/file/5131/7/SnippetDesigner.vsix SnippetDesigner
	Install-ChocolateyPackage 'PythonTools' 'msi' '/quiet' 'http://pytools.codeplex.com/downloads/get/523956'
	installsilently http://visualstudiogallery.msdn.microsoft.com/bc07ec7e-abfa-425f-bb65-2411a260b926/file/84185/2/CSharpOutline.vsix
	installsilently http://visualstudiogallery.msdn.microsoft.com/c9eb3ba8-0c59-4944-9a62-6eee37294597/file/112013/3/PowerShellTools.vsix
    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}
