Param(
[Parameter(Mandatory=$true)]
[ValidateRange(1,[int32]::MaxValue)]
[Int]
$timeinminutes)
$filesuffix = "("+$timeinminutes+" minutes)"
$viewfiles = @("\\Veeam Backup Morning Coffee OMS.omsview","\\Veeam Health Morning Coffee OMS.omsview","\\Veeam Hyper-V Morning Coffee OMS.omsview","\\Veeam VMware Morning Coffee OMS.omsview");
$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path
foreach ($f in $viewfiles){
	$filepath = $directorypath+"\\"+$f;	
	$content = [System.IO.File]::ReadAllText($filepath).Replace("TimeGenerated:[NOW-15minutes..NOW]","TimeGenerated:[NOW-"+$timeinminutes+"minutes..NOW]")
	[System.IO.File]::WriteAllText($filepath+$filesuffix, $content)
}