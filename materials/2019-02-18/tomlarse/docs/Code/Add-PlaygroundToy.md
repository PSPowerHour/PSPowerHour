---
external help file: PlaygroundTools-help.xml
Module Name: PlaygroundTools
online version:
schema: 2.0.0
---

# Add-PlaygroundToy

## SYNOPSIS

Adds a toy to a playground.

## SYNTAX

```powershell
Add-PlaygroundToy [-Toy] <PlaygroundToy> -Identity <String> [<CommonParameters>]
```

## DESCRIPTION

Adds a toy to a playground

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PlaygroundBucket | Add-PlaygroundToy -Identity "Sandbox"
```

Adds a new bucket to the sandbox playground

## PARAMETERS

### -Identity

Identity of the playground to add to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Toy

The toy to add.

```yaml
Type: PlaygroundToy
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters [http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PlaygroundToy

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
