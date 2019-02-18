$ProgressBar = New-BTProgressBar -Status 'progressStatus' -Value 'progressValue'

$Progress = 0.00
$Status = 'Working'

$DataBinding = @{
    'progressStatus' = $Status
    'progressValue' = $Progress
}

$Text1 = New-BTText -Content 'Rapid Updates'
$Text2 = New-BTText -Content 'This toast gets many, rapid replacements!'
$Image2 = New-BTImage -Source D:\Git\BurntToast\Media\BurntToast.png -AppLogoOverride -Crop Circle
$Binding1 = New-BTBinding -Children $Text1, $Text2, $ProgressBar -AppLogoOverride $Image2
$Visual1 = New-BTVisual -BindingGeneric $Binding1
$Content1 = New-BTContent -Visual $Visual1

foreach ($i in 1..100) {
    if ($i -eq 100) {
        $Status = 'Done'
    }
    $Progress += 0.01

    $DataBinding = @{
        'progressStatus' = $Status
        'progressValue' = $Progress
    }

    if ($i % 5 -eq 0) {
        Submit-BTNotification -Content $Content1 -SequenceNumber $i -DataBinding $DataBinding -UniqueIdentifier RapidUpdate

        Start-Sleep -Milliseconds 500
    }
}