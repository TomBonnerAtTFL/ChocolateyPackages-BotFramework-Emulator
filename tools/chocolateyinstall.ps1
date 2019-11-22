$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$releaseNumber = 21132328

$url = ((Invoke-RestMethod -Uri https://api.github.com/repos/microsoft/BotFramework-Emulator/releases/$releaseNumber).assets | Where-Object { $_.name -match ".exe" }).browser_download_url;

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = "exe"
  url           = $url
  softwareName  = 'Bot Framework Emulator' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  # Checksum
  checksum      = '21F000F157E8C6BF9C2ED52E237F877C6AA9BAA6F78B5BB1841BA60335ABDB21'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  # MSI
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs