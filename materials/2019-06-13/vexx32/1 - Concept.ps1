<#
    Take a function, any function...
#>

function Get-BasicLength {
    [CmdletBinding()]
    param(
        [string]
        $Path
    )

    $File = Get-Item -Path $Path
    $File.Length
}

# Demonstration
Get-BasicLength -Path .\README.md

<#
    Note that we have to call Get-Item within our function to get the file info object.
    Why not just have that done implicitly?
#>

function Get-ImplicitLength {
    [CmdletBinding()]
    param(
        [System.IO.FileSystemInfo]
        $Path
    )

    $Path.Length
}

# Demonstration
Get-ImplicitLength -Path .\README.md

<#
    - This **only** properly handles full paths.
    - We lose the flexibility of Get-Item.
    - We don't have any control over the error messages this emits if the binding fails.
    - Proper handling of alternate input type usually requires many parameter sets.
#>
