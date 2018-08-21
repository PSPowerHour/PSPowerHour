break

# Easy Desktop Notifications with BurntToast
# Josh King (@WindosNZ)

# Install-Module BurntToast

#region Demo 1 - Raw Bread
New-BurntToastNotification
#endregion

#region Demo 2 - Custom Text
$Demo2 = @{
    Text = 'BurntToast:', 'A Little on the Dark Side'
}

New-BurntToastNotification @Demo2
#endregion

#region Demo 3 - Alarm Clock
$Demo3 = @{
    Text  = 'WAKE UP!'
    Sound = 'Alarm2'
}

New-BurntToastNotification @Demo3
#endregion

#region Demo 4 - BUTTON!
$Demo4_Button = @{
    Content   = 'Open Report'
    Arguments = 'C:\TechSnips\data.csv'
}

$Button = New-BTButton @Demo4_Button

$Demo4_Toast = @{
    Text   = 'Report Generated',  'It took 6 hours!'
    Button = $Button
}

New-BurntToastNotification @Demo4_Toast
#endregion

#region Demo 5 - Progress Report
$Demo5_Progress = @{
    Status = 'Generating Report'
    Value  = 0.2
}

$Progress1 = New-BTProgressBar @Demo5_Progress

$Demo5_Toast = @{
    Text             = 'Massive Report Incoming!'
    ProgressBar      = $Progress1
    UniqueIdentifier = 'Report1'
}

New-BurntToastNotification @Demo5_Toast
#endregion

#region Demo 6 - Progressing
$Demo6_Progress = @{
    Status = 'Generating Report'
    Value  = 0.6
}

$Progress2 = New-BTProgressBar @Demo6_Progress

$Demo6_Toast = @{
    Text             = 'Massive Report Incoming!'
    ProgressBar      = $Progress2
    UniqueIdentifier = 'Report1'
}

New-BurntToastNotification @Demo6_Toast
#endregion

#region Demo 7 - DONE!
$Demo7_Progress = @{
    Status = 'Completed'
    Value  = 1.0
}

$Progress3 = New-BTProgressBar @Demo7_Progress

$Demo7_Toast = @{
    Text             = 'Massive Report Generated!'
    ProgressBar      = $Progress3
    UniqueIdentifier = 'Report1'
    Button           = $Button
}

New-BurntToastNotification @Demo7_Toast
#endregion

#region Demo 8 - Toner Alert
$Printer = 'GroundFloor'

$CyanPB = New-BTProgressBar -Status 'Cyan' -Value '0.75'
$MagentaPB = New-BTProgressBar -Status 'Magenta' -Value '0.9' -ValueDisplay 'Basically full'
$YellowPB = New-BTProgressBar -Status 'Yellow' -Value '0.5'
$BlackPB = New-BTProgressBar -Status 'Black' -Value '0.09'

$Demo8_Toast = @{
    Text        = "$Printer low on toner!", "One color less than 10% remaining."
    Sound       = 'IM'
    ProgressBar = $CyanPB, $MagentaPB, $YellowPB, $BlackPB
}

New-BurntToastNotification @Demo8_Toast
#endregion

# Find the repo on GitHub: https://github.com/Windos/BurntToast