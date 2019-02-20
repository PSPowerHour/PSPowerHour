# Will be available in BurntToast v0.7.0

$ProgressBar = New-BTProgressBar -Status 'progressStatus' -Value 'progressValue' -ValueDisplay 'progressValueStringOverride'

$DataBinding = @{
    'progressStatus' = 'Doing stuff'
    'progressValue' = 0.01
    'progressValueStringOverride' = 'Just started'
}

$Text1 = New-BTText -Content 'This is a test'
$Text2 = New-BTText -Content 'This more testing'
$Image2 = New-BTImage -Source D:\Git\BurntToast\Media\BurntToast.png -AppLogoOverride -Crop Circle
$Binding1 = New-BTBinding -Children $Text1, $Text2, $ProgressBar -AppLogoOverride $Image2
$Visual1 = New-BTVisual -BindingGeneric $Binding1
$Content1 = New-BTContent -Visual $Visual1

Submit-BTNotification -Content $Content1 -SequenceNumber 1 -DataBinding $DataBinding -UniqueIdentifier TestUpdate

$DataBinding = @{
    'progressStatus' = 'Still doing stuff'
    'progressValue' = 0.5
    'progressValueStringOverride' = 'Half way done?'
}

Update-BTNotification -SequenceNumber 2 -UniqueIdentifier TestUpdate -DataBinding $DataBinding

$DataBinding = @{
    'progressStatus' = 'Probably not doing stuff'
    'progressValue' = 1
    'progressValueStringOverride' = 'Done?!'
}

Update-BTNotification -SequenceNumber 3 -UniqueIdentifier TestUpdate -DataBinding $DataBinding