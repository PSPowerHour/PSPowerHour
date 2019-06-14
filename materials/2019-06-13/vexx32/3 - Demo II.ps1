<#
    The Fun Stuff!

    Let's make a function that can figure out a complex
    number input from very simple set of inputs!
#>

using namespace System.Management.Automation
using namespace System.Numerics

class ComplexTransformAttribute : ArgumentTransformationAttribute {

    [object] Transform([EngineIntrinsics] $Intrinsics, [object] $Item) {

        # We want everything to come back as either [Complex] or [double]
        # [double] values get converted with [Complex]::new($double, 0) by default
        $Results = switch ($Item) {
            { $_ -is [Complex] } {
                $_
                continue
            }
            { ( $_ -as [double] ) -ne $null } {
                # Handle common numbers by converting them to doubles for
                # the Complex type to work with. These will end up being
                # complex numbers with a complex portion of 0.
                $_ -as [double]
                continue
            }
            { $_ -is [string] } {
                # Predefine a pattern for a number, possibly with a decimal portion
                $Double = "[0-9]+(\.[0-9]+)?"
                if ($_.Trim() -match "^${Double}$") {
                    $Matches[0] -as [double]
                }

                if ($_.Trim() -match "^(?<Imaginary>${Double})i$") {
                    $Matches.Imaginary -as [double]
                    continue
                }

                $Cartesian = "^(?<Real>${Double}) *(?<sign>+|-) *(?<Imaginary>${Double})i$"
                if ($_.Trim() -match $Cartesian) {
                    $Real = $Matches.Real -as [double]
                    $Imaginary = $Matches.Imaginary -as [double]

                    [Complex]::new($Real, $Imaginary)
                    continue
                }

                $Polar = "^(?<Magnitude>${Double}) @ (?<Phase>${Double})(rad(ians)?)?$"
                if ($_.Trim() -match $Polar) {
                    $Magnitude = $Matches.Magnitude -as [double]
                    $Phase = $Matches.Phase -as [double]

                    [Complex]::FromPolarCoordinates($Magnitude, $Phase)
                    continue
                }

                throw [ArgumentTransformationMetadataException]::new(
                    @"
String '$_' could not be parsed for conversion to System.Numerics.Complex. Please use: '0.0', '0.0i', '0.0 +/- 0.0i', or '## @ ## [radians]' formats.
"@
                )
            }
            default {
                $_
            }
        }

        return $Results

    }

}

function Get-PolarForm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ComplexTransform()]
        [Complex]
        $ComplexValue
    )
    process {
        "{0} ∠ {1}" -f $ComplexValue.Magnitude, $ComplexValue.Phase
    }
}

Get-PolarForm -ComplexValue "1 + 4i"

4, 6, "11i", 100, "12 - 18.2i" | Get-PolarForm
