# Example showing how to use a DockPanel and the DockPanel.Dock attached properties!

Window {
    DockPanel {
        Menu Top -contents {
            MenuItem Menu5 -Contents {
                MenuItem Item1 -action {write-host "item1"}
                MenuItem Item2 -action {write-host "item2"}
                Separator
                MenuItem Item3 -action {write-host "item3"}
            }
        }
        StatusBar {Label Hi
            Separator
            Label 'From the Statusbar'}  -Property @{horizontalalignment = 'Center'; 'DockPanel.Dock' = 'Bottom'}
        Label 'Left' -property @{verticalalignment = 'Center'; 'DockPanel.Dock' = 'Left'}
        Label 'Right' -Property @{horizontalalignment = 'Right'; verticalalignment = 'Center'; 'DockPanel.Dock' = 'Right'}
        MultiLineTextBox Editor -property @{MinWidth = 200; MinHeight = 200}
       
    } -property @{VerticalAlignment = 'Stretch'; horizontalalignment = 'Stretch'; MinHeight = 200}
} -ShowForValue