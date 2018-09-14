Import-Module -Name WPFBot3000
$w=Window {
    Textbox Name
    Button Personalize -action { $greeting.Content="Hello, $($Name.Text)"}
    Label 'Hello, World' -name 'Greeting'
} -ShowForValue