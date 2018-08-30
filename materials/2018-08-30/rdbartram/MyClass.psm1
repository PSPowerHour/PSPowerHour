using module .\BaseClass.psm1

class MyClass : BaseObject {

    hidden [string] $_internal

    [Set('{
        param([string]$string)
        $this._internal = $string.trim()
    }')]
    [string] $Writeable

    [Get('{
        $this._internal
    }')]
    [string] $Readable
}
