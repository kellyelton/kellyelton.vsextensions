﻿$packageName = 'kellyelton.vsextensions'

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

    installsilently http://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/49/VsVim.vsix VsVim.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/56633663-6799-41d7-9df7-0f2a504ca361/file/105627/33/WebEssentials2013.vsix WebEssentials.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/2b96d16a-c986-4501-8f97-8008f9db141a/file/53962/59/Mindscape.WebWorkbench.Integration.10.vsix WebWorkbench.vsix
	installsilently http://visualstudiogallery.msdn.microsoft.com/96dabaeb-05e1-4850-a5cc-a6cce79f17c1/file/59058/450/RedGate.Neptune.vsix .NetDemon
	installsilently http://visualstudiogallery.msdn.microsoft.com/7179e851-a263-44b7-a177-1d31e33c84fd/file/32256/33/CodeAlignment.vsix CodeAlignment
	installsilently http://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30/file/48932/19/IndentGuide%20v14.vsix IndentGuides
	installsilently http://visualstudiogallery.msdn.microsoft.com/69023d00-a4f9-4a34-a6cd-7e854ba318b5/file/55948/22/SlowCheetah.vsix SlowCheetah
	installsilently http://visualstudiogallery.msdn.microsoft.com/32b91d27-2a0f-4a4b-9ad3-caed8b4ced4b/file/47111/5/SharpComments.vsix SharpComments
	installsilently http://visualstudiogallery.msdn.microsoft.com/B08B0375-139E-41D7-AF9B-FAEE50F68392/file/5131/8/SnippetDesigner.vsix SnippetDesigner
	Install-ChocolateyPackage 'PythonTools' 'msi' '/quiet' 'http://pytools.codeplex.com/downloads/get/523956'
	installsilently http://visualstudiogallery.msdn.microsoft.com/6c3c5dec-1534-4c42-81b1-cfd4615fd0e9/file/105968/2/CSharpOutline.vsix CSharpOutline
	installsilently http://visualstudiogallery.msdn.microsoft.com/c9eb3ba8-0c59-4944-9a62-6eee37294597/file/112013/7/PowerShellTools.vsix PowerShellTools
    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}
