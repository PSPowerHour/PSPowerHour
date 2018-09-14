<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '209,186'
$Form.text                       = "Hello, Reader"
$Form.TopMost                    = $false

$txtName                         = New-Object system.Windows.Forms.TextBox
$txtName.multiline               = $false
$txtName.width                   = 174
$txtName.height                  = 20
$txtName.location                = New-Object System.Drawing.Point(16,59)
$txtName.Font                    = 'Microsoft Sans Serif,10'

$lblGreeting                     = New-Object system.Windows.Forms.Label
$lblGreeting.text                = "Hello, World"
$lblGreeting.AutoSize            = $true
$lblGreeting.width               = 25
$lblGreeting.height              = 10
$lblGreeting.location            = New-Object System.Drawing.Point(21,132)
$lblGreeting.Font                = 'Microsoft Sans Serif,10'

$btnPersonalize                  = New-Object system.Windows.Forms.Button
$btnPersonalize.text             = "Personalize"
$btnPersonalize.width            = 133
$btnPersonalize.height           = 30
$btnPersonalize.location         = New-Object System.Drawing.Point(16,85)
$btnPersonalize.Font             = 'Microsoft Sans Serif,10'

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Enter your name"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(16,34)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($txtName,$lblGreeting,$btnPersonalize,$Label1))

#region gui events {
$btnPersonalize.Add_Click({ Button_Click })
#endregion events }

#endregion GUI }


#Write your logic code here
function Button_Click{
    $lblGreeting.Text="Hello, $($txtName.Text)"
}
[void]$Form.ShowDialog()