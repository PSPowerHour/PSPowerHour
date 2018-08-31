
# Written by Bill Stewart (bstewart@iname.com)
# Modified by Matthew Steeples (matthew@mercuryit.co.uk) to enable using the 
# -Recurse flag on Get-ChildItem and piping in
#
# 2018-03-29
#  Modified by Cláudio Silva (@ClaudioESSilva) to enable multiple changes
#  Add function wrapper as Set-Expression
#
# Replaces strings in files using a regular expression. Supports multi-line searching and replacing.

#requires -version 2

function Set-Expression {

<#
.SYNOPSIS
    Replaces strings in files using one or more regular expressions.

.DESCRIPTION
    Replaces strings in files using one or more regular expressions. 
    Supports multi-line searching and replacing.

.PARAMETER Pattern
    Specifies a collection with the Pattern to find and the Pattern to replace
    Both accept regular expressions and you can and several.

    $replacements = [ordered]@{
        'starting([ ]{1,})(''\w{1,})' = "LIKE`$1`$2%"
        'potatos'                     = "carrots"
    }

.PARAMETER Path
    Specifies the path to one or more files. 
    Wildcards are permitted. Each file is read entirely into memory to support multi-line searching and replacing, so performance may be slow for large files.

.PARAMETER LiteralPath
    Specifies the path to one or more files. The value of the this parameter is used exactly as it is typed. No characters are interpreted as wildcards. 
    Each file is read entirely into memory to support multi-line searching and replacing, so performance may be slow for large files.

.PARAMETER CaseSensitive
    Specifies case-sensitive matching. The default is to ignore case.

.PARAMETER Multiline
    Changes the meaning of ^ and $ so they match at the beginning and end, respectively, of any line, and not just the beginning and end of the entire file. 
    The default is that ^ and $, respectively, match the beginning and end of the entire file.

.PARAMETER UnixText
    Causes $ to match only linefeed (\n) characters. By default, $ matches carriage return+linefeed (\r\n). 
    (Windows-based text files usually use \r\n as line terminators, while Unix-based text files usually use only \n.)

.PARAMETER Overwrite
    Overwrites a file by creating a temporary file containing all replacements and then replacing the original file with the temporary file.
    The default is to output but not overwrite.

.PARAMETER Force
    Allows overwriting of read-only files. Note that this parameter cannot override security restrictions.

.PARAMETER Encoding
    Specifies the encoding for the file when -Overwrite is used. Possible values are: ASCII, BigEndianUnicode, Unicode, UTF32, UTF7, or UTF8. 
    The default value is ASCII.

.INPUTS
    System.IO.FileInfo.

.OUTPUTS
    System.String without the -Overwrite parameter, or nothing with the -Overwrite parameter.
.LINK
    about_Regular_Expressions

.EXAMPLE
    $replacements = [ordered]@{
        'starting([ ]{1,})(''\w{1,})' = "LIKE`$1`$2%"
    }
    Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName "C:\temp\Set-Expression\View.sql"
    This command replaces the pattern "starting 'some text'" with the string "LIKE 'some text%" in the file View.sql and overwrites the file.

.EXAMPLE
    $replacements = [ordered]@{
        'starting([ ]{1,})(''\w{1,})' = "LIKE`$1`$2%"
        'Hello' = "Good bye"
    }
    Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName "C:\temp\Set-Expression\View.sql"
    This command replaces the two patterns based on the two hashtables entries in the file View.sql and overwrites the file.
#>

    [CmdletBinding(DefaultParameterSetName = "Path", SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory = $true, Position = 0)]
        [System.Collections.Specialized.OrderedDictionary]$Pattern,
        [parameter(Mandatory = $true, ParameterSetName = "Path", Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]] $FullName,
        [parameter(Mandatory = $true, ParameterSetName = "LiteralPath", Position = 2)]
        [String[]] $LiteralPath,
        [Switch] $CaseSensitive,
        [Switch] $Multiline,
        [Switch] $UnixText,
        [Switch] $Overwrite,
        [Switch] $Force,
        [ValidateSet("ASCII", "BigEndianUnicode", "Unicode", "UTF32", "UTF7", "UTF8")]
        [String] $Encoding = "ASCII"
    )

    begin {
        # Throw an error if $Encoding is not valid.
        $encodings = @("ASCII", "BigEndianUnicode", "Unicode", "UTF32", "UTF7",
            "UTF8")
        if ($encodings -notcontains $Encoding) {
            throw "Encoding must be one of the following: $encodings"
        }

        # Extended test-path: Check the parameter set name to see if we
        # should use -literalpath or not.
        function test-pathEx($FullName) {
            switch ($PSCmdlet.ParameterSetName) {
                "Path" {
                    test-path $FullName
                }
                "LiteralPath" {
                    test-path -literalpath $FullName
                }
            }
        }

        # Extended get-childitem: Check the parameter set name to see if we
        # should use -literalpath or not.
        function get-childitemEx($FullName) {
            switch ($PSCmdlet.ParameterSetName) {
                "Path" {
                    get-childitem $FullName -force
                }
                "LiteralPath" {
                    get-childitem -literalpath $FullName -force
                }
            }
        }

        # Outputs the full name of a temporary file in the specified path.
        function get-tempname($FullName) {
            do {
                $tempname = join-path $FullName ([IO.Path]::GetRandomFilename())
            }
            while (test-path $tempname)
            $tempname
        }

    
    }

    process {
        # The list of items to iterate depends on the parameter set name.
        switch ($PSCmdlet.ParameterSetName) {
            "Path" { $list = $FullName }
            "LiteralPath" { $list = $LiteralPath }
        }

        # Iterate the items in the list of paths. If an item does not exist,
        # continue to the next item in the list.
        foreach ($item in $list) {
            if (-not (test-pathEx $item)) {
                write-error "Unable to find '$item'."
                continue
            }

            # Iterate each item in the path. If an item is not a file,
            # skip all remaining items.
            foreach ($file in get-childitemEx $item) {
                if ($file -isnot [IO.FileInfo]) {
                    write-error "'$file' is not in the file system."
                    break
                }

                # Get a temporary file name in the file's directory and create
                # it as a empty file. If set-content fails, continue to the next
                # file. Better to fail before than after reading the file for
                # performance reasons.
                if ($Overwrite) {
                    $tempname = get-tempname $file.DirectoryName
                    set-content $tempname $NULL -confirm:$FALSE
                    if (-not $?) { continue }
                    write-verbose "Created file '$tempname'."
                }

                # Read all the text from the file into a single string. We have
                # to do it this way to be able to search across line breaks.
                try {
                    write-verbose "Reading '$file'."
                    $text = [IO.File]::ReadAllText($file.FullName)
                    write-verbose "Finished reading '$file'."
                }
                catch [Management.Automation.MethodInvocationException] {
                    write-error $ERROR[0]
                    continue
                }

                #initializing variable
                $fileHasChanged = $false

                # replace each entry on the hashtable
                foreach ($p in $pattern.Keys) {
                    $Replacement = $pattern[$p]

                    Write-Output "$p - $Replacement"

                    # Use '\r$' instead of '$' unless -UnixText specified because
                    # '$' alone matches '\n', not '\r\n'. Ignore '\$' (literal '$').
                    if (-not $UnixText) {
                        $p = $p -replace '(?<!\\)\$', '\r$'
                    }
        
                    # Build an array of Regex options and create the Regex object.
                    $opts = @()
                    if (-not $CaseSensitive) { $opts += "IgnoreCase" }
                    if ($MultiLine) { $opts += "Multiline" }
                    if ($opts.Length -eq 0) { $opts += "None" }
                    $regex = new-object Text.RegularExpressions.Regex $p, $opts

                    #Write-Output "will do replace!"

                    $replace = $regex.Replace($text, $Replacement)

                    #Write-Output "replace done!"

                    # check if script has changed
                    if ($text -ne $replace) {
                        $fileHasChanged = $true
                        # update current script
                        $text = $replace
                    }
                } # foreach $pattern
            
                # If -Overwrite not specified, output the result of the Replace
                # method and continue to the next file.
                if (-not $Overwrite) {
                    Out-Host $replace
                    continue
                }

                # Do nothing further if we're in 'what if' mode.
                if ($WHATIFPREFERENCE) { continue }

                try {
                    If ($fileHasChanged) {
                        write-verbose "Writing '$tempname'."
        
                        [IO.File]::WriteAllText("$tempname", $text, [Text.Encoding]::$Encoding)
                        write-verbose "Finished writing '$tempname'."
                        write-verbose "Copying '$tempname' to '$file'."
                        copy-item $tempname $file -force:$Force -erroraction Continue
                        if ($?) {
                            write-verbose "Finished copying '$tempname' to '$file'."
                        }
                    }
                    else {
                        Write-Verbose "File hadn't changed"
                    }
                    remove-item $tempname
                    if ($?) {
                        write-verbose "Removed file '$tempname'."
                    }
                }
                catch [Management.Automation.MethodInvocationException] {
                    write-error $ERROR[0]
                }
            } # foreach $file
        } # foreach $item
    } # process

    end { }
}
