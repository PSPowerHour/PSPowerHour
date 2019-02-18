---
external help file: PlaygroundTools-help.xml
Module Name: PlaygroundTools
online version:
schema: 2.0.0
---

# Remove-PlaygroundToy

## SYNOPSIS

Removes a toy from a playground.

## SYNTAX

```powershell
Remove-PlaygroundToy [-Identity] <String> -Toy <PlaygroundToy> [<CommonParameters>]
```

## DESCRIPTION

Removes a toy from a playground.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PlaygroundToy -Identity "Sandbox" | ? name -eq "The red one" | Remove-PlaygroundToy -Identity "Sandbox"
```

Removes the red one from the playground.

## PARAMETERS

### -Identity

Identity of the playground to remove from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Toy

The toy to remove.

```yaml
Type: PlaygroundToy
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters [http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PlaygroundToy

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
