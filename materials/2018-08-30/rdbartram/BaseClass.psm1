class Get : Attribute {

    get([string]$scriptblock) {

    }
}

class Set : Attribute {

    set([string]$scriptblock) {

    }
}

class BaseObject {

    BaseObject () {
        $this.GetType().GetProperties() | ForEach-Object -Process {
            $Property = $_

            if ($_.CustomAttributes.AttributeType -contains [Get] -or $_.CustomAttributes.AttributeType -contains [Set]) {
                $get = 'throw "this property is not gettable"'
                $set = 'throw "this property is not settable"'

                if ($_.CustomAttributes.Where{$_.AttributeType.Name -eq [Get].Name}.ConstructorArguments.Value -match "{((\s|.)+)}") {
                    $get = $matches[1]
                }
                if ($_.CustomAttributes.Where{$_.AttributeType.Name -eq [Set].Name}.ConstructorArguments.Value -match "{((\s|.)+)}") {
                    $set = $matches[1]
                }
                $this | Add-Member -MemberType ScriptProperty -Name $Property.Name -TypeName $Property.PropertyType -Value ([scriptblock]::Create($get)) -SecondValue ([scriptblock]::Create($set)) -Force
            }
        }
    }
}
