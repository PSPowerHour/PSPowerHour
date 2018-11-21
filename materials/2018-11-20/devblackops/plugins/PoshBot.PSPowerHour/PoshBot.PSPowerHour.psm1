# Dot source functions
$params = @{
    Path        = Join-Path -Path $PSScriptRoot -ChildPath 'Public' | Resolve-Path
    Filter      = '*.ps1'
    File        = $true
    Recurse     = $true
    ErrorAction = 'SilentlyContinue'
}
$files = Get-ChildItem @params
foreach ($file in $files) {
    try {
        . $file.fullname
    } catch {
        throw $_
    }
}

Export-ModuleMember -Function $files.Basename