---
external help file: PlaygroundTools-help.xml
Module Name: PlaygroundTools
online version:
schema: 2.0.0
---

# New-PlaygroundBucket

## SYNOPSIS

Creates a new bucket that can be added to a playground.

## SYNTAX

```powershell
New-PlaygroundBucket [-Name] <String> [-Height] <String> [-Diameter] <String> [[-Color] <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new bucket that can be added to a playground.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PlaygroundBucket -Name "The red one" -Height "15" -Diameter "20" -Color "Red"
```

Creates a new red bucket.

## PARAMETERS

### -Color

Color of the new bucket.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Diameter

Diameter of the bucket.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Height

Height of the bucket.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

A name for the bucket.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters [http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PlaygroundToy

## NOTES

## RELATED LINKS
