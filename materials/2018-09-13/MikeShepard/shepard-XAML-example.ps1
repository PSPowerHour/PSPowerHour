Add-type -AssemblyName PresentationFramework

$xaml=[xml]@"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:local="clr-namespace:XAMLTest"
    Title="Window1" Height="250" Width="200">
   <StackPanel>
        <Label Content="Enter your name"
               HorizontalAlignment="Left"
               Margin="27,0,0,0"
               VerticalAlignment="Top"/>
        <TextBox Name="txtName"
                 HorizontalAlignment="Left"
                 Height="23"
                 Margin="27,0,0,3"
                 TextWrapping="Wrap"
                 Text="TextBox"
                 VerticalAlignment="Top"
                 Width="120"/>
        <Label Name="lblGreeting"
               Content="Hello, world"
               HorizontalAlignment="Left"
               Margin="47,0,0,5"
               VerticalAlignment="Top"/>
        <Button Content="Personalize"
                HorizontalAlignment="Left"
                Margin="37,0,0,0"
                VerticalAlignment="Top"
                Width="75"
                Name="btnPersonalize"/>
    </StackPanel>
</Window>
"@

#create the window from the XAML
$reader=New-Object System.Xml.XmlNodeReader $xaml
$Form=[Windows.Markup.XamlReader]::Load( $reader )

#get references to named controls
$btnPersonalize=$form.FindName('btnPersonalize')
$lblGreeting=$form.FindName('lblGreeting')
$txtName=$form.FindName('txtName')

#add an event handler
$btnPersonalize.Add_Click({$lblGreeting.Content="Hello, $($txtName.Text)"})

$form.ShowDialog() | out-null