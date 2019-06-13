<#
    The Fun Stuff!

    Let's make a function that can figure out a complex
    number input from very simple set of inputs!
#>

using namespace System.Management.Automation
using namespace System.Numerics

class ComplexTransformAttribute : ArgumentTransformationAttribute {

    [object] Transform([EngineIntrinsics] $Intrinsics, [object] $Item) {

        throw [NotImplementedException]::new()

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
